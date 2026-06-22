/*===-- llvm-c/BitWriter.h - BitWriter Library C Interface ------*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to libLLVMBitWriter.a, which          *|
|* implements output of the LLVM bitcode format.                              *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/** Writes a module to the specified path. Returns 0 on success. */
	WriteBitcodeToFile :: proc(M: ModuleRef, Path: cstring) -> i32 ---

	/** Writes a module to an open file descriptor. Returns 0 on success. */
	WriteBitcodeToFD :: proc(M: ModuleRef, FD: i32, ShouldClose: i32, Unbuffered: i32) -> i32 ---

	/** Deprecated for LLVMWriteBitcodeToFD. Writes a module to an open file
	descriptor. Returns 0 on success. Closes the Handle. */
	WriteBitcodeToFileHandle :: proc(M: ModuleRef, Handle: i32) -> i32 ---

	/** Writes a module to a new memory buffer and returns it. */
	WriteBitcodeToMemoryBuffer :: proc(M: ModuleRef) -> MemoryBufferRef ---
}

