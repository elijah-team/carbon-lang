// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/array/generic_empty.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/array/generic_empty.carbon

fn G(T:! type) {
  // We can initialize this without knowing T.
  var arr: [T; 0] = ();
}

// CHECK:STDOUT: --- generic_empty.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %G.type: type = fn_type @G [template]
// CHECK:STDOUT:   %empty_tuple.type: type = tuple_type () [template]
// CHECK:STDOUT:   %G: %G.type = struct_value () [template]
// CHECK:STDOUT:   %int_0: Core.IntLiteral = int_value 0 [template]
// CHECK:STDOUT:   %array_type: type = array_type %int_0, %T [symbolic]
// CHECK:STDOUT:   %array: %array_type = tuple_value () [symbolic]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/...
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .G = %G.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %G.decl: %G.type = fn_decl @G [template = constants.%G] {
// CHECK:STDOUT:     %T.patt.loc11_6.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc11_6.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc11_6.1, runtime_param<invalid> [symbolic = %T.patt.loc11_6.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc11_6.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc11_6.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @G(%T.loc11_6.1: type) {
// CHECK:STDOUT:   %T.loc11_6.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc11_6.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc11_6.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc11_6.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %array_type.loc13_17.2: type = array_type constants.%int_0, @G.%T.loc11_6.2 (%T) [symbolic = %array_type.loc13_17.2 (constants.%array_type)]
// CHECK:STDOUT:   %array: @G.%array_type.loc13_17.2 (%array_type) = tuple_value () [symbolic = %array (constants.%array)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn(%T.param_patt: type) {
// CHECK:STDOUT:   !entry:
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc11_6.1 [symbolic = %T.loc11_6.2 (constants.%T)]
// CHECK:STDOUT:     %int_0: Core.IntLiteral = int_value 0 [template = constants.%int_0]
// CHECK:STDOUT:     %array_type.loc13_17.1: type = array_type %int_0, %T [symbolic = %array_type.loc13_17.2 (constants.%array_type)]
// CHECK:STDOUT:     %arr.var: ref @G.%array_type.loc13_17.2 (%array_type) = var arr
// CHECK:STDOUT:     %arr: ref @G.%array_type.loc13_17.2 (%array_type) = bind_name arr, %arr.var
// CHECK:STDOUT:     %.loc13_22.1: %empty_tuple.type = tuple_literal ()
// CHECK:STDOUT:     %.loc13_22.2: init @G.%array_type.loc13_17.2 (%array_type) = array_init () to %arr.var [symbolic = %array (constants.%array)]
// CHECK:STDOUT:     %.loc13_23: init @G.%array_type.loc13_17.2 (%array_type) = converted %.loc13_22.1, %.loc13_22.2 [symbolic = %array (constants.%array)]
// CHECK:STDOUT:     assign %arr.var, %.loc13_23
// CHECK:STDOUT:     return
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @G(constants.%T) {
// CHECK:STDOUT:   %T.loc11_6.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc11_6.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
