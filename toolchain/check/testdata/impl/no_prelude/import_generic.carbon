// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/impl/no_prelude/import_generic.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/impl/no_prelude/import_generic.carbon

// --- import_generic.carbon

library "[[@TEST_NAME]]";

class C {}
interface I(T:! type) {}

impl forall [T:! type] C as I(T);
impl forall [T:! type] C as I(T*) {}

// --- import_generic.impl.carbon

impl library "[[@TEST_NAME]]";

impl forall [T:! type] C as I(T) {}

// --- fail_import_generic.impl.carbon

impl library "[[@TEST_NAME]]";

// CHECK:STDERR: fail_import_generic.impl.carbon:[[@LINE+7]]:1: error: redefinition of `impl C as I(T*)` [ImplRedefinition]
// CHECK:STDERR: impl forall [T:! type] C as I(T*) {}
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_import_generic.impl.carbon:[[@LINE-5]]:6: in import [InImport]
// CHECK:STDERR: import_generic.carbon:8:1: note: previous definition was here [ImplPreviousDefinition]
// CHECK:STDERR: impl forall [T:! type] C as I(T*) {}
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
impl forall [T:! type] C as I(T*) {}

// CHECK:STDOUT: --- import_generic.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %empty_struct_type: type = struct_type {} [template]
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %I.type.1: type = generic_interface_type @I [template]
// CHECK:STDOUT:   %I.generic: %I.type.1 = struct_value () [template]
// CHECK:STDOUT:   %I.type.2: type = facet_type <@I, @I(%T)> [symbolic]
// CHECK:STDOUT:   %Self: %I.type.2 = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %ptr: type = ptr_type %T [symbolic]
// CHECK:STDOUT:   %I.type.3: type = facet_type <@I, @I(%ptr)> [symbolic]
// CHECK:STDOUT:   %interface: <witness> = interface_witness () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .I = %I.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {} {}
// CHECK:STDOUT:   %I.decl: %I.type.1 = interface_decl @I [template = constants.%I.generic] {
// CHECK:STDOUT:     %T.patt.loc5_13.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc5_13.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc5_13.1, runtime_param<invalid> [symbolic = %T.patt.loc5_13.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc5_13.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc5_13.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   impl_decl @impl.1 [template] {
// CHECK:STDOUT:     %T.patt.loc7_14.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc7_14.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc7_14.1, runtime_param<invalid> [symbolic = %T.patt.loc7_14.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %I.ref: %I.type.1 = name_ref I, file.%I.decl [template = constants.%I.generic]
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc7_14.1 [symbolic = %T.loc7_14.2 (constants.%T)]
// CHECK:STDOUT:     %I.type.loc7_32.1: type = facet_type <@I, @I(constants.%T)> [symbolic = %I.type.loc7_32.2 (constants.%I.type.2)]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc7_14.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc7_14.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   impl_decl @impl.2 [template] {
// CHECK:STDOUT:     %T.patt.loc8_14.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc8_14.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc8_14.1, runtime_param<invalid> [symbolic = %T.patt.loc8_14.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %I.ref: %I.type.1 = name_ref I, file.%I.decl [template = constants.%I.generic]
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc8_14.1 [symbolic = %T.loc8_14.2 (constants.%T)]
// CHECK:STDOUT:     %ptr.loc8_32.1: type = ptr_type %T [symbolic = %ptr.loc8_32.2 (constants.%ptr)]
// CHECK:STDOUT:     %I.type.loc8_33.1: type = facet_type <@I, @I(constants.%ptr)> [symbolic = %I.type.loc8_33.2 (constants.%I.type.3)]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc8_14.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc8_14.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @I(%T.loc5_13.1: type) {
// CHECK:STDOUT:   %T.loc5_13.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc5_13.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc5_13.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc5_13.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %I.type: type = facet_type <@I, @I(%T.loc5_13.2)> [symbolic = %I.type (constants.%I.type.2)]
// CHECK:STDOUT:   %Self.2: %I.type.2 = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:     %Self.1: @I.%I.type (%I.type.2) = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = %Self.1
// CHECK:STDOUT:     witness = ()
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.1(%T.loc7_14.1: type) {
// CHECK:STDOUT:   %T.loc7_14.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc7_14.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc7_14.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc7_14.2 (constants.%T.patt)]
// CHECK:STDOUT:   %I.type.loc7_32.2: type = facet_type <@I, @I(%T.loc7_14.2)> [symbolic = %I.type.loc7_32.2 (constants.%I.type.2)]
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: %C.ref as %I.type.loc7_32.1;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.2(%T.loc8_14.1: type) {
// CHECK:STDOUT:   %T.loc8_14.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc8_14.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc8_14.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc8_14.2 (constants.%T.patt)]
// CHECK:STDOUT:   %ptr.loc8_32.2: type = ptr_type @impl.2.%T.loc8_14.2 (%T) [symbolic = %ptr.loc8_32.2 (constants.%ptr)]
// CHECK:STDOUT:   %I.type.loc8_33.2: type = facet_type <@I, @I(%ptr.loc8_32.2)> [symbolic = %I.type.loc8_33.2 (constants.%I.type.3)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: %C.ref as %I.type.loc8_33.1 {
// CHECK:STDOUT:     %interface: <witness> = interface_witness () [template = constants.%interface]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     witness = %interface
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template = constants.%complete_type]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%T) {
// CHECK:STDOUT:   %T.loc5_13.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc5_13.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(%T.loc5_13.2) {
// CHECK:STDOUT:   %T.loc5_13.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc5_13.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.1.%T.loc7_14.2) {
// CHECK:STDOUT:   %T.loc5_13.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc5_13.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.1(constants.%T) {
// CHECK:STDOUT:   %T.loc7_14.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc7_14.2 => constants.%T
// CHECK:STDOUT:   %I.type.loc7_32.2 => constants.%I.type.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%ptr) {
// CHECK:STDOUT:   %T.loc5_13.2 => constants.%ptr
// CHECK:STDOUT:   %T.patt.loc5_13.2 => constants.%ptr
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %I.type => constants.%I.type.3
// CHECK:STDOUT:   %Self.2 => constants.%Self
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.2.%ptr.loc8_32.2) {
// CHECK:STDOUT:   %T.loc5_13.2 => constants.%ptr
// CHECK:STDOUT:   %T.patt.loc5_13.2 => constants.%ptr
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.2(constants.%T) {
// CHECK:STDOUT:   %T.loc8_14.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc8_14.2 => constants.%T
// CHECK:STDOUT:   %ptr.loc8_32.2 => constants.%ptr
// CHECK:STDOUT:   %I.type.loc8_33.2 => constants.%I.type.3
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- import_generic.impl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %I.type.1: type = generic_interface_type @I [template]
// CHECK:STDOUT:   %I.generic: %I.type.1 = struct_value () [template]
// CHECK:STDOUT:   %I.type.2: type = facet_type <@I, @I(%T)> [symbolic]
// CHECK:STDOUT:   %Self: %I.type.2 = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %empty_struct_type: type = struct_type {} [template]
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template]
// CHECK:STDOUT:   %ptr: type = ptr_type %T [symbolic]
// CHECK:STDOUT:   %I.type.3: type = facet_type <@I, @I(%ptr)> [symbolic]
// CHECK:STDOUT:   %interface: <witness> = interface_witness () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %import_ref.1: type = import_ref Main//import_generic, inst+1, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.2: %I.type.1 = import_ref Main//import_generic, inst+12, loaded [template = constants.%I.generic]
// CHECK:STDOUT:   %import_ref.3 = import_ref Main//import_generic, inst+19, unloaded
// CHECK:STDOUT:   %import_ref.4: <witness> = import_ref Main//import_generic, inst+4, loaded [template = constants.%complete_type]
// CHECK:STDOUT:   %import_ref.5 = import_ref Main//import_generic, inst+2, unloaded
// CHECK:STDOUT:   %import_ref.6: type = import_ref Main//import_generic, inst+26, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.7: type = import_ref Main//import_generic, inst+29, loaded [symbolic = @impl.1.%I.type.1 (constants.%I.type.2)]
// CHECK:STDOUT:   %import_ref.8: type = import_ref Main//import_generic, inst+38, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.9: type = import_ref Main//import_generic, inst+43, loaded [symbolic = @impl.2.%I.type (constants.%I.type.3)]
// CHECK:STDOUT:   %import_ref.10 = import_ref Main//import_generic, inst+51, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .C = imports.%import_ref.1
// CHECK:STDOUT:     .I = imports.%import_ref.2
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %default.import.loc2_6.1 = import <invalid>
// CHECK:STDOUT:   %default.import.loc2_6.2 = import <invalid>
// CHECK:STDOUT:   impl_decl @impl.1 [template] {} {
// CHECK:STDOUT:     %C.ref: type = name_ref C, imports.%import_ref.1 [template = constants.%C]
// CHECK:STDOUT:     %I.ref: %I.type.1 = name_ref I, imports.%import_ref.2 [template = constants.%I.generic]
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc4 [symbolic = constants.%T]
// CHECK:STDOUT:     %I.type.loc4: type = facet_type <@I, @I(constants.%T)> [symbolic = constants.%I.type.2]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc4: type = bind_symbolic_name T, 0, %T.param [symbolic = constants.%T]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @I(constants.%T: type) {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %I.type: type = facet_type <@I, @I(%T)> [symbolic = %I.type (constants.%I.type.2)]
// CHECK:STDOUT:   %Self: %I.type.2 = bind_symbolic_name Self, 1 [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = imports.%import_ref.3
// CHECK:STDOUT:     witness = ()
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.1(constants.%T: type) {
// CHECK:STDOUT:   %T.1: type = bind_symbolic_name T, 0 [symbolic = %T.1 (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:   %I.type.1: type = facet_type <@I, @I(%T.1)> [symbolic = %I.type.1 (constants.%I.type.2)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: imports.%import_ref.6 as imports.%import_ref.7 {
// CHECK:STDOUT:     %interface: <witness> = interface_witness () [template = constants.%interface]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     witness = %interface
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.2(constants.%T: type) {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:   %ptr: type = ptr_type @impl.2.%T (%T) [symbolic = %ptr (constants.%ptr)]
// CHECK:STDOUT:   %I.type: type = facet_type <@I, @I(%ptr)> [symbolic = %I.type (constants.%I.type.3)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: imports.%import_ref.8 as imports.%import_ref.9 {
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     witness = imports.%import_ref.10
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = imports.%import_ref.5
// CHECK:STDOUT:   complete_type_witness = imports.%import_ref.4
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %I.type => constants.%I.type.2
// CHECK:STDOUT:   %Self => constants.%Self
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.1.%T.1) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.1(constants.%T) {
// CHECK:STDOUT:   %T.1 => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT:   %I.type.1 => constants.%I.type.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%ptr) {
// CHECK:STDOUT:   %T => constants.%ptr
// CHECK:STDOUT:   %T.patt => constants.%ptr
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.2.%ptr) {
// CHECK:STDOUT:   %T => constants.%ptr
// CHECK:STDOUT:   %T.patt => constants.%ptr
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.2(constants.%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT:   %ptr => constants.%ptr
// CHECK:STDOUT:   %I.type => constants.%I.type.3
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_import_generic.impl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %I.type.1: type = generic_interface_type @I [template]
// CHECK:STDOUT:   %I.generic: %I.type.1 = struct_value () [template]
// CHECK:STDOUT:   %I.type.2: type = facet_type <@I, @I(%T)> [symbolic]
// CHECK:STDOUT:   %Self: %I.type.2 = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %empty_struct_type: type = struct_type {} [template]
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [template]
// CHECK:STDOUT:   %ptr: type = ptr_type %T [symbolic]
// CHECK:STDOUT:   %I.type.3: type = facet_type <@I, @I(%ptr)> [symbolic]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %import_ref.1: type = import_ref Main//import_generic, inst+1, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.2: %I.type.1 = import_ref Main//import_generic, inst+12, loaded [template = constants.%I.generic]
// CHECK:STDOUT:   %import_ref.3 = import_ref Main//import_generic, inst+19, unloaded
// CHECK:STDOUT:   %import_ref.4: <witness> = import_ref Main//import_generic, inst+4, loaded [template = constants.%complete_type]
// CHECK:STDOUT:   %import_ref.5 = import_ref Main//import_generic, inst+2, unloaded
// CHECK:STDOUT:   %import_ref.6: type = import_ref Main//import_generic, inst+26, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.7: type = import_ref Main//import_generic, inst+29, loaded [symbolic = @impl.1.%I.type (constants.%I.type.2)]
// CHECK:STDOUT:   %import_ref.8: type = import_ref Main//import_generic, inst+38, loaded [template = constants.%C]
// CHECK:STDOUT:   %import_ref.9: type = import_ref Main//import_generic, inst+43, loaded [symbolic = @impl.2.%I.type.1 (constants.%I.type.3)]
// CHECK:STDOUT:   %import_ref.10 = import_ref Main//import_generic, inst+51, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .C = imports.%import_ref.1
// CHECK:STDOUT:     .I = imports.%import_ref.2
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %default.import.loc2_6.1 = import <invalid>
// CHECK:STDOUT:   %default.import.loc2_6.2 = import <invalid>
// CHECK:STDOUT:   impl_decl @impl.2 [template] {} {
// CHECK:STDOUT:     %C.ref: type = name_ref C, imports.%import_ref.1 [template = constants.%C]
// CHECK:STDOUT:     %I.ref: %I.type.1 = name_ref I, imports.%import_ref.2 [template = constants.%I.generic]
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc11 [symbolic = constants.%T]
// CHECK:STDOUT:     %ptr.loc11: type = ptr_type %T [symbolic = constants.%ptr]
// CHECK:STDOUT:     %I.type.loc11: type = facet_type <@I, @I(constants.%ptr)> [symbolic = constants.%I.type.3]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc11: type = bind_symbolic_name T, 0, %T.param [symbolic = constants.%T]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @I(constants.%T: type) {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %I.type: type = facet_type <@I, @I(%T)> [symbolic = %I.type (constants.%I.type.2)]
// CHECK:STDOUT:   %Self: %I.type.2 = bind_symbolic_name Self, 1 [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = imports.%import_ref.3
// CHECK:STDOUT:     witness = ()
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.1(constants.%T: type) {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:   %I.type: type = facet_type <@I, @I(%T)> [symbolic = %I.type (constants.%I.type.2)]
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: imports.%import_ref.6 as imports.%import_ref.7;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic impl @impl.2(constants.%T: type) {
// CHECK:STDOUT:   %T.1: type = bind_symbolic_name T, 0 [symbolic = %T.1 (constants.%T)]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt (constants.%T.patt)]
// CHECK:STDOUT:   %ptr.1: type = ptr_type @impl.2.%T.1 (%T) [symbolic = %ptr.1 (constants.%ptr)]
// CHECK:STDOUT:   %I.type.1: type = facet_type <@I, @I(%ptr.1)> [symbolic = %I.type.1 (constants.%I.type.3)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   impl: imports.%import_ref.8 as imports.%import_ref.9 {
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     witness = imports.%import_ref.10
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = imports.%import_ref.5
// CHECK:STDOUT:   complete_type_witness = imports.%import_ref.4
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.1.%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.1(constants.%T) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT:   %I.type => constants.%I.type.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(constants.%ptr) {
// CHECK:STDOUT:   %T => constants.%ptr
// CHECK:STDOUT:   %T.patt => constants.%ptr
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @I(@impl.2.%ptr.1) {
// CHECK:STDOUT:   %T => constants.%ptr
// CHECK:STDOUT:   %T.patt => constants.%ptr
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @impl.2(constants.%T) {
// CHECK:STDOUT:   %T.1 => constants.%T
// CHECK:STDOUT:   %T.patt => constants.%T
// CHECK:STDOUT:   %ptr.1 => constants.%ptr
// CHECK:STDOUT:   %I.type.1 => constants.%I.type.3
// CHECK:STDOUT: }
// CHECK:STDOUT:
