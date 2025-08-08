/*
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#ifndef DDS_VISITOR_H
#define DDS_VISITOR_H

#include "dds_generator.h"
#include <ast_visitor.h>

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

struct visitor_base : ast_visitor {
  ~visitor_base() override = default;

  int visit_decl(AST_Decl*) override { return 0; }
  int visit_scope(UTL_Scope*) override { return 0; }
  int visit_type(AST_Type*) override { return 0; }
  int visit_predefined_type(AST_PredefinedType*) override { return 0; }
  int visit_module(AST_Module*) override { return 0; }
  int visit_interface(AST_Interface*) override { return 0; }
  int visit_interface_fwd(AST_InterfaceFwd*) override { return 0; }
  int visit_valuetype(AST_ValueType*) override { return 0; }
  int visit_valuetype_fwd(AST_ValueTypeFwd*) override { return 0; }
  int visit_component(AST_Component*) override { return 0; }
  int visit_component_fwd(AST_ComponentFwd*) override { return 0; }
  int visit_eventtype(AST_EventType*) override { return 0; }
  int visit_eventtype_fwd(AST_EventTypeFwd*) override { return 0; }
  int visit_home(AST_Home*) override { return 0; }
  int visit_factory(AST_Factory*) override { return 0; }
  int visit_structure(AST_Structure*) override { return 0; }
  int visit_structure_fwd(AST_StructureFwd*) override { return 0; }
  int visit_exception(AST_Exception*) override { return 0; }
  int visit_expression(AST_Expression*) override { return 0; }
  int visit_enum(AST_Enum*) override { return 0; }
  int visit_operation(AST_Operation*) override { return 0; }
  int visit_field(AST_Field*) override { return 0; }
  int visit_argument(AST_Argument*) override { return 0; }
  int visit_attribute(AST_Attribute*) override { return 0; }
  int visit_union(AST_Union*) override { return 0; }
  int visit_union_fwd(AST_UnionFwd*) override { return 0; }
  int visit_union_branch(AST_UnionBranch*) override { return 0; }
  int visit_union_label(AST_UnionLabel*) override { return 0; }
  int visit_constant(AST_Constant*) override { return 0; }
  int visit_enum_val(AST_EnumVal*) override { return 0; }
  int visit_array(AST_Array*) override { return 0; }
  int visit_sequence(AST_Sequence*) override { return 0; }
  int visit_map(AST_Map*) override { return 0; }
  int visit_string(AST_String*) override { return 0; }
  int visit_typedef(AST_Typedef*) override { return 0; }
  int visit_root(AST_Root*) override { return 0; }
  int visit_native(AST_Native*) override { return 0; }
  int visit_valuebox(AST_ValueBox*) override { return 0; }
  int visit_template_module(AST_Template_Module*) override { return 0; }
  int visit_template_module_inst(AST_Template_Module_Inst*) override { return 0; }
  int visit_template_module_ref(AST_Template_Module_Ref*) override { return 0; }
  int visit_param_holder(AST_Param_Holder*) override { return 0; }
  int visit_porttype(AST_PortType*) override { return 0; }
  int visit_provides(AST_Provides*) override { return 0; }
  int visit_uses(AST_Uses*) override { return 0; }
  int visit_publishes(AST_Publishes*) override { return 0; }
  int visit_emits(AST_Emits*) override { return 0; }
  int visit_consumes(AST_Consumes*) override { return 0; }
  int visit_extended_port(AST_Extended_Port*) override { return 0; }
  int visit_mirror_port(AST_Mirror_Port*) override { return 0; }
  int visit_connector(AST_Connector*) override { return 0; }
  int visit_finder(AST_Finder*) override { return 0; }
};

class recursive_visitor : public visitor_base {
public:
  explicit recursive_visitor(AST_Decl* scope);
  ~recursive_visitor() override = default;

  int visit_root(AST_Root* node) override;
  int visit_scope(UTL_Scope* node) override;
  int visit_module(AST_Module* node) override;
  int visit_interface(AST_Interface* node) override;
  int visit_exception(AST_Exception* node) override;

protected:
  AST_Decl* scope_;
};

class codegen_visitor : public recursive_visitor {
public:
  codegen_visitor(AST_Decl* scope, bool java_ts_only);
  ~codegen_visitor() override = default;

  int visit_root(AST_Root* node) override;
  int visit_module(AST_Module* node) override;
  int visit_interface(AST_Interface* node) override;
  int visit_structure(AST_Structure* node) override;
  int visit_typedef(AST_Typedef* node) override;
  int visit_enum(AST_Enum* node) override;
  int visit_interface_fwd(AST_InterfaceFwd* node) override;
  int visit_structure_fwd(AST_StructureFwd* node) override;
  int visit_constant(AST_Constant* node) override;
  int visit_native(AST_Native* node) override;
  int visit_union(AST_Union* node) override;
  int visit_union_fwd(AST_UnionFwd* node) override;

protected:
  bool error_;
  bool java_ts_only_;
  composite_generator gen_target_;
};

template <typename T>
void scope2vector(std::vector<T*>& v, UTL_Scope* s, AST_Decl::NodeType nt)
{
  UTL_ScopeActiveIterator it(s, UTL_Scope::IK_decls);
  for (; !it.is_done(); it.next()) {
    const auto item = it.item();
    if (item->node_type() == nt) {
      v.push_back(dynamic_cast<T*>(item));
    }
  }
}

#endif
