/*===-- llvm-c/Disassembler.h - Disassembler Public C Interface ---*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header provides a public interface to a disassembler library.         *|
|* LLVM provides an implementation of this interface.                         *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "system:LLVM"


@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Create a disassembler for the TripleName.  Symbolic disassembly is supported
	* by passing a block of information in the DisInfo parameter and specifying the
	* TagType and callback functions as described above.  These can all be passed
	* as NULL.  If successful, this returns a disassembler context.  If not, it
	* returns NULL. This function is equivalent to calling
	* LLVMCreateDisasmCPUFeatures() with an empty CPU name and feature set.
	*/
	CreateDisasm :: proc(TripleName: cstring, DisInfo: rawptr, TagType: i32, GetOpInfo: OpInfoCallback, SymbolLookUp: SymbolLookupCallback) -> DisasmContextRef ---

	/**
	* Create a disassembler for the TripleName and a specific CPU.  Symbolic
	* disassembly is supported by passing a block of information in the DisInfo
	* parameter and specifying the TagType and callback functions as described
	* above.  These can all be passed * as NULL.  If successful, this returns a
	* disassembler context.  If not, it returns NULL. This function is equivalent
	* to calling LLVMCreateDisasmCPUFeatures() with an empty feature set.
	*/
	CreateDisasmCPU :: proc(Triple: cstring, CPU: cstring, DisInfo: rawptr, TagType: i32, GetOpInfo: OpInfoCallback, SymbolLookUp: SymbolLookupCallback) -> DisasmContextRef ---

	/**
	* Create a disassembler for the TripleName, a specific CPU and specific feature
	* string.  Symbolic disassembly is supported by passing a block of information
	* in the DisInfo parameter and specifying the TagType and callback functions as
	* described above.  These can all be passed * as NULL.  If successful, this
	* returns a disassembler context.  If not, it returns NULL.
	*/
	CreateDisasmCPUFeatures :: proc(Triple: cstring, CPU: cstring, Features: cstring, DisInfo: rawptr, TagType: i32, GetOpInfo: OpInfoCallback, SymbolLookUp: SymbolLookupCallback) -> DisasmContextRef ---

	/**
	* Set the disassembler's options.  Returns 1 if it can set the Options and 0
	* otherwise.
	*/
	SetDisasmOptions :: proc(DC: DisasmContextRef, Options: u64) -> i32 ---
}

/* The option to produce marked up assembly. */
LLVMDisassembler_Option_UseMarkup :: 1

/* The option to print immediates as hex. */
LLVMDisassembler_Option_PrintImmHex :: 2

/* The option use the other assembler printer variant */
LLVMDisassembler_Option_AsmPrinterVariant :: 4

/* The option to set comment on instructions */
LLVMDisassembler_Option_SetInstrComments :: 8

/* The option to print latency information alongside instructions */
LLVMDisassembler_Option_PrintLatency :: 16

/* The option to print in color */
LLVMDisassembler_Option_Color :: 32

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Dispose of a disassembler context.
	*/
	DisasmDispose :: proc(DC: DisasmContextRef) ---

	/**
	* Disassemble a single instruction using the disassembler context specified in
	* the parameter DC.  The bytes of the instruction are specified in the
	* parameter Bytes, and contains at least BytesSize number of bytes.  The
	* instruction is at the address specified by the PC parameter.  If a valid
	* instruction can be disassembled, its string is returned indirectly in
	* OutString whose size is specified in the parameter OutStringSize.  This
	* function returns the number of bytes in the instruction or zero if there was
	* no valid instruction.
	*/
	DisasmInstruction :: proc(DC: DisasmContextRef, Bytes: ^u8, BytesSize: u64, PC: u64, OutString: cstring, OutStringSize: c.size_t) -> c.size_t ---
}

