let create_await_expression (e : Parsetree.expression) =
  let txt =
    Longident.Ldot (Longident.Ldot (Lident "Js", "Promise"), "unsafe_await")
  in
  let pexp_desc = Parsetree.Pexp_ident { txt; loc = e.pexp_loc } in
  { e with pexp_desc = Pexp_apply ({ e with pexp_desc }, [ (Nolabel, e) ]) }

let create_await_module_expression (e : Parsetree.module_expr) =
  let txt = Longident.Ldot (Lident "Js", "import") in
  let _module_lid =
    match e with { pmod_desc = Pmod_ident lid } -> lid | _ -> assert false
  in
  let module_expr_without_attr = { e with pmod_attributes = [] } in
  let import_pexp_desc = Parsetree.Pexp_ident { txt; loc = e.pmod_loc } in
  let txt =
    Longident.Ldot (Longident.Ldot (Lident "Js", "Promise"), "unsafe_await")
  in
  let await_pexp_desc = Parsetree.Pexp_ident { txt; loc = e.pmod_loc } in
  {
    module_expr_without_attr with
    pmod_desc =
      Pmod_unpack
        {
          pexp_desc =
            Pexp_apply
              ( {
                  pexp_desc = await_pexp_desc;
                  pexp_attributes = [];
                  pexp_loc = e.pmod_loc;
                },
                [
                  ( Nolabel,
                    {
                      pexp_desc =
                        Pexp_apply
                          ( {
                              pexp_desc = import_pexp_desc;
                              pexp_attributes = [];
                              pexp_loc = e.pmod_loc;
                            },
                            [
                              ( Nolabel,
                                {
                                  pexp_desc =
                                    Pexp_constraint
                                      ( {
                                          pexp_desc =
                                            Pexp_pack module_expr_without_attr;
                                          pexp_loc = e.pmod_loc;
                                          pexp_attributes = [];
                                        },
                                        {
                                          ptyp_desc =
                                            Ptyp_package
                                              ( {
                                                  txt = Lident "BeltList";
                                                  loc = e.pmod_loc;
                                                },
                                                [] );
                                          ptyp_loc = e.pmod_loc;
                                          ptyp_attributes = [];
                                        } );
                                  pexp_attributes = [];
                                  pexp_loc = e.pmod_loc;
                                } );
                            ] );
                      pexp_attributes =
                        [
                          ({ txt = "res.await"; loc = Location.none }, PStr []);
                        ];
                      pexp_loc = e.pmod_loc;
                    } );
                ] );
          pexp_loc = e.pmod_loc;
          pexp_attributes = [];
        };
  }
