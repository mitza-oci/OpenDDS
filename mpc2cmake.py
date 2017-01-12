#!/usr/bin/env python
import weakref
import os, sys, re, glob
import glob2, collections
import argparse
import operator
import textwrap


override_cmakefiles = False
project_directory = ""
root = None
package = ""
requires_dict = {}
cmake_file_preemble = '''

project({0} CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT {1})
  find_package({2} REQUIRED CONFIG)
endif()
'''
common_target_properties = ["output_name", "package", "compile_definitions", "requires", "folder", "features"]
common_exe_properties = common_target_properties + ["include_directories", "link_libraries"]
common_lib_properties = common_target_properties + ["define_symbol", "public_include_directories", "public_link_libraries"]

def enum(*sequential, **named):
  enums = dict(zip(sequential, range(len(sequential))), **named)
  reverse = dict((value, key) for key, value in enums.iteritems())
  enums['reverse_mapping'] = reverse
  return type('Enum', (), enums)

ProjectBase = enum('ACE', 'TAO', 'OpenDDS')

def string_in_files(str, files):
  for f in files:
    if str in open(f).read():
      return True
  return False


def list_difference(a,b):
  return [x for x in a if x not in b]

def flatten_list(lists):
  return [item for sublist in lists for item in sublist]


class IdlFileGroup:
  def __init__(self):
    self.idlflags_plus = []
    self.idlflags_minus= []
    self.files = []

class MPCNode:
  patterns = {
    'exename': re.compile("exename\s*=\s*([^\s]+)"),
    'libname': re.compile("(shared|static)name\s*=\s*([^\s]+)"),
    'dynamicflags': re.compile("dynamicflags\s*\+=\s*(\w+)"),
    'after' : re.compile("after\s*\+=\s*(.+)$"),
    'libs' : re.compile("libs\s*\+=\s*(.+)$"),
    'idlflags' : re.compile("idlflags\s*\+=\s*(.+)$"),
    'idlflags_minus' : re.compile("idlflags\s*\-=\s*(.+)$"),
    'dcps_ts_flags' : re.compile("dcps_ts_flags\s*\+=\s*(.+)$"),
    'requires' : re.compile("requires\s*\+=\s*(.+)$"),
    'avoids' : re.compile("avoids\s*\+=\s*(.+)$"),
    'pch_header' : re.compile("pch_header\s*=\s*(.*)$"),
    'pch_source' : re.compile("pch_source\s*=\s*(.*)$"),
    'includes' : re.compile("includes\s*\+=\s*(.*)$"),
    'custom_only' : re.compile("custom_only\s*=\s*1$")
  }


  def __init__(self, content):
    self.content = content
    self.children = []

  def add_child(self, node):
    self.children.append(node)
    node.parent = weakref.ref(self)

  def expand_target_name(self, target_name):
    names = target_name.split('*')
    if len(names) == 2:
      names[1] = names[1].capitalize()
    result = ("_" + self.parent().prefix + "_").join(names)

    if target_name.startswith('*'):
      result=result[1:]
    if target_name.endswith('*'):
      result=result[0:-1]
    return result

  def add_lib(self, libname):
    if libname.startswith(package+"_"):
      self.internal_libs.add(libname)
    else:
      self.external_libs.add(libname)

  def normalize_mpc_project(self):
    project_pattern = re.compile("project\s*(\([^\)]*\))?\s*(:(.+))?")
    match = project_pattern.match(self.content)
    if match:
      self.after = []
      self.internal_libs = []
      self.source_files = None # None means GLOB, [] means empty
      self.header_files = []
      self.inline_files = []
      self.template_files = []
      self.define_symbol= ""
      self.external_libs = set()
      self.dependents = []
      self.requires = set()
      self.skip_when_unavailable_libs = set()
      self.project_base = ProjectBase.ACE
      self.is_exe = False
      self.tao_idl_flags_minus = []
      self.idl_flags = []
      self.idl_files = []
      self.typesupports = []
      self.tao_idl_flags = []
      self.dds_idl_flags = []
      self.internal_libs = set()
      self.includes = []
      self.custom_only = False
      self.generated_files = set()
      self.compile_definitions = set()
      self.is_face = False
      self.install_this_target =False
      self.idl_file_groups = []
      self.features = set()
      self.conditional_sources = {}
      self.install_only_files = []

      if root:
        self.folder = os.path.relpath(self.parent().dir, root)

      self.target_properties = []

      target_name, _, target_bases = match.groups()
      if target_name:
        ## remove the parenthesis around project name
        target_name = target_name[1:-1].strip()
        target_name = target_name.replace(" ", "_")
        self.name = self.expand_target_name(target_name)
      else:
        self.name = self.parent().prefix

      if target_bases != None:
        self.target_bases = set([ dep.strip() for dep in target_bases.split(',')])
      else:
        self.target_bases = set()

      self.parse_mpc_project_content()

      if not hasattr(self,'output_name'):
        self.output_name = self.name

      self.handle_mpc_project_bases()

    else:
      sys.stderr.write("%s doesnot match project_pattern\n"% self.content)
      exit(1)

  def handle_mpb_ace_tkreactor(self):
      self.add_lib('ACE_TkReactor')

  def handle_mpb_ace_xtreactor(self):
    self.add_lib('ACE_XtReactor')

  def handle_mpb_ace_mc(self):
    self.add_lib('ACE_Monitor')

  def handle_mpb_ace_flreactor(self):
    self.add_lib('ACE_FlReactor')

  def handle_mpb_ace_foxreactor(self):
    self.add_lib('ADE_FoxReactor')

  def handle_mpb_ace_etcl(self):
    self.add_lib('ADE_ETCL')

  def handle_mpb_qos(self):
    self.add_lib('ACE_QoS')

  def handle_mpb_ssl(self):
    self.add_lib('ACE_SSL')

  def handle_mpb_wfmo(self):
    self.requires.add('WIN32')

  def handle_mpb_winreistry(self):
    self.requires.add('WIN32')

  def handle_mpb_ace_xtreactor(self):
    self.add_lib('ACE_XtReactor')

  def handle_mpb_ace_mfc(self):
    self.requires.add('MFC_FOUND')
    self.parent().find_packages.add('MFC')

  def handle_mpb_aceexe(self):
    self.is_exe = True

  def handle_mpb_acelib(self):
    pass

  def handle_mpb_orbsvcsexe(self):
    self.handle_mpb_taoexe()
    self.handle_mpb_negotiate_codesets()
    self.handle_mpb_anytypecode()
    self.parent().find_packages.add('TAO_orbsvcs REQUIRED CONFIG')

  def handle_mpb_orbsvcslib(self):
    self.handle_mpb_anytypecode()
    self.tao_idl_flags.append("-I${TAO_ROOT}/orbsvcs")
    self.parent().find_packages.add('TAO_orbsvcs REQUIRED CONFIG')

  def handle_mpb_anytypecode(self):
    self.handle_mpb_taolib()
    self.handle_mpb_taoidldefaults()
    self.add_lib('TAO_AnyTypeCode')
    self.tao_idl_flags_minus.append(['-Sa', '-St'])

  def handle_mpb_ftorb(self):
    self.handle_mpb_orbsvcslib()
    self.add_lib('TAO_FT_ClientORB')
    self.add_lib('TAO_FT_ServerORB')

  def handle_mpb_conv_lib(self):
    self.install_this_target = True

  def handle_mpb_install_bin(self):
    self.install_this_target = True

  def handle_mpb_install_lib(self):
    self.install_this_target = True

  def handle_mpb_install(self):
    self.install_this_target = True

  def handle_mpb_threads(self):
    self.requires.add('ACE_HAS_THREADS')

  def handle_mpb_valuetype(self):
    self.handle_mpb_anytypecode()
    self.handle_mpb_avoids_corba_e_micro()
    self.add_lib('TAO_Valuetype')

  def handle_mpb_ifr_client(self):
    self.handle_mpb_anytypecode()
    self.add_lib('TAO_IFR_Client')

  def handle_mpb_rtcorba(self):
    self.handle_mpb_pi()
    self.requires.add('RT_CORBA')
    self.add_lib('TAO_RTCORBA')

  def handle_mpb_avoids_corba_e_micro(self):
    self.requires.add('"NOT CORBA_E_COMPACT"')

  def handle_mpb_avoids_minimum_corba(self):
    self.requires.add('"NOT MINIMUM_CORBA"')

  def handle_mpb_avoids_corba_e_compact(self):
    self.requires.add('"NOT CORBA_E_MICRO"')

  def handle_mpb_iormanip(self):
    self.handle_mpb_portableserver()
    self.handle_mpb_valuetype()
    self.add_lib('TAO_IORManip')

  def handle_mpb_objreftemplate(self):
    self.add_lib('TAO_ObjRefTemplate')

  def handle_mpb_svc_utils(self):
    self.handle_mpb_orbsvcslib()
    self.add_lib('TAO_Svc_Utils')

  def handle_mpb_iortable(self):
    self.add_lib('TAO_IORTable')

  def handle_mpb_portableserver(self):
    self.add_lib('TAO_PortableServer')

  def handle_mpb_corba_messaging(self):
    self.requires.add('CORBA_MESSAGING')

  def handle_mpb_messaging_optional(self):
    self.external_libs.add('${OPTIONAL_Messaging}')

  def handle_mpb_taoidldefaults(self):
    self.tao_idl_flags= ["-Sa", "-St"] + self.tao_idl_flags

  def handle_mpb_taolib_with_idl(self):
    self.handle_mpb_taolib()
    self.handle_mpb_taoidldefaults()

  def handle_mpb_tao_versioning_idl_defaults(self):
    self.tao_idl_flags= ["${TAO_VERSIONING_IDL_FLAGS}", "-Sa", "-St"] + self.tao_idl_flags

  def handle_mpb_dynamicinterface(self):
    self.handle_mpb_avoids_minimum_corba()
    self.handle_mpb_avoids_corba_e_compact()
    self.handle_mpb_messaging()

  def handle_mpb_pi(self):
    self.handle_mpb_taolib()
    self.handle_mpb_codecfactory()
    self.add_lib('TAO_PI')

  def handle_mpb_csd_framework(self):
    self.handle_mpb_portableserver()
    self.handle_mpb_pi()
    self.handle_mpb_avoids_corba_e_micro()
    self.add_lib('TAO_CSD_Framework')

  def handle_mpb_csd_threadpool(self):
    self.handle_mpb_csd_framework()
    self.handle_mpb_threads()
    self.add_lib('TAO_CSD_ThreadPool')

  def handle_mpb_gen_ostream(self):
    self.features.add('GEN_OSTREAM')

  def handle_mpb_core_minimum_corba(self):
    self.features.add('MINIMUM_CORBA')

  def handle_mpb_dcps_test_lib(self):
    self.source_files = []
    self.header_files = []
    self.template_files = []
    self.inline_files = []

  def hanle_mpb_acexml(self):
    self.add_lib('ACEXML_Parser')

  def handle_mpb_pi_server(self):
    self.add_lib('TAO_PI_Server')

  def handle_mpb_dcpsexe(self):
    self.features.add("DCPS_DEFAULT_DISCOVERY")
    self.is_exe = True

  def handle_mpb_dcps_transports_for_test(self):
    self.features.add("DCPS_TRANSPORTS_FOR_TEST")

  def handle_mpb_mc_test_utils(self):
    self.internal_libs.add('MC_Test_Utilities')

  def handle_mpb_dcps_monitor(self):
    self.add_lib("OpenDDS_monitor")

  def handle_mpb_dcps_test(self):
    self.internal_libs.add("TestFramework")

  def handle_mpb_dcps_inforepodiscovery(self):
    self.add_lib("OpenDDS_InfoRepoDiscovery")

  def handle_mpb_dcps_rtpsexe(self):
    self.add_lib("OpenDDS_Rtps")
    self.is_exe = True

  def handle_mpb_dcps_default_discovery(self):
    self.features.add("DCPS_DEFAULT_DISCOVERY")

  def handle_mpb_content_subscription(self):
    self.requires.add('CONTENT_SUBSCRIPTION')

  def handle_mpb_content_subscription_core(self):
    self.requires.add('CONTENT_SUBSCRIPTION_CORE')

  def handle_mpb_opendds_face(self):
    self.add_lib('OpenDDS_FACE')
    self.is_face = True

  def handle_mpb_dds_model(self):
    self.add_lib('OpenDDS_Model')

  def handle_mpb_dcps_qos_xml_handler(self):
    self.add_lib('OpenDDS_QOS_XML_XSC_Handler')

  def handle_mpb_taoexe(self):
    self.handle_mpb_link_codecfactory()
    self.internal_libs.add("TAO")
    self.is_exe = True

  def handle_mpb_taolib(self):
    self.handle_mpb_link_codecfactory()
    self.internal_libs.add("TAO")

  def handle_mpb_nolink_codecfactory(self):
    # self.features.remove('LINK_CODECFACTORY')
    pass

  def handle_mpb_link_codecfactory(self):
    # self.features.add('LINK_CODECFACTORY')
    pass

  def handle_mpb_codecfactory(self):
    self.handle_mpb_taolib()
    self.handle_mpb_anytypecode()
    self.add_lib('TAO_CodecFactory')

  def handle_mpb_dcps_transports(self, base):
    self.external_libs.add("OpenDDS" + base[4:].title())

  def handle_mpb_ace_bzip2(self):
    self.external_libs.add("${BZIP2_LIBRARIES}")
    self.parent().find_packages.add('BZip2')
    requires_dict['BZIP2'] = '${BZIP2_FOUND}'

  def handle_mpb_compression(self):
    self.add_lib("TAO_Compression")

  def handle_mpb_ace_rlecompressionlib(self):
    self.add_lib('ACE_RLECompression')

  def handle_mpb_ace_zlib(self):
    self.external_libs.add("${ZLIB_LIBRARIES}")
    self.parent().find_packages.add('ZLib')
    requires_dict['ZLIB'] = '${ZLIB_FOUND}'

  def handle_mpb_ace_qt4reactor(self):
    self.add_lib('ACE_QtReactor')

  def handle_mpb_extra_core(self):
    self.conditional_sources['NOT MINIMUM_CORBA'] = ['Dynamic_Adapter.cpp']
    self.conditional_sources['CORBA_MESSAGING'] = ['Policy_Manager.cpp']

  def handle_mpb_extra_anytypecode(self):
    self.conditional_sources['NOT MINIMUM_CORBA'] = ['ServicesA.cpp']

  def handle_mpb_corba_messaging(self):
    self.requires.add('CORMBA_MESSAGING')
    self.add_lib('TAO_Messaging')

  def handle_mpb_messaging(self):
    self.handle_mpb_corba_messaging()

  def handle_mpb_messaging_optional(self):
    self.featires.add('CORBA_MESSAGING')

  def handle_mpc_project_bases(self):
    ignore_set = set(['avoids_ace_for_tao',
                     'dds_macros',
                     'dcps_ts_defaults',
                     'taolib_with_idl',
                     'coverage_optional',
                     'taoidldefaults',
                     'face_idl_test_config',
                     'ace_lib', 'dcps', 'dcpslib', 'tao_output', 'taodefaults',
                     'pidl_install', 'pidl'])

    feature_set = set([
      'corba_e_micro', 'corba_e_compact', 'minimum_corba', 'valuetype_out_indirection', 'tao_no_iiop',
      'optimize_collocated_invocations', 'negotiate_codesets'
    ])

    for base in list(self.target_bases):
      handler = getattr(self, 'handle_mpb_'+ base, None)
      if handler:
        handler()
      elif base in ['dcps_tcp', 'dcps_udp', 'dcps_multicast', 'dcps_shmem', 'dcps_rtps_udp', 'dcps_rtps']:
        self.handle_mpb_dcps_transports(base)
      elif base in feature_set:
        self.features.add(base.upper())
      elif base not in ignore_set:
        sys.stderr.write("Warining: %s : the base project %s is not translated\n" % (self.name, base))

      if base.startswith('dcps') or base.startswith('opendds'):
        self.parent().project_base = max([ProjectBase.OpenDDS,self.parent().project_base])
        self.project_base = max([ProjectBase.OpenDDS,self.project_base])
        self.add_lib('OpenDDS_Dcps')

      elif base.startswith('tao') or base.startswith('orbsvcs'):
        self.parent().project_base = max([ProjectBase.TAO,self.parent().project_base])
        self.project_base = max([ProjectBase.TAO,self.project_base])

  def expand_file_list(self, list):
    result = []
    for x in list:
      if x.find('*') != -1:
        result.extend(glob.glob(x))
      else:
        result.append(x)
    return result

  def handle_idl_files(self, child):
    group = IdlFileGroup()

    for f in self.expand_file_list([ f.content for f in child.children ]):
      match =  MPCNode.patterns['idlflags'].match(f)
      if match:
        group.idlflags_plus = self.parse_idlflags(match)
        continue
      match = MPCNode.patterns['idlflags_minus'].match(f)
      if match:
        group.idlflags_minus = self.parse_idlflags(match)
        continue
      ## ignore every thing after ">>" which is only used by tao.mpc
      f = f.split(">>")[0].strip()
      target = self.parent().custom_only_target_contains_idl(f)
      if target:
        target.set_idl_target('targets', self)
      else:
        group.files.append(f)
    if 0 == len(group.idlflags_plus) + len(group.idlflags_minus):
      self.idl_files = group.files
    else:
      self.idl_file_groups.append(group)

  def parse_mpc_project_content(self):

    for child in self.children:
      if re.match("Source_Files(\([^\)]+\))*",child.content):
        if not self.source_files:
          self.source_files = []
        self.source_files += self.expand_file_list([ f.content for f in child.children ])
      elif child.content == "Header_Files":
        self.header_files += self.expand_file_list([ f.content for f in child.children ])
      elif child.content == "Inline_Files":
        self.inline_files += self.expand_file_list([ f.content for f in child.children ])
      elif child.content == "Template_Files":
        self.template_files += self.expand_file_list([ f.content for f in child.children ])
      elif child.content == 'TypeSupport_Files' or child.content == 'Typesupport_Files':
        for f in self.expand_file_list([ f.content for f in child.children ]):
          target = self.parent().custom_only_target_contains_idl(f)
          if target:
            target.set_idl_target('targets', self)
          else:
            self.typesupports.append(f)

      elif child.content == 'Idl_Files' or child.content == 'IDL_Files':
        self.handle_idl_files(child)
      elif child.content == 'PidlInstallWithoutBuilding_Files':
        self.install_only_files = [ f.content for f in child.children ]
      elif child.content == 'PIDL_Files':
        pass
      elif child.content == "specific (vc9, vc10, vc11, vc12, vc14)":
        self.msvc = [ f.content for f in child.children ]
      elif child.content == 'specific':
        for x in child.children:
          if not x.content.startswith("install_dir"):
            print("Warning: In {0} ({1}): {2} is not translated".format( self.parent().path, self.name, x.content ) )
      else:
        for name, value in MPCNode.patterns.iteritems():
          match = value.match(child.content)
          if match:
            method = getattr(self, "handle_" + name + "_pattern")
            method(match)
            break
        if not match:
          ignored_content_prefixes = ["libpaths ", "exeout", "libout", "dynamicflags" ]
          if not any([child.content.startswith(prefix) for prefix in ignored_content_prefixes]):
            print("Warning: In {0} ({1}): {2} is not translated".format( self.parent().path, self.name, child.content ) )

    if self.source_files == None:
      self.source_files = []
      for f in self.get_files('.cpp'):
        if f.endswith("_T.cpp"):
          self.template_files.append(f)
        else:
          self.source_files.append(f)

    h_files = self.get_files('.h')
    inl_files = self.get_files('.inl')

    for f in self.source_files + self.template_files:
      basename = os.path.splitext(f)[0]
      file = basename + ".h"
      if file in h_files and file not in self.header_files:
        self.header_files.append(file)
      file = basename + ".inl"
      if file in inl_files and file not in self.inline_files:
        self.inline_files.append(file)

    self.post_process_idl_files()

  def post_process_idl_files(self):
    if self.custom_only:
      self.targets = set()
      self.skel_targets = set()
      self.stub_targets = set()
      self.parent().add_custom_only_target(self)
    else:
      self.resolve_dependent_idls()

  def set_idl_target(self, target_type, target):
    self.__dict__[target_type].add(target.name)


  def resolve_dependent_idls(self):
    # parse the list of source files and return the list of files which are generated by idl compiler and the list corresponding idl files

    # the key of idls is the idl filename, type value contains the set of associated skel file in the source files list
    idls = {}
    for file in self.source_files:
      if file.endswith("C.cpp") or file.endswith("S.cpp") or file.endswith("A.cpp"):
        idls.setdefault(file[0:-5], set()).add(file)

    ignore_files_in_tao = set([
      'InterfaceDef',
      'InvalidName',
      'Object_Key',
      'Typecode_types',
      'WrongTransaction',
      'orb',
      'Muxed_TM',
      'Exclusive_TM'
    ])

    if len(idls):
      sources = set(self.source_files)
      for idl_file_base, cpp_files in idls.iteritems():
        dep_target =  self.parent().custom_only_target_contains_idl(idl_file_base)
        if dep_target:
          self.remove_generated_files_for_idl(idl_file_base)
          self.includes.append("${CMAKE_CURRENT_BINARY_DIR}")
          if len(cpp_files) >=2:
            dep_target.set_idl_target('targets', self)
          else:
            f = cpp_files.pop()
            if f.endswith("C.cpp"):
              dep_target.set_idl_target('stub_targets', self)
            elif f.endswith("S.cpp"):
              dep_target.set_idl_target('skel_targets', self)
            elif f.endswith("A.cpp"):
              dep_target.set_idl_target('anyop_targets', self)
        elif not (idl_file_base in ignore_files_in_tao):
            print("Warning: cannot find target processing {}.idl".format(idl_file_base))

  def all_idl_files(self):
    return self.idl_files + flatten_list([ x.files for x in self.idl_file_groups]) + self.typesupports

  def handle_exename_pattern(self, match):
    if match.group(1) != "*":
      self.output_name = match.group(1)
    self.is_exe = True

  def handle_libname_pattern(self, match):
    if match.group(2) != "*":
      self.output_name = self.expand_target_name(match.group(2))

  def handle_dynamicflags_pattern(self, match):
    self.define_symbol = match.group(1)

  def handle_after_pattern(self, match):
    self.after += [self.expand_target_name(name) for name in match.group(1).split()]

  def handle_libs_pattern(self, match):
    self.internal_libs |= set([self.expand_target_name(lib) for lib in match.group(1).split()])

  def parse_idlflags(self, match):
    flags = [f for f in match.group(1).split() if f != "-I$(DDS_ROOT)"]
    # replace every occurance of "$(ABC)" to "${ABC}"
    return [re.sub(r'\$\((\w+)\)', r'${\1}', flag) for flag in flags ]

  def handle_idlflags_pattern(self, match):
    self.tao_idl_flags += self.parse_idlflags(match)

  def handle_idlflags_minus_pattern(self, match):
    self.tao_idl_flags_minus = match.group(1).split()

  def handle_dcps_ts_flags_pattern(self, match):
    self.dds_idl_flags += match.group(1).split()
    # for flag in  match.group(1).split():
    #   if not (flag.startswith("-Wb,stub_export_include=") or flag.startswith("-Wb,export_include=") or  flag.startswith("-Wb,stub_export_macro=") or  flag.startswith("-Wb,export_macro=")):
    #     self.dds_idl_flags.append(flag)

  def handle_requires_pattern(self, match):
    self.requires = self.requires.union(set([ x.upper() for x in match.group(1).split()]))

  def handle_avoids_pattern(self, match):
    self.requires = self.requires.union([ '"NOT %s"' % x.upper() for x in match.group(1).split()])

  def handle_includes_pattern(self, match):
    self.includes.extend( [re.sub(r'\$\((\w+)\)', r'${\1}', path) for path in match.group(1).split() ])

  def handle_pch_header_pattern(self, match):
    pass

  def handle_pch_source_pattern(self, match):
    pass

  def handle_custom_only_pattern(self,match):
    self.custom_only = True
    self.source_files = []
    self.header_files = []
    self.inline_files = []
    self.template_files = []

  def get_files(self, file_extension):
    file_pattern = self.parent().dir + "/*" + file_extension
    return [os.path.basename(p) for p in glob.glob(file_pattern)]

  def set_path(self, path):
    self.path = path

  def resolve_libs(self, project):
    for lib in self.internal_libs:
      if lib in project.libs_index_by_output_name:
        dependee = project.find_target_by_output_name(lib, self.path)
        self.external_libs.add(dependee.name)
        dependee.dependents.append(self)
        project.set_dependency(self, dependee)
      else:
        sys.stderr.write("Warining: %s has an unresolved dependency on lib %s, treated as imported target\n" % (self.name, lib))
        self.external_libs.add(lib)

    # if 'TAO_CodecFactory' not self.internal_libs:
    #   # TAO_CodecFactory is only added when codefactory.mpb is inherited,
    #   # in this case, LINK_CODEFACTORY feature should be ignored
    #   self.feature.discard('LINK_CODECFACTORY')
    #
    # if 'LINK_CODECFACTORY' in self.features:
    #   if package == 'TAO':
    #     dependee = project.find_target_by_output_name('TAO_CodecFacotry', self.path)
    #     if dependee:
    #       dependee.dependents.append(self)
    #       project.set_dependency(self, dependee)


  def format_target_properties_in_list(self, properties):
    result = ""
    for prop_name in properties:
      try:
        prop_value = getattr(self, prop_name)
        if len(prop_value):
          line = "  %s " % prop_name.upper()
          indent = len(line)
          if hasattr(prop_value, '__iter__'):
            prop_value = list(prop_value)
            line += prop_value[0]
            for item in prop_value[1:]:
              line += "\n" + ' ' * indent + item
          else:
            line += prop_value
          result += line + '\n'
      except:
        pass
    return result

  def format_idl_files_text(self):
    if not self.custom_only:
      self.targets = [self.name]

    if len(self.typesupports):
      self.idl_files = self.typesupports
      properties_text = self.format_target_properties_in_list([ "targets", "dds_idl_flags", "tao_idl_flags", "idl_files" ])
      if self.is_face:
        return "add_face_idl_files(\n{0})\n".format(properties_text)
      else:
        return "dds_idl_sources(\n{0})\n".format(properties_text)
    elif len(self.idl_files):
      self.idl_flags = self.tao_idl_flags
      return "tao_idl_sources(\n{0})\n".format(self.format_target_properties_in_list([ "targets", "stub_targets", "skel_targets", "anyop_targets", "idl_flags", "idl_files" ]))
    elif len(self.idl_file_groups):

      all_idlflags_minus = self.tao_idl_flags_minus + flatten_list([g.idlflags_minus for g in self.idl_file_groups])
      all_idlflags_plus =  list_difference(self.tao_idl_flags, all_idlflags_minus)

      for group in self.idl_file_groups:
        group.idlflags_plus = list_difference(all_idlflags_minus, self.tao_idl_flags_minus + group.idlflags_minus) + group.idlflags_plus

      result = "set({}_FLAGS {})\n".format(self.name, " ".join(all_idlflags_plus))
      for group in self.idl_file_groups:
        self.idl_flags = ["${%s_FLAGS}"%(self.name)] + group.idlflags_plus
        self.idl_files = group.files
        result += "tao_idl_sources(\n{0})\n".format(self.format_target_properties_in_list([ "targets", "stub_targets", "skel_targets", "idl_flags", "idl_files" ]))
      self.idl_files = []
      return result
    else:
      return ""

  def remove_generated_files_for_idl(self, idl_file):
    name_we = os.path.splitext(idl_file)[0]
    stub_file = name_we + "C.cpp"
    skel_file = name_we + "S.cpp"
    self.source_files = list_difference(self.source_files, [name_we + "C.cpp", name_we + "S.cpp",name_we + "S_T.cpp", name_we + "A.cpp"])
    self.header_files = list_difference(self.header_files, [name_we + "C.h", name_we + "S.h", name_we + "A.h"])
    self.inline_files = list_difference(self.inline_files, [name_we + "C.inl"])
    self.template_files = list_difference(self.template_files, [name_we + "S_T.cpp"])

  def remove_generated_files_from_sources(self):
    if self.project_base >= ProjectBase.TAO:
      for idl_file in self.idl_files:
        remove_generated_files_for_idl(idl_file)

  def cmake_text(self):
    result = ""

    self.include_directories = []
    for dir in self.includes:
      if dir.startswith('..'):
        self.include_directories.extend(["${CMAKE_CURRENT_SOURCE_DIR}/"+dir])
        if self.project_base >= ProjectBase.TAO:
          self.include_directories.extend(["${CMAKE_CURRENT_BINARY_DIR}/"+dir])
      else:
        self.include_directories.append(dir)

    self.remove_generated_files_from_sources()

    num_opendds_libs = sum(1 for lib in self.external_libs if  lib.startswith('OpenDDS'))
    if num_opendds_libs > 1:
      self.external_libs.discard('OpenDDS_Dcps')
    if num_opendds_libs  > 0:
      self.external_libs.discard('TAO')
      self.external_libs.discard('ACE')

    num_tao_libs = sum(1 for lib in self.external_libs if  lib.startswith('TAO'))
    if num_tao_libs > 1:
      self.external_libs.discard('TAO')
    if num_tao_libs > 0:
      self.external_libs.discard('ACE')


    if package and self.install_this_target:
      self.package = package

    if self.name == 'TAO':
      self.public_compile_definitions = ["${TAO_COMPILE_DEFINITIONS}"]

    if self.is_exe:
      self.link_libraries = self.external_libs
      result =  "add_ace_exe(%s\n" %  (self.name) + self.format_target_properties_in_list(common_exe_properties)+ ")\n"
    elif not self.custom_only:
      self.public_link_libraries = self.external_libs
      self.public_include_directories = self.include_directories
      result = "add_ace_lib(%s\n" %  (self.name) + self.format_target_properties_in_list(common_lib_properties)+ ")\n"

    if len(self.source_files) + len(self.header_files) + len(self.inline_files) + len(self.template_files):
      result += "target_cxx_sources(%s\n" % self.name + self.format_target_properties_in_list(["source_files", "header_files", "inline_files", "template_files"])+ ")\n";

    for cond, sources in self.conditional_sources:
      result += "if({0})\n  target_cxx_sources({1}\n. SOURCE_FILES {2}\n. )\nendif()\n".format(cond, self.name,"\n               ".join(sources))

    result += self.format_idl_files_text()

    if len(self.install_only_files):
      result += "install_package_files({}\n  {}\n)\n".format(self.package, "\n  ".join(self.install_only_files))

    if hasattr(self, 'msvc'):
      for line in  self.msvc:
        pattern = re.compile("compile_flags\s*\+=\s*(.+)$")
        match = pattern.match(line)
        if match:
          result += "if (MSVC)\n  target_compile_options({0} {1})\nendif()\n".format(self.name, match.group(1))
        else:
          print("Warning: In {0} ({1}): {2} is not translated".format( self.parent().path, self.name, line ) )

    return result


class CMakeProjectNode:
  def __init__(self, path, project):
    self.path = path
    self.dir, self.name = os.path.split(os.path.abspath(path))
    self.prefix = os.path.splitext(self.name)[0]
    self.children = []
    self.depends = []
    self.dependents = []
    self.mpc_child = None
    self.find_packages = set()
    self.project_base = ProjectBase.ACE
    self.idl_to_target = {}

    self.parse_mpc()
    for target in self.children:
      target.set_path(self.path)
      if not target.is_exe:
        project.add_lib_target(target)

  def parse_mpc(self):
    cur = self
    line = ""
    with open(self.path) as f:
      for raw_line in f:
        # remove comment and leading/trailing whitespaces
        line += raw_line.split("//", 2)[0].strip()
        if line:
          if line.endswith('{'):
            new_child = MPCNode(line[0:-1].strip())
            cur.add_child(new_child)
            cur = new_child
          elif line == '}':
            cur = cur.parent()
          elif line.endswith('\\'):
            line = line[:-1] + " "
            continue
          else:
            cur.add_child(MPCNode(line))
        line = ""

    for target in self.children:
      target.normalize_mpc_project()

    non_custom_only_children = [ x for x in self.children if not x.custom_only ]

    self.requires = set.intersection(*[x.requires for x in non_custom_only_children])
    for child in non_custom_only_children:
      child.requires = child.requires - self.requires

  def get_project_base_text(self):
    return ProjectBase.reverse_mapping[self.project_base]

  def add_child(self, node):
    self.children.append(node)
    node.parent = weakref.ref(self)

  def resolve_dependencies(self, project):
    if self.children:
      for target in self.children:
        target.resolve_libs(project)

      custom_only_targets = set(self.idl_to_target.values())
      reordered_children = []
      for target in self.children:
        if target not in custom_only_targets:
          reordered_children.append(target)
      reordered_children.extend(custom_only_targets)
      self.children = reordered_children



  def requires_text(self):
    def translate_require(cond):
      print("translate %s" % cond)
      return requires_dict[cond] if cond in requires_dict else cond

    condition_text=" ".join([ translate_require(cond) for cond in self.requires] )

    if len(condition_text):
      return '\nrequires(%s)\n' % condition_text
    return ""

  def cmake_text(self):
    return '\n'.join([ "find_package(%s)" % pakcage for pakcage in self.find_packages ] ) + "\n" + \
           self.requires_text() + "\n" + \
           '\n'.join([ target.cmake_text() for target in self.children] )

  def gen_node_text(self):

    if len(self.depends)==0:
      for dependent in self.dependents:
        dependent.depends.remove(self)
      return self.cmake_text()
    return None

  def generate_cmake(self):
    self.gen_node_text()

  def set_dependency(self, dependent, dependee):
    pass

  def custom_only_target_contains_idl(self, file_base):
    return self.idl_to_target.get(file_base + ".idl") or self.idl_to_target.get(file_base + ".pidl")

  def add_custom_only_target(self,target):
    for idl in target.all_idl_files():
      print("add_custom_only_target %s" % idl)
      self.idl_to_target[idl] = target
      # print("add_custom_only_target   %s -> %s" % (idl, target.name))


  def get_project_base(self):
    self.local_dependencies_only = (len(self.depends) + len(self.dependents)) == 0
    return self.project_base

class CMakeDirNode:
  def __init__(self, path, project):
    self.path = path
    self.name = os.path.basename(path)
    self.children = {}
    self.depends = []
    self.dependents = []
    self.mpc_child = None
    self.local_dependencies_only = True
    self.project_base = ProjectBase.ACE

  def cmake_text(self):
    self.generate_cmake()
    return  "add_subdirectory(%s)\n" % self.name

  def gen_node_text(self):
    if len(self.depends)==0:
      for dependent in self.dependents:
        dependent.depends.remove(self)
      return self.cmake_text()
    return None

  def get_project_base(self):
    self.local_dependencies_only = (len(self.depends) + len(self.dependents)) == 0
    self.project_base = max( [ child.get_project_base() for child in self.children.values() ] )
    return self.project_base

  def get_project_base_text(self):
    return ProjectBase.reverse_mapping[self.project_base]

  def generate_cmake(self):
    processed_children = set()
    remaining_children = set(self.children.values())

    if self.mpc_child:
      proj_name = os.path.splitext(self.mpc_child.name)[0]
    elif self.name != "":
      proj_name = self.name
    else:
      proj_name = os.path.basename(os.getcwd())

    filename = os.path.join(self.path,  "CMakeLists.txt")

    if os.path.exists(filename) and not override_cmakefiles:
      sys.stderr.write("Skip writing %s becuase it exists\n" % filename)
      return

    with open(filename, "w") as f:
      if self.local_dependencies_only:
        project_base = self.get_project_base_text()
        project_root = project_base[-3:] + "_ROOT"
        f.write(cmake_file_preemble.format(proj_name, project_root, project_base))
        # if self.mpc_child.project_base == ProjectBase.OpenDDS:
        #   f.write("include(${DDS_ROOT}/cmake/AddDdsTest.cmake)\n")

      while len(remaining_children) != 0:
        for child in remaining_children:
          text = child.gen_node_text()
          if text:
            f.write(text)
            processed_children.add(child)
        remaining_children -= processed_children

        # if self.mpc_child and any([target.is_exe for target in self.mpc_child.children]):
        #   perl_files = glob.glob( os.path.join(self.path, '*.pl'))
        #   if len(perl_files):
        #     f.write("#####################################\n")
        #     f.write("link_test_files_to_build_tree()")

        # for conf_file in glob.glob(os.path.join(self.path , "*.conf")):
        #   f.write("configure_file({0} {0} COPYONLY)\n".format(os.path.basename(conf_file)))
        #
        # for xml_file in glob.glob(os.path.join(self.path , "*.xml")):
        #   f.write("configure_file({0} {0} COPYONLY)\n".format(os.path.basename(xml_file)))

class cmake_project:
  def __init__(self, path):
    if path:
      os.chdir(path)
    self.internal_libs_index_by_name = {}
    self.internal_libs_index_by_output_name = {}
    self.hierarchy = CMakeDirNode("", self)
    leaves = [ self.parse_mpc_file(mpc_file) for mpc_file in glob2.glob("**/*.mpc")]
    leaves = [x for x in leaves if x is not None]
    for leaf in leaves:
      leaf.resolve_dependencies(self)

  def add_lib_target(self, lib):
    self.internal_libs_index_by_name[lib.name] = lib
    self.internal_libs_index_by_output_name.setdefault(lib.output_name, []).append(lib)

  def find_target_by_output_name(self, output_name, caller_path):
    r = self.internal_libs_index_by_output_name[output_name]
    if len(r):
      return r[0]
    else:
      ### more than one target have the same output name, we have to use the target
      ## that resides in the directory which is closer to the finder
      common_prefixe_lens =  [ len(os.path.commonprefix(caller_path, lib.path)) for lib in r ]
      max_index, max_value = max(enumerate(common_prefixe_lens), key=operator.itemgetter(1))
      return r[max_index]

  def parse_mpc_file(self, path):
    node = self.hierarchy
    p = ""
    for path_component in path.split('/')[0:-1]:
      p = os.path.join(p, path_component)
      node = node.children.setdefault(path_component, CMakeDirNode(p, self) )

    mpc_child = node.children.setdefault(os.path.basename(path), CMakeProjectNode(path, self) )

    if node.mpc_child:
      sys.stderr.write("We don't support more than one MPC files in a directory, %s is ignored\n" % node.path)
      exit(1)
    else:
      node.mpc_child = mpc_child
    return mpc_child

  def find(self, name):
    # remve trailing /

    if name=="":
      return self.hierarchy

    if name.endswith('/'):
      name = name[0:-1]

    components = name.split('/')
    node = self.hierarchy
    for comp in components:
      node = node.children[comp]
    return node

  def set_dependency(self, dependent_target, dependee_target):
    common_dir = os.path.dirname(os.path.commonprefix([dependent_target.path, dependee_target.path]))
    common_node = self.find(common_dir)

    common_dir_len = 0 if common_dir == "" else len(common_dir) + 1

    dependee_name = dependee_target.path[common_dir_len:].split('/')[0]
    dependent_name = dependent_target.path[common_dir_len:].split('/')[0]

    dependee_node = common_node.children[dependee_name]
    dependent_node = common_node.children[dependent_name]

    if dependee_node != dependent_node:
      dependee_node.dependents.append(dependent_node)
      dependent_node.depends.append(dependee_node)


  def generate_cmake_files(self):
    self.hierarchy.get_project_base()
    self.hierarchy.generate_cmake()

def main():
  parser = argparse.ArgumentParser(description='Convert MPC files into CMake files.')
  parser.add_argument('-o', '--override',action='store_true', default=False, help='override existing CMakefile.txt')
  parser.add_argument('-r', '--root', default=False, help='project root')
  parser.add_argument('-p', '--package', default="", help='default package')
  parser.add_argument('path', nargs='?', default=os.getcwd(), help='the directory to convert')
  args = parser.parse_args()
  global override_cmakefiles
  global project_directory
  global root
  global package

  override_cmakefiles = args.override
  project_directory = os.path.abspath(args.path)
  root = os.path.abspath(args.root)
  package = args.package

  proj = cmake_project(args.path)
  proj.generate_cmake_files()

if __name__ == "__main__":
  main()

