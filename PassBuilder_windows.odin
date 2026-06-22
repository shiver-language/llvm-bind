/*===-- llvm-c/Transform/PassBuilder.h - PassBuilder for LLVM C ---*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header contains the LLVM-C interface into the new pass manager        *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


OpaquePassBuilderOptions :: struct {}

/**
* A set of options passed which are attached to the Pass Manager upon run.
*
* This corresponds to an llvm::LLVMPassBuilderOptions instance
*
* The details for how the different properties of this structure are used can
* be found in the source for LLVMRunPasses
*/
PassBuilderOptionsRef :: ^OpaquePassBuilderOptions

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Construct and run a set of passes over a module
	*
	* This function takes a string with the passes that should be used. The format
	* of this string is the same as opt's -passes argument for the new pass
	* manager. Individual passes may be specified, separated by commas. Full
	* pipelines may also be invoked using `default<O3>` and friends. See opt for
	* full reference of the Passes format.
	*/
	RunPasses :: proc(M: ModuleRef, Passes: cstring, TM: TargetMachineRef, Options: PassBuilderOptionsRef) -> ErrorRef ---

	/**
	* Construct and run a set of passes over a function.
	*
	* This function behaves the same as LLVMRunPasses, but operates on a single
	* function instead of an entire module.
	*/
	RunPassesOnFunction :: proc(F: ValueRef, Passes: cstring, TM: TargetMachineRef, Options: PassBuilderOptionsRef) -> ErrorRef ---

	/**
	* Create a new set of options for a PassBuilder
	*
	* Ownership of the returned instance is given to the client, and they are
	* responsible for it. The client should call LLVMDisposePassBuilderOptions
	* to free the pass builder options.
	*/
	CreatePassBuilderOptions :: proc() -> PassBuilderOptionsRef ---

	/**
	* Toggle adding the VerifierPass for the PassBuilder, ensuring all functions
	* inside the module is valid.
	*/
	PassBuilderOptionsSetVerifyEach :: proc(Options: PassBuilderOptionsRef, VerifyEach: Bool) ---

	/**
	* Toggle debug logging when running the PassBuilder
	*/
	PassBuilderOptionsSetDebugLogging :: proc(Options: PassBuilderOptionsRef, DebugLogging: Bool) ---

	/**
	* Specify a custom alias analysis pipeline for the PassBuilder to be used
	* instead of the default one. The string argument is not copied; the caller
	* is responsible for ensuring it outlives the PassBuilderOptions instance.
	*/
	PassBuilderOptionsSetAAPipeline                   :: proc(Options: PassBuilderOptionsRef, AAPipeline: cstring) ---
	PassBuilderOptionsSetLoopInterleaving             :: proc(Options: PassBuilderOptionsRef, LoopInterleaving: Bool) ---
	PassBuilderOptionsSetLoopVectorization            :: proc(Options: PassBuilderOptionsRef, LoopVectorization: Bool) ---
	PassBuilderOptionsSetSLPVectorization             :: proc(Options: PassBuilderOptionsRef, SLPVectorization: Bool) ---
	PassBuilderOptionsSetLoopUnrolling                :: proc(Options: PassBuilderOptionsRef, LoopUnrolling: Bool) ---
	PassBuilderOptionsSetForgetAllSCEVInLoopUnroll    :: proc(Options: PassBuilderOptionsRef, ForgetAllSCEVInLoopUnroll: Bool) ---
	PassBuilderOptionsSetLicmMssaOptCap               :: proc(Options: PassBuilderOptionsRef, LicmMssaOptCap: u32) ---
	PassBuilderOptionsSetLicmMssaNoAccForPromotionCap :: proc(Options: PassBuilderOptionsRef, LicmMssaNoAccForPromotionCap: u32) ---
	PassBuilderOptionsSetCallGraphProfile             :: proc(Options: PassBuilderOptionsRef, CallGraphProfile: Bool) ---
	PassBuilderOptionsSetMergeFunctions               :: proc(Options: PassBuilderOptionsRef, MergeFunctions: Bool) ---
	PassBuilderOptionsSetInlinerThreshold             :: proc(Options: PassBuilderOptionsRef, Threshold: i32) ---

	/**
	* Dispose of a heap-allocated PassBuilderOptions instance
	*/
	DisposePassBuilderOptions :: proc(Options: PassBuilderOptionsRef) ---
}

