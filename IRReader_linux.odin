/*===-- llvm-c/IRReader.h - IR Reader C Interface -----------------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file defines the C interface to the IR Reader.                        *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "system:LLVM"


@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Read LLVM IR from a memory buffer and convert it into an in-memory Module
	* object. Returns 0 on success.
	* Optionally returns a human-readable description of any errors that
	* occurred during parsing IR. OutMessage must be disposed with
	* LLVMDisposeMessage.
	*
	* @see llvm::ParseIR()
	*/
	ParseIRInContext :: proc(ContextRef: ContextRef, MemBuf: MemoryBufferRef, OutM: ^ModuleRef, OutMessage: ^cstring) -> Bool ---
}

