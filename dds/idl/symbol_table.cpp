/*
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#include "symbol_table.h"

#include <ast_valuetype.h>

#include <iostream>

symbol_table::symbol_table()
{
  const auto root = idl_global->root();
  collect_decls c(root, *this);
  root->ast_accept(&c);
  fill_details f(root, *this);
  root->ast_accept(&f);
}

void symbol_table::dump() const
{
  for (const auto& entry : entries_) {
    std::cout << "Symbol: " << entry.first
              << ", Kind: " << entry.second.decl->node_type_name() << '\n';
  }
}

symbol_table::collect_decls::collect_decls(AST_Decl* scope, symbol_table& st)
  : recursive_visitor{scope}
  , st_{st}
{
}

int symbol_table::collect_decls::visit_module(AST_Module* m)
{
  add(m);
  return recursive_visitor::visit_module(m);
}

int symbol_table::collect_decls::visit_constant(AST_Constant* c)
{
  add(c);
  return recursive_visitor::visit_constant(c);
}

int symbol_table::collect_decls::visit_typedef(AST_Typedef* t)
{
  add(t);
  return recursive_visitor::visit_typedef(t);
}

int symbol_table::collect_decls::visit_interface(AST_Interface* i)
{
  add(i);
  return recursive_visitor::visit_interface(i);
}

int symbol_table::collect_decls::visit_valuetype(AST_ValueType* v)
{
  add(v);
  return recursive_visitor::visit_valuetype(v);
}

int symbol_table::collect_decls::visit_structure(AST_Structure* s)
{
  add(s);
  return recursive_visitor::visit_structure(s);
}

int symbol_table::collect_decls::visit_union(AST_Union* u)
{
  add(u);
  return recursive_visitor::visit_union(u);
}

int symbol_table::collect_decls::visit_enum(AST_Enum* e)
{
  add(e);
  return recursive_visitor::visit_enum(e);
}

inline void symbol_table::collect_decls::add(AST_Decl* decl)
{
  st_.entries_[decl->full_name()] = {decl};
  st_.names_[decl] = decl->full_name();
}

symbol_table::fill_details::fill_details(AST_Decl* scope, symbol_table& st)
  : recursive_visitor{scope}
  , st_{st}
{}
