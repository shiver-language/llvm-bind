/*===- llvm-c/ExternC.h - Wrapper for 'extern "C"' ----------------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file defines an 'extern "C"' wrapper                                  *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

when ODIN_OS == .Windows {
    foreign import lib "system:LLVM-C.lib"
} else when ODIN_OS == .Linux {
    foreign import lib "system:LLVM"
} else when ODIN_OS == .Darwin {
    foreign import lib "system:libLLVM-C.dylib"
}


