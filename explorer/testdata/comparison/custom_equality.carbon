// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// NOAUTOUPDATE

package ExplorerTest api;

class MyType {
  var value: i32;

  extend impl as EqWith(Self) {
    fn Equal[self: Self](other: Self) -> bool {
      return self.value == other.value;
    }
    fn NotEqual[self: Self](other: Self) -> bool{
      return self.value != other.value;
    }
  }
}

fn Main() -> i32 {
  let x: MyType = {.value = 1};
  let y: MyType = {.value = 2};
  Print("structs equal: {0}", if x == y then 1 else 0);
  Print("structs not equal: {0}", if x != y then 1 else 0);
  return 0;
}

// CHECK:STDOUT: structs equal: 0
// CHECK:STDOUT: structs not equal: 1
// CHECK:STDOUT: result: 0
