let create_await_expression (e : Parsetree.expression) =
  let txt =
    Longident.Ldot (Longident.Ldot (Lident "Js", "Promise"), "unsafe_await")
  in
  let pexp_desc = Parsetree.Pexp_ident { txt; loc = e.pexp_loc } in
  { e with pexp_desc = Pexp_apply ({ e with pexp_desc }, [ (Nolabel, e) ]) }

let create_await_module_expression ~module_type_name (e : Parsetree.module_expr)
    =
  let open Ast_helper in
  {
    e with
    pmod_desc =
      Pmod_unpack
        (create_await_expression
           (Exp.apply
              (Exp.ident ~loc:e.pmod_loc
                 {
                   txt = Longident.Ldot (Lident "Js", "import");
                   loc = e.pmod_loc;
                 })
              [
                ( Nolabel,
                  Exp.constraint_ ~loc:e.pmod_loc
                    (Exp.pack ~loc:e.pmod_loc e)
                    (Typ.package ~loc:e.pmod_loc
                       { txt = Lident module_type_name; loc = e.pmod_loc }
                       []) );
              ]));
  }
