/*===-- llvm-c/BitReader.h - BitReader Library C Interface ------*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to libLLVMBitReader.a, which          *|
|* implements input of the LLVM bitcode format.                               *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "system:LLVM"


@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/* Builds a module from the bitcode in the specified memory buffer, returning a
	reference to the module via the OutModule parameter. Returns 0 on success.
	Optionally returns a human-readable error message via OutMessage.
	
	This is deprecated. Use LLVMParseBitcode2. */
	ParseBitcode :: proc(MemBuf: MemoryBufferRef, OutModule: ^ModuleRef, OutMessage: ^cstring) -> Bool ---

	/* Builds a module from the bitcode in the specified memory buffer, returning a
	reference to the module via the OutModule parameter. Returns 0 on success. */
	ParseBitcode2 :: proc(MemBuf: MemoryBufferRef, OutModule: ^ModuleRef) -> Bool ---

	/* This is deprecated. Use LLVMParseBitcodeInContext2. */
	ParseBitcodeInContext  :: proc(ContextRef: ContextRef, MemBuf: MemoryBufferRef, OutModule: ^ModuleRef, OutMessage: ^cstring) -> Bool ---
	ParseBitcodeInContext2 :: proc(ContextRef: ContextRef, MemBuf: MemoryBufferRef, OutModule: ^ModuleRef) -> Bool ---

	/** Reads a module from the specified path, returning via the OutMP parameter
	a module provider which performs lazy deserialization. Returns 0 on success.
	Optionally returns a human-readable error message via OutMessage.
	This is deprecated. Use LLVMGetBitcodeModuleInContext2. */
	GetBitcodeModuleInContext :: proc(ContextRef: ContextRef, MemBuf: MemoryBufferRef, OutM: ^ModuleRef, OutMessage: ^cstring) -> Bool ---

	/** Reads a module from the given memory buffer, returning via the OutMP
	* parameter a module provider which performs lazy deserialization.
	*
	* Returns 0 on success.
	*
	* Takes ownership of \p MemBuf if (and only if) the module was read
	* successfully. */
	GetBitcodeModuleInContext2 :: proc(ContextRef: ContextRef, MemBuf: MemoryBufferRef, OutM: ^ModuleRef) -> Bool ---

	/* This is deprecated. Use LLVMGetBitcodeModule2. */
	GetBitcodeModule  :: proc(MemBuf: MemoryBufferRef, OutM: ^ModuleRef, OutMessage: ^cstring) -> Bool ---
	GetBitcodeModule2 :: proc(MemBuf: MemoryBufferRef, OutM: ^ModuleRef) -> Bool ---
}

