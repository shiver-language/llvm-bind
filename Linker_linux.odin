/*===-- llvm-c/Linker.h - Module Linker C Interface -------------*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file defines the C interface to the module/file/archive linker.       *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "system:LLVM"


/* This enum is provided for backwards-compatibility only. It has no effect. */
LinkerMode :: enum u32 {
	DestroySource          = 0, /* This is the default behavior. */
	PreserveSource_Removed = 1, /* This option has been deprecated and
                                          should not be used. */
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/* Links the source module into the destination module. The source module is
	* destroyed.
	* The return value is true if an error occurred, false otherwise.
	* Use the diagnostic handler to get any diagnostic message.
	*/
	LinkModules2 :: proc(Dest: ModuleRef, Src: ModuleRef) -> Bool ---
}

