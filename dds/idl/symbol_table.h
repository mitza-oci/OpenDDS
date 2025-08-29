/*
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include "dds_visitor.h"

#include <map>
#include <string>

class symbol_table {
public:
  symbol_table();

  void dump() const;

private:
  struct entry {
    AST_Decl* decl;
  };

  std::map<std::string, entry> entries_;
  std::map<AST_Decl*, std::string> names_;

  struct collect_decls : recursive_visitor {
    collect_decls(AST_Decl* scope, symbol_table& st);
    ~collect_decls() override = default;

    int visit_module(AST_Module* node) override;
    int visit_constant(AST_Constant* node) override;
    int visit_typedef(AST_Typedef* node) override;
    int visit_interface(AST_Interface* node) override;
    int visit_valuetype(AST_ValueType* node) override;
    int visit_structure(AST_Structure* node) override;
    int visit_union(AST_Union* node) override;
    int visit_enum(AST_Enum* node) override;
    int visit_field(AST_Field* node) override;
    int visit_union_branch(AST_UnionBranch* node) override;

    void add(AST_Decl* decl);
    symbol_table& st_;
  };

};

#endif
