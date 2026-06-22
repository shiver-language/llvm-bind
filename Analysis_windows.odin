/*===-- llvm-c/Analysis.h - Analysis Library C Interface --------*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to libLLVMAnalysis.a, which           *|
|* implements various analyses of the LLVM IR.                                *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


/**
* @defgroup LLVMCAnalysis Analysis
* @ingroup LLVMC
*
* @{
*/
VerifierFailureAction :: enum i32 {
	AbortProcessAction = 0, /* verifier will print to stderr and abort() */
	PrintMessageAction = 1, /* verifier will print to stderr and return 1 */
	ReturnStatusAction = 2, /* verifier will just return 1 */
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/* Verifies that a module is valid, taking the specified action if not.
	Optionally returns a human-readable description of any invalid constructs.
	OutMessage must be disposed with LLVMDisposeMessage. */
	VerifyModule :: proc(M: ModuleRef, Action: VerifierFailureAction, OutMessage: ^cstring) -> Bool ---

	/* Verifies that a single function is valid, taking the specified action. Useful
	for debugging. */
	VerifyFunction :: proc(Fn: ValueRef, Action: VerifierFailureAction) -> Bool ---

	/* Open up a ghostview window that displays the CFG of the current function.
	Useful for debugging. */
	ViewFunctionCFG     :: proc(Fn: ValueRef) ---
	ViewFunctionCFGOnly :: proc(Fn: ValueRef) ---
}

