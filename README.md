# LLVM Bindings

LLVM-C bindings for LLVM `21.x`. Supports Windows and Linux. Darwin is not supported as the developers does not own
Apple devices.

Tested on LLVM `21.1.8`.

## Linux Special Instructions

If you use these bindings on Linux, remember to pass in `-extra-linker-flags`. In my device 
(Gentoo Linux), the command looks like so:
```bash
# change the path depending on the location of your LLVM installation
odin build . -extra-linker-flags="-L/usr/lib/llvm/21/lib64"
```

## Windows Special Instructions

You may notice for Windows files we import the library like so:
```odin
foreign import lib "llvm-install/lib/LLVM-C.lib"
```

Thus, extract the LLVM archive, rename it into llvm-install, then place it to the root directory of **this** project.
Do not put the LLVM archive in the project that imports this.

## Tester Code

Try compiling the following to ensure that the binding is working:
```odin
package main

import "core:fmt"
import llvm "../llvm-bind"

main :: proc() {
    context_ref := llvm.ContextCreate()
    defer llvm.ContextDispose(context_ref)

    mod_name := cstring("test_module\x00")
    module_ref := llvm.ModuleCreateWithNameInContext(mod_name, context_ref)
    defer llvm.DisposeModule(module_ref)

    builder_ref := llvm.CreateBuilderInContext(context_ref)
    defer llvm.DisposeBuilder(builder_ref)

    i32_type := llvm.Int32TypeInContext(context_ref)

    param_types := [2]llvm.TypeRef{i32_type, i32_type}
    func_type := llvm.FunctionType(i32_type, &param_types[0], 2, 0)

    func_name := cstring("add\x00")
    func_ref := llvm.AddFunction(module_ref, func_name, func_type)

    bb_name := cstring("entry\x00")
    entry_bb := llvm.AppendBasicBlockInContext(context_ref, func_ref, bb_name)
    llvm.PositionBuilderAtEnd(builder_ref, entry_bb)

    param_a := llvm.GetParam(func_ref, 0)
    param_b := llvm.GetParam(func_ref, 1)

    tmp_name := cstring("tmp\x00")
    sum := llvm.BuildAdd(builder_ref, param_a, param_b, tmp_name)

    llvm.BuildRet(builder_ref, sum)

    fmt.println("--------------------------------------------------")
    llvm.DumpModule(module_ref)
    fmt.println("--------------------------------------------------")
}
```

The output of the above code should be:
```
--------------------------------------------------
; ModuleID = 'test_module'
source_filename = "test_module"

define i32 @add(i32 %0, i32 %1) {
entry:
  %tmp = add i32 %0, %1
  ret i32 %tmp
}
--------------------------------------------------
```

## Credits
These bindings were automatically generated using [odin-c-bindgen](https://github.com/karl-zylinski/odin-c-bindgen).
