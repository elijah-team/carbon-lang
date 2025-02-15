// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/impl/fail_call_invalid.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/impl/fail_call_invalid.carbon

interface Simple {
  fn G[self: Self]();
}

impl i32 as Simple {
  // CHECK:STDERR: fail_call_invalid.carbon:[[@LINE+3]]:14: error: name `Undeclared` not found [NameNotFound]
  // CHECK:STDERR:   fn G[self: Undeclared]();
  // CHECK:STDERR:              ^~~~~~~~~~
  fn G[self: Undeclared]();
}

fn InstanceCall(n: i32) {
  n.(Simple.G)();
}

// CHECK:STDOUT: --- fail_call_invalid.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Simple.type: type = facet_type <@Simple> [template]
// CHECK:STDOUT:   %Self: %Simple.type = bind_symbolic_name Self, 0 [symbolic]
// CHECK:STDOUT:   %Self.as_type: type = facet_access_type %Self [symbolic]
// CHECK:STDOUT:   %G.type.1: type = fn_type @G.1 [template]
// CHECK:STDOUT:   %G.1: %G.type.1 = struct_value () [template]
// CHECK:STDOUT:   %G.assoc_type: type = assoc_entity_type %Simple.type, %G.type.1 [template]
// CHECK:STDOUT:   %assoc0: %G.assoc_type = assoc_entity element0, @Simple.%G.decl [template]
// CHECK:STDOUT:   %int_32: Core.IntLiteral = int_value 32 [template]
// CHECK:STDOUT:   %Int.type: type = fn_type @Int [template]
// CHECK:STDOUT:   %Int: %Int.type = struct_value () [template]
// CHECK:STDOUT:   %i32: type = int_type signed, %int_32 [template]
// CHECK:STDOUT:   %G.type.2: type = fn_type @G.2 [template]
// CHECK:STDOUT:   %G.2: %G.type.2 = struct_value () [template]
// CHECK:STDOUT:   %Simple.facet: %Simple.type = facet_value %i32, %i32 [template]
// CHECK:STDOUT:   %InstanceCall.type: type = fn_type @InstanceCall [template]
// CHECK:STDOUT:   %InstanceCall: %InstanceCall.type = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int = %import_ref
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/...
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .Simple = %Simple.decl
// CHECK:STDOUT:     .InstanceCall = %InstanceCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Simple.decl: type = interface_decl @Simple [template = constants.%Simple.type] {} {}
// CHECK:STDOUT:   impl_decl @impl [template] {} {
// CHECK:STDOUT:     %int_32: Core.IntLiteral = int_value 32 [template = constants.%int_32]
// CHECK:STDOUT:     %int.make_type_signed: init type = call constants.%Int(%int_32) [template = constants.%i32]
// CHECK:STDOUT:     %.loc15_6.1: type = value_of_initializer %int.make_type_signed [template = constants.%i32]
// CHECK:STDOUT:     %.loc15_6.2: type = converted %int.make_type_signed, %.loc15_6.1 [template = constants.%i32]
// CHECK:STDOUT:     %Simple.ref: type = name_ref Simple, file.%Simple.decl [template = constants.%Simple.type]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %InstanceCall.decl: %InstanceCall.type = fn_decl @InstanceCall [template = constants.%InstanceCall] {
// CHECK:STDOUT:     %n.patt: %i32 = binding_pattern n
// CHECK:STDOUT:     %n.param_patt: %i32 = value_param_pattern %n.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int_32: Core.IntLiteral = int_value 32 [template = constants.%int_32]
// CHECK:STDOUT:     %int.make_type_signed: init type = call constants.%Int(%int_32) [template = constants.%i32]
// CHECK:STDOUT:     %.loc22_20.1: type = value_of_initializer %int.make_type_signed [template = constants.%i32]
// CHECK:STDOUT:     %.loc22_20.2: type = converted %int.make_type_signed, %.loc22_20.1 [template = constants.%i32]
// CHECK:STDOUT:     %n.param: %i32 = value_param runtime_param0
// CHECK:STDOUT:     %n: %i32 = bind_name n, %n.param
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Simple {
// CHECK:STDOUT:   %Self: %Simple.type = bind_symbolic_name Self, 0 [symbolic = constants.%Self]
// CHECK:STDOUT:   %G.decl: %G.type.1 = fn_decl @G.1 [template = constants.%G.1] {
// CHECK:STDOUT:     %self.patt: @G.1.%Self.as_type.loc12_14.1 (%Self.as_type) = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: @G.1.%Self.as_type.loc12_14.1 (%Self.as_type) = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %Self.ref: %Simple.type = name_ref Self, @Simple.%Self [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:     %Self.as_type.loc12_14.2: type = facet_access_type %Self.ref [symbolic = %Self.as_type.loc12_14.1 (constants.%Self.as_type)]
// CHECK:STDOUT:     %.loc12: type = converted %Self.ref, %Self.as_type.loc12_14.2 [symbolic = %Self.as_type.loc12_14.1 (constants.%Self.as_type)]
// CHECK:STDOUT:     %self.param: @G.1.%Self.as_type.loc12_14.1 (%Self.as_type) = value_param runtime_param0
// CHECK:STDOUT:     %self: @G.1.%Self.as_type.loc12_14.1 (%Self.as_type) = bind_name self, %self.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %assoc0: %G.assoc_type = assoc_entity element0, %G.decl [template = constants.%assoc0]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   .G = %assoc0
// CHECK:STDOUT:   witness = (%G.decl)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl: %.loc15_6.2 as %Simple.ref {
// CHECK:STDOUT:   %G.decl: %G.type.2 = fn_decl @G.2 [template = constants.%G.2] {
// CHECK:STDOUT:     %self.patt: <error> = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: <error> = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %Undeclared.ref: <error> = name_ref Undeclared, <error> [template = <error>]
// CHECK:STDOUT:     %self.param: <error> = value_param runtime_param0
// CHECK:STDOUT:     %self: <error> = bind_name self, %self.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %interface: <witness> = interface_witness (<error>) [template = <error>]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .G = %G.decl
// CHECK:STDOUT:   witness = %interface
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @G.1(@Simple.%Self: %Simple.type) {
// CHECK:STDOUT:   %Self: %Simple.type = bind_symbolic_name Self, 0 [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:   %Self.as_type.loc12_14.1: type = facet_access_type %Self [symbolic = %Self.as_type.loc12_14.1 (constants.%Self.as_type)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn[%self.param_patt: @G.1.%Self.as_type.loc12_14.1 (%Self.as_type)]();
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G.2[%self.param_patt: <error>]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @InstanceCall(%n.param_patt: %i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %n.ref: %i32 = name_ref n, %n
// CHECK:STDOUT:   %Simple.ref: type = name_ref Simple, file.%Simple.decl [template = constants.%Simple.type]
// CHECK:STDOUT:   %G.ref: %G.assoc_type = name_ref G, @Simple.%assoc0 [template = constants.%assoc0]
// CHECK:STDOUT:   %impl.elem0: %G.type.1 = interface_witness_access <error>, element0 [template = <error>]
// CHECK:STDOUT:   %G.bound: <bound method> = bound_method %n.ref, %impl.elem0
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @G.1(constants.%Self) {
// CHECK:STDOUT:   %Self => constants.%Self
// CHECK:STDOUT:   %Self.as_type.loc12_14.1 => constants.%Self.as_type
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @G.1(constants.%Simple.facet) {
// CHECK:STDOUT:   %Self => constants.%Simple.facet
// CHECK:STDOUT:   %Self.as_type.loc12_14.1 => constants.%i32
// CHECK:STDOUT: }
// CHECK:STDOUT:
