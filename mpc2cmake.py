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
cmake_file_preemble = '''
project({0} CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT {1})
  find_package({2} REQUIRED CONFIG)
endif()
'''
common_target_properties = ["output_name", "source_files", "compile_definitions", "header_files", "inline_files", "template_files", "requires", "folder"]
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
    result = target_name.replace('*', "_" + self.parent().prefix + "_")
    if target_name.startswith('*'):
      result=result[1:]
    if target_name.endswith('*'):
      result=result[0:-1]
    return result

  def normalize_mpc_project(self):
    project_pattern = re.compile("project\s*(\([^\)]*\))?\s*(:(.+))?")
    match = project_pattern.match(self.content)
    if match:
      self.after = []
      self.libs = []
      self.source_files = None # None means GLOB, [] means empty
      self.header_files = []
      self.inline_files = []
      self.template_files = []
      self.define_symbol= ""
      self.link_targets = set()
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
      self.libs = []
      self.includes = []
      self.custom_only = False
      self.generated_files = set()
      self.compile_definitions = set()
      self.is_face = False
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

  def handle_mpc_project_bases(self):
    ignore_set = set(['avoids_ace_for_tao', 'dds_macros', 'dcps_ts_defaults', 'taolib_with_idl', 'coverage_optional', 'taoidldefaults', 'face_idl_test_config'])

    bases = list(self.target_bases)
    for base in bases:
      if 'ace_mc' == base:
        self.requires.add('"TARGET ACE_Monitor"')
        self.link_targets.add('ACE_Monitor')
      elif 'qos' == base:
        self.requires.add('"TARGET ACE_QoS"')
        self.link_targets.add('ACE_QoS')
      elif 'ssl' == base:
        self.requires.add('"TARGET ACE_SSL"')
        self.link_targets.add('ACE_SSL')
      elif 'wfmo' == base or 'winregistry' == base:
        self.requires.add('WIN32')
      elif 'ace_xtreactor' == base:
        self.requires.add('"TARGET ACE_XtReactor"')
        self.link_targets.add('ACE_XtReactor')
      elif 'ace_mfc' == base:
        self.requires.add('MFC_FOUND')
        self.parent().find_packages.add('MFC')
      elif 'aceexe' == base:
        self.is_exe = True
      elif 'acelib' == base:
        pass
      elif 'orbsvcsexe' == base:
        self.is_exe = True
        self.link_targets.add('TAO_Codeset')
        self.compile_definitions.add('TAO_EXPLICIT_NEGOTIATE_CODESETS')
        self.parent().find_packages.add('TAO_orbsvcs REQUIRED CONFIG')
      elif 'ftorb' == base:
        self.link_targets.add('TAO_FT_ClientORB')
        self.link_targets.add('TAO_FT_ServerORB')
        self.parent().find_packages.add('TAO_orbsvcs REQUIRED CONFIG')
      elif 'iormanip' == base:
        self.link_targets.add('TAO_IORManip')
      elif 'svc_utils' == base:
        self.link_targets.add('TAO_Svc_Utils')
        self.parent().find_packages.add('TAO_orbsvcs REQUIRED CONFIG')
      elif 'iortable' == base:
        self.link_targets.add('TAO_IORTable')
      elif 'portableserver' == base:
        self.link_targets.add('TAO_PortableServer')
      elif base in ['dcps', 'dcpslib']:
        pass
      elif 'dcps_test_lib' == base:
        self.source_files = []
        self.header_files = []
        self.template_files = []
        self.inline_files = []
      elif 'dcpsexe' == base:
        self.link_targets.add("${DCPS_DEFAULT_DISCOVERY_LIBS}")
        self.is_exe = True
      elif 'dcps_transports_for_test' == base:
        self.link_targets.add('${DCPS_TRANSPORTS_FOR_TEST}')
      elif 'mc_test_utils' == base:
        self.libs.append('MC_Test_Utilities')
      elif base in ['dcps_tcp', 'dcps_udp', 'dcps_multicast', 'dcps_shmem', 'dcps_rtps_udp', 'dcps_rtps']:
        self.link_targets.add("OpenDDS" + base[4:].title())
      elif 'dcps_monitor' == base:
        self.link_targets.add("OpenDDS_monitor")
      elif 'dcps_test' == base:
        self.libs.append("TestFramework")
      elif 'dcps_inforepodiscovery' == base:
        self.link_targets.add("OpenDDS_InfoRepoDiscovery")
      elif 'dcps_rtpsexe' == base:
        self.link_targets.add("OpenDDS_Rtps")
        self.is_exe = True
      elif 'dcps_default_discovery' == base:
        self.link_targets.add("${DCPS_DEFAULT_DISCOVERY_LIBS}")
      elif 'content_subscription' == base:
        self.requires.add('CONTENT_SUBSCRIPTION')
      elif 'content_subscription_core' == base:
        self.requires.add('CONTENT_SUBSCRIPTION_CORE')
      elif 'opendds_face' == base:
        self.link_targets.add('OpenDDS_FACE')
        self.is_face = True
      elif 'dds_model' == base:
        self.link_targets.add('OpenDDS_Model')
      elif 'dcps_qos_xml_handler' == base:
        self.link_targets.add('OpenDDS_QOS_XML_XSC_Handler')
        self.requires.add('"TARGET OpenDDS_QOS_XML_XSC_Handler"')
      elif 'taoexe' == base:
        self.is_exe = True
      elif base not in ignore_set:
        sys.stderr.write("Warining: %s : the base project %s is not translated\n" % (self.name, base))

      if base.startswith('dcps') or base.startswith('opendds'):
        self.parent().project_base = max([ProjectBase.OpenDDS,self.parent().project_base])
        self.project_base = max([ProjectBase.OpenDDS,self.project_base])
        self.link_targets.add('OpenDDS_Dcps')

      elif base.startswith('tao') or base.startswith('orbsvcs'):
        self.parent().project_base = max([ProjectBase.TAO,self.parent().project_base])
        self.project_base = max([ProjectBase.TAO,self.project_base])
        self.link_targets.add('TAO')

  def expand_file_list(self, list):
    return list

  def parse_mpc_project_content(self):
    for child in self.children:
      if child.content == "Source_Files":
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
        for f in self.expand_file_list([ f.content for f in child.children ]):
          target = self.parent().custom_only_target_contains_idl(f)
          if target:
            target.set_idl_target('targets', self)
          else:
            self.idl_files.append(f)

      elif child.content == "specific (vc9, vc10, vc11, vc12, vc14)":
        self.msvc = [ f.content for f in child.children ]
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

    if len(self.typesupports) == 0:
      self.dds_idl_flags = []
      self.tao_idl_flags = []

    self.post_process_custom_only()

  def post_process_custom_only(self):
    if self.custom_only:
      self.targets = []
      self.skel_targets = []
      self.stub_targets = []
      self.parent().add_custom_only_target(self)
    else:
      # new_tao_idl_flags = []
      # for flag in  self.tao_idl_flags:
      #   if flag.startswith("-Wb,stub_export_include=") or flag.startswith("-Wb,export_include="):
      #     self.export_file = flag.split('=',1)[1]
      #   elif not flag.startswith("-Wb,stub_export_macro=") and not  flag.startswith("-Wb,export_macro="):
      #     new_tao_idl_flags.append(flag)
      # self.tao_idl_flags = new_tao_idl_flags
      #
      # new_dds_idl_flags = []
      # for flag in  self.dds_idl_flags:
      #   if not (flag.startswith("-Wb,stub_export_include=") or flag.startswith("-Wb,export_include=") or  flag.startswith("-Wb,stub_export_macro=") or  flag.startswith("-Wb,export_macro=")):
      #     self.dds_idl_flags.append(flag)
      # self.dds_idl_flags= new_dds_idl_flags

      self.resolve_dependent_idls()

  def set_idl_target(self, target_type, target):
    self.__dict__[target_type].append(target.name)


  def resolve_dependent_idls(self):
    # parse the list of source files and return the list of files which are generated by idl compiler and the list corresponding idl files

    # the key of idls is the idl filename, type value contains the set of associated skel file in the source files list
    idls = {}

    for file in self.source_files:
      if file.endswith("C.cpp") or file.endswith("S.cpp"):
        idl_file = file[0:-5] + ".idl"
        if idls.get(idl_file):
          idls[idl_file].add( file )
        else:
          idls[idl_file] = set([idl_file])

    if len(idls):
      sources = set(self.source_files)

      for idl_file, cpp_files in idls.iteritems():
        dep_target =  self.parent().custom_only_target_contains_idl(idl_file)
        if dep_target:
          sources = sources - cpp_files
          self.includes.append("${CMAKE_CURRENT_BINARY_DIR}")
          if len(cpp_files) ==2:
            dep_target.set_idl_target('targets', self)
          elif cpp_files.pop().endswith("C.cpp"):
            dep_target.set_idl_target('stub_targets', self)
          elif cpp_files.pop().endswith("S.cpp"):
            dep_target.set_idl_target('skel_targets', self)

      self.source_files = list(sources)

  def contains_idl_file(file):
    return self.idl_files != None and file in self.idl_files

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
    self.libs.extend([self.expand_target_name(lib) for lib in match.group(1).split()])

  def handle_idlflags_pattern(self, match):
    self.tao_idl_flags += match.group(1).split()
    try:
      self.tao_idl_flags.remove("-I$(DDS_ROOT)")
    except:
      pass
    # replace every occurance of "$(ABC)" to "${ABC}"
    self.tao_idl_flags = [re.sub(r'\$\((\w+)\)', r'${\1}', flag) for flag in self.tao_idl_flags ]
    self.idl_flags = self.tao_idl_flags

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
    for lib in self.libs:
      if lib in project.libs_index_by_output_name:
        dependee = project.find_target_by_output_name(lib, self.path)
        self.link_targets.add(dependee.name)
        dependee.dependents.append(self)
        project.set_dependency(self, dependee)
      else:
        sys.stderr.write("%s has an unresolved dependency on lib %s\n" % (self.name, lib))

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
        return "add_dds_idl_files(\n{0})\n".format(properties_text)
    elif len(self.idl_files):
      return "add_tao_idl_files(\n{0})\n".format(self.format_target_properties_in_list([ "targets", "stub_targets", "skel_targets", "idl_flags", "idl_files" ]))
    return ""

  def remove_generated_files_from_sources(self):
    if self.project_base >= ProjectBase.TAO:
      for idl_file in self.idl_files:
        name_we = os.path.splitext(idl_file)[0]
        stub_file = name_we + "C.cpp"
        skel_file = name_we + "S.cpp"
        has_stub = stub_file in self.source_files
        has_skel = skel_file in self.source_files

        if has_stub:
          self.source_files.remove(stub_file)
        if has_skel:
          self.source_files.remove(skel_file)

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

    num_opendds_libs = sum(1 for lib in self.link_targets if  lib.startswith('OpenDDS'))
    if num_opendds_libs > 1:
      self.link_targets.discard('OpenDDS_Dcps')
    if num_opendds_libs  > 0:
      self.link_targets.discard('TAO')
      self.link_targets.discard('ACE')

    num_tao_libs = sum(1 for lib in self.link_targets if  lib.startswith('TAO'))
    if num_tao_libs > 1:
      self.link_targets.discard('TAO')
    if num_tao_libs > 0:
      self.link_targets.discard('ACE')

    if self.is_exe:
      self.link_libraries = self.link_targets
      result =  "add_ace_exe(%s\n" %  self.name + self.format_target_properties_in_list(common_exe_properties)+ ")\n"
    elif not self.custom_only:
      self.public_link_libraries = self.link_targets
      self.public_include_directories = self.include_directories
      result = "add_ace_lib(%s\n" % self.name + self.format_target_properties_in_list(common_lib_properties)+ ")\n"

    if hasattr(self, 'msvc'):
      for line in  self.msvc:
        pattern = re.compile("compile_flags\s*\+=\s*(.+)$")
        match = pattern.match(line)
        if match:
          result += "if (MSVC)\n  target_compile_options({0} {1})\nendif()\n".format(self.name, match.group(1))
        else:
          print("Warning: In {0} ({1}): {2} is not translated".format( self.parent().path, self.name, line ) )

    return result + self.format_idl_files_text()


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
            line = line[:-1]
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

      custom_only_targets = self.idl_to_target.values()
      reordered_children = []
      for target in self.children:
        if target not in custom_only_targets:
          reordered_children.append(target)
      reordered_children.extend(custom_only_targets)
      self.children = reordered_children

  def requires_text(self):
    condition_text = " ".join(self.requires)
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

  def custom_only_target_contains_idl(self, file):
    return self.idl_to_target.get(file)

  def add_custom_only_target(self,target):
    for idl in target.idl_files + target.typesupports:
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
    self.libs_index_by_name = {}
    self.libs_index_by_output_name = {}
    self.hierarchy = CMakeDirNode("", self)
    leaves = [ self.parse_mpc_file(mpc_file) for mpc_file in glob2.glob("**/*.mpc")]
    leaves = [x for x in leaves if x is not None]
    for leaf in leaves:
      leaf.resolve_dependencies(self)

  def add_lib_target(self, lib):
    self.libs_index_by_name[lib.name] = lib
    self.libs_index_by_output_name.setdefault(lib.output_name, []).append(lib)

  def find_target_by_output_name(self, output_name, caller_path):
    r = self.libs_index_by_output_name[output_name]
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
      node.remove(mpc_child)
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
  parser.add_argument('path', nargs='?', default=os.getcwd(), help='the directory to convert')
  args = parser.parse_args()
  global override_cmakefiles
  global project_directory
  global root

  override_cmakefiles = args.override
  project_directory = os.path.abspath(args.path)
  root = os.path.abspath(args.root)

  proj = cmake_project(args.path)
  proj.generate_cmake_files()

if __name__ == "__main__":
  main()

