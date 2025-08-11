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
    int visit_module(AST_Module*) override;
    int visit_constant(AST_Constant*) override;
    int visit_typedef(AST_Typedef*) override;
    int visit_interface(AST_Interface*) override;
    int visit_valuetype(AST_ValueType*) override;
    int visit_structure(AST_Structure*) override;
    int visit_union(AST_Union*) override;
    int visit_enum(AST_Enum*) override;
    symbol_table& st_;

    void add(AST_Decl* decl);
  };

  struct fill_details : recursive_visitor {
    fill_details(AST_Decl* scope, symbol_table& st);
    ~fill_details() override = default;
    symbol_table& st_;
  };
};

#endif
