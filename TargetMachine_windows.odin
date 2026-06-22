/*===-- llvm-c/TargetMachine.h - Target Machine Library C Interface - C++ -*-=*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to the Target and TargetMachine       *|
|* classes, which can be used to generate assembly or object files.           *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


OpaqueTargetMachineOptions :: struct {}

/**
* @addtogroup LLVMCTarget
*
* @{
*/
TargetMachineOptionsRef :: ^OpaqueTargetMachineOptions
OpaqueTargetMachine     :: struct {}
TargetMachineRef        :: ^OpaqueTargetMachine
Target                  :: struct {}
TargetRef               :: ^Target

CodeGenOptLevel :: enum i32 {
	None       = 0,
	Less       = 1,
	Default    = 2,
	Aggressive = 3,
}

RelocMode :: enum i32 {
	Default      = 0,
	Static       = 1,
	PIC          = 2,
	DynamicNoPic = 3,
	ROPI         = 4,
	RWPI         = 5,
	ROPI_RWPI    = 6,
}

CodeModel :: enum i32 {
	Default    = 0,
	JITDefault = 1,
	Tiny       = 2,
	Small      = 3,
	Kernel     = 4,
	Medium     = 5,
	Large      = 6,
}

CodeGenFileType :: enum i32 {
	AssemblyFile = 0,
	ObjectFile   = 1,
}

GlobalISelAbortMode :: enum i32 {
	Enable          = 0,
	Disable         = 1,
	DisableWithDiag = 2,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/** Returns the first llvm::Target in the registered targets list. */
	GetFirstTarget :: proc() -> TargetRef ---

	/** Returns the next llvm::Target given a previous one (or null if there's none) */
	GetNextTarget :: proc(T: TargetRef) -> TargetRef ---

	/*===-- Target ------------------------------------------------------------===*/
	/** Finds the target corresponding to the given name and stores it in \p T.
	Returns 0 on success. */
	GetTargetFromName :: proc(Name: cstring) -> TargetRef ---

	/** Finds the target corresponding to the given triple and stores it in \p T.
	Returns 0 on success. Optionally returns any error in ErrorMessage.
	Use LLVMDisposeMessage to dispose the message. */
	GetTargetFromTriple :: proc(Triple: cstring, T: ^TargetRef, ErrorMessage: ^cstring) -> Bool ---

	/** Returns the name of a target. See llvm::Target::getName */
	GetTargetName :: proc(T: TargetRef) -> cstring ---

	/** Returns the description  of a target. See llvm::Target::getDescription */
	GetTargetDescription :: proc(T: TargetRef) -> cstring ---

	/** Returns if the target has a JIT */
	TargetHasJIT :: proc(T: TargetRef) -> Bool ---

	/** Returns if the target has a TargetMachine associated */
	TargetHasTargetMachine :: proc(T: TargetRef) -> Bool ---

	/** Returns if the target as an ASM backend (required for emitting output) */
	TargetHasAsmBackend :: proc(T: TargetRef) -> Bool ---

	/*===-- Target Machine ----------------------------------------------------===*/
	/**
	* Create a new set of options for an llvm::TargetMachine.
	*
	* The returned option structure must be released with
	* LLVMDisposeTargetMachineOptions() after the call to
	* LLVMCreateTargetMachineWithOptions().
	*/
	CreateTargetMachineOptions :: proc() -> TargetMachineOptionsRef ---

	/**
	* Dispose of an LLVMTargetMachineOptionsRef instance.
	*/
	DisposeTargetMachineOptions :: proc(Options: TargetMachineOptionsRef) ---
	TargetMachineOptionsSetCPU  :: proc(Options: TargetMachineOptionsRef, CPU: cstring) ---

	/**
	* Set the list of features for the target machine.
	*
	* \param Features a comma-separated list of features.
	*/
	TargetMachineOptionsSetFeatures        :: proc(Options: TargetMachineOptionsRef, Features: cstring) ---
	TargetMachineOptionsSetABI             :: proc(Options: TargetMachineOptionsRef, ABI: cstring) ---
	TargetMachineOptionsSetCodeGenOptLevel :: proc(Options: TargetMachineOptionsRef, Level: CodeGenOptLevel) ---
	TargetMachineOptionsSetRelocMode       :: proc(Options: TargetMachineOptionsRef, Reloc: RelocMode) ---
	TargetMachineOptionsSetCodeModel       :: proc(Options: TargetMachineOptionsRef, CodeModel: CodeModel) ---

	/**
	* Create a new llvm::TargetMachine.
	*
	* \param T the target to create a machine for.
	* \param Triple a triple describing the target machine.
	* \param Options additional configuration (see
	*                LLVMCreateTargetMachineOptions()).
	*/
	CreateTargetMachineWithOptions :: proc(T: TargetRef, Triple: cstring, Options: TargetMachineOptionsRef) -> TargetMachineRef ---

	/** Creates a new llvm::TargetMachine. See llvm::Target::createTargetMachine */
	CreateTargetMachine :: proc(T: TargetRef, Triple: cstring, CPU: cstring, Features: cstring, Level: CodeGenOptLevel, Reloc: RelocMode, CodeModel: CodeModel) -> TargetMachineRef ---

	/** Dispose the LLVMTargetMachineRef instance generated by
	LLVMCreateTargetMachine. */
	DisposeTargetMachine :: proc(T: TargetMachineRef) ---

	/** Returns the Target used in a TargetMachine */
	GetTargetMachineTarget :: proc(T: TargetMachineRef) -> TargetRef ---

	/** Returns the triple used creating this target machine. See
	llvm::TargetMachine::getTriple. The result needs to be disposed with
	LLVMDisposeMessage. */
	GetTargetMachineTriple :: proc(T: TargetMachineRef) -> cstring ---

	/** Returns the cpu used creating this target machine. See
	llvm::TargetMachine::getCPU. The result needs to be disposed with
	LLVMDisposeMessage. */
	GetTargetMachineCPU :: proc(T: TargetMachineRef) -> cstring ---

	/** Returns the feature string used creating this target machine. See
	llvm::TargetMachine::getFeatureString. The result needs to be disposed with
	LLVMDisposeMessage. */
	GetTargetMachineFeatureString :: proc(T: TargetMachineRef) -> cstring ---

	/** Create a DataLayout based on the targetMachine. */
	CreateTargetDataLayout :: proc(T: TargetMachineRef) -> TargetDataRef ---

	/** Set the target machine's ASM verbosity. */
	SetTargetMachineAsmVerbosity :: proc(T: TargetMachineRef, VerboseAsm: Bool) ---

	/** Enable fast-path instruction selection. */
	SetTargetMachineFastISel :: proc(T: TargetMachineRef, Enable: Bool) ---

	/** Enable global instruction selection. */
	SetTargetMachineGlobalISel :: proc(T: TargetMachineRef, Enable: Bool) ---

	/** Set abort behaviour when global instruction selection fails to lower/select
	* an instruction. */
	SetTargetMachineGlobalISelAbort :: proc(T: TargetMachineRef, Mode: GlobalISelAbortMode) ---

	/** Enable the MachineOutliner pass. */
	SetTargetMachineMachineOutliner :: proc(T: TargetMachineRef, Enable: Bool) ---

	/** Emits an asm or object file for the given module to the filename. This
	wraps several c++ only classes (among them a file stream). Returns any
	error in ErrorMessage. Use LLVMDisposeMessage to dispose the message. */
	TargetMachineEmitToFile :: proc(T: TargetMachineRef, M: ModuleRef, Filename: cstring, codegen: CodeGenFileType, ErrorMessage: ^cstring) -> Bool ---

	/** Compile the LLVM IR stored in \p M and store the result in \p OutMemBuf. */
	TargetMachineEmitToMemoryBuffer :: proc(T: TargetMachineRef, M: ModuleRef, codegen: CodeGenFileType, ErrorMessage: ^cstring, OutMemBuf: ^MemoryBufferRef) -> Bool ---

	/*===-- Triple ------------------------------------------------------------===*/
	/** Get a triple for the host machine as a string. The result needs to be
	disposed with LLVMDisposeMessage. */
	GetDefaultTargetTriple :: proc() -> cstring ---

	/** Normalize a target triple. The result needs to be disposed with
	LLVMDisposeMessage. */
	NormalizeTargetTriple :: proc(triple: cstring) -> cstring ---

	/** Get the host CPU as a string. The result needs to be disposed with
	LLVMDisposeMessage. */
	GetHostCPUName :: proc() -> cstring ---

	/** Get the host CPU's features as a string. The result needs to be disposed
	with LLVMDisposeMessage. */
	GetHostCPUFeatures :: proc() -> cstring ---

	/** Adds the target-specific analysis passes to the pass manager. */
	AddAnalysisPasses :: proc(T: TargetMachineRef, PM: PassManagerRef) ---
}

