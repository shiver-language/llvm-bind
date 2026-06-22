/*===-- llvm-c/Deprecated.h - Deprecation macro -------------------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares LLVM_ATTRIBUTE_C_DEPRECATED() macro, which can be     *|
|* used to deprecate functions in the C interface.                            *|
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


