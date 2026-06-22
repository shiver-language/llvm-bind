/*===-- llvm-c/Visibility.h - Visibility macros for llvm-c ------*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header defines visibility macros used for the LLVM C interface. These *|
|* macros are used to annotate C functions that should be exported as part of *|
|* a shared library or DLL.                                                   *|
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


