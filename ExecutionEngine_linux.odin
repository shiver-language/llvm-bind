/*===-- llvm-c/ExecutionEngine.h - ExecutionEngine Lib C Iface --*- C++ -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to libLLVMExecutionEngine.o, which    *|
|* implements various analyses of the LLVM IR.                                *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "system:LLVM"


@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Empty function used to force the linker to link MCJIT.
	* Has no effect when called on a pre-built library (dylib interface).
	*/
	LinkInMCJIT :: proc() ---

	/**
	* Empty function used to force the linker to link the LLVM interpreter.
	* Has no effect when called on a pre-built library (dylib interface).
	*/
	LinkInInterpreter :: proc() ---
}

OpaqueGenericValue       :: struct {}
GenericValueRef          :: ^OpaqueGenericValue
OpaqueExecutionEngine    :: struct {}
ExecutionEngineRef       :: ^OpaqueExecutionEngine
OpaqueMCJITMemoryManager :: struct {}
MCJITMemoryManagerRef    :: ^OpaqueMCJITMemoryManager

MCJITCompilerOptions :: struct {
	OptLevel:           u32,
	CodeModel:          CodeModel,
	NoFramePointerElim: Bool,
	EnableFastISel:     Bool,
	MCJMM:              MCJITMemoryManagerRef,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/*===-- Operations on generic values --------------------------------------===*/
	CreateGenericValueOfInt     :: proc(Ty: TypeRef, N: u64, IsSigned: Bool) -> GenericValueRef ---
	CreateGenericValueOfPointer :: proc(P: rawptr) -> GenericValueRef ---
	CreateGenericValueOfFloat   :: proc(Ty: TypeRef, N: f64) -> GenericValueRef ---
	GenericValueIntWidth        :: proc(GenValRef: GenericValueRef) -> u32 ---
	GenericValueToInt           :: proc(GenVal: GenericValueRef, IsSigned: Bool) -> u64 ---
	GenericValueToPointer       :: proc(GenVal: GenericValueRef) -> rawptr ---
	GenericValueToFloat         :: proc(TyRef: TypeRef, GenVal: GenericValueRef) -> f64 ---
	DisposeGenericValue         :: proc(GenVal: GenericValueRef) ---

	/*===-- Operations on execution engines -----------------------------------===*/
	CreateExecutionEngineForModule :: proc(OutEE: ^ExecutionEngineRef, M: ModuleRef, OutError: ^cstring) -> Bool ---
	CreateInterpreterForModule     :: proc(OutInterp: ^ExecutionEngineRef, M: ModuleRef, OutError: ^cstring) -> Bool ---
	CreateJITCompilerForModule     :: proc(OutJIT: ^ExecutionEngineRef, M: ModuleRef, OptLevel: u32, OutError: ^cstring) -> Bool ---
	InitializeMCJITCompilerOptions :: proc(Options: ^MCJITCompilerOptions, SizeOfOptions: c.size_t) ---

	/**
	* Create an MCJIT execution engine for a module, with the given options. It is
	* the responsibility of the caller to ensure that all fields in Options up to
	* the given SizeOfOptions are initialized. It is correct to pass a smaller
	* value of SizeOfOptions that omits some fields. The canonical way of using
	* this is:
	*
	* LLVMMCJITCompilerOptions options;
	* LLVMInitializeMCJITCompilerOptions(&options, sizeof(options));
	* ... fill in those options you care about
	* LLVMCreateMCJITCompilerForModule(&jit, mod, &options, sizeof(options),
	*                                  &error);
	*
	* Note that this is also correct, though possibly suboptimal:
	*
	* LLVMCreateMCJITCompilerForModule(&jit, mod, 0, 0, &error);
	*/
	CreateMCJITCompilerForModule    :: proc(OutJIT: ^ExecutionEngineRef, M: ModuleRef, Options: ^MCJITCompilerOptions, SizeOfOptions: c.size_t, OutError: ^cstring) -> Bool ---
	DisposeExecutionEngine          :: proc(EE: ExecutionEngineRef) ---
	RunStaticConstructors           :: proc(EE: ExecutionEngineRef) ---
	RunStaticDestructors            :: proc(EE: ExecutionEngineRef) ---
	RunFunctionAsMain               :: proc(EE: ExecutionEngineRef, F: ValueRef, ArgC: u32, ArgV: ^cstring, EnvP: ^cstring) -> i32 ---
	RunFunction                     :: proc(EE: ExecutionEngineRef, F: ValueRef, NumArgs: u32, Args: ^GenericValueRef) -> GenericValueRef ---
	FreeMachineCodeForFunction      :: proc(EE: ExecutionEngineRef, F: ValueRef) ---
	AddModule                       :: proc(EE: ExecutionEngineRef, M: ModuleRef) ---
	RemoveModule                    :: proc(EE: ExecutionEngineRef, M: ModuleRef, OutMod: ^ModuleRef, OutError: ^cstring) -> Bool ---
	FindFunction                    :: proc(EE: ExecutionEngineRef, Name: cstring, OutFn: ^ValueRef) -> Bool ---
	RecompileAndRelinkFunction      :: proc(EE: ExecutionEngineRef, Fn: ValueRef) -> rawptr ---
	GetExecutionEngineTargetData    :: proc(EE: ExecutionEngineRef) -> TargetDataRef ---
	GetExecutionEngineTargetMachine :: proc(EE: ExecutionEngineRef) -> TargetMachineRef ---
	AddGlobalMapping                :: proc(EE: ExecutionEngineRef, Global: ValueRef, Addr: rawptr) ---
	GetPointerToGlobal              :: proc(EE: ExecutionEngineRef, Global: ValueRef) -> rawptr ---
	GetGlobalValueAddress           :: proc(EE: ExecutionEngineRef, Name: cstring) -> u64 ---
	GetFunctionAddress              :: proc(EE: ExecutionEngineRef, Name: cstring) -> u64 ---

	/// Returns true on error, false on success. If true is returned then the error
	/// message is copied to OutStr and cleared in the ExecutionEngine instance.
	ExecutionEngineGetErrMsg :: proc(EE: ExecutionEngineRef, OutError: ^cstring) -> Bool ---
}

/*===-- Operations on memory managers -------------------------------------===*/
MemoryManagerAllocateCodeSectionCallback :: proc "c" (Opaque: rawptr, Size: c.uintptr_t, Alignment: u32, SectionID: u32, SectionName: cstring) -> ^u8
MemoryManagerAllocateDataSectionCallback :: proc "c" (Opaque: rawptr, Size: c.uintptr_t, Alignment: u32, SectionID: u32, SectionName: cstring, IsReadOnly: Bool) -> ^u8
MemoryManagerFinalizeMemoryCallback      :: proc "c" (Opaque: rawptr, ErrMsg: ^cstring) -> Bool
MemoryManagerDestroyCallback             :: proc "c" (Opaque: rawptr)

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Create a simple custom MCJIT memory manager. This memory manager can
	* intercept allocations in a module-oblivious way. This will return NULL
	* if any of the passed functions are NULL.
	*
	* @param Opaque An opaque client object to pass back to the callbacks.
	* @param AllocateCodeSection Allocate a block of memory for executable code.
	* @param AllocateDataSection Allocate a block of memory for data.
	* @param FinalizeMemory Set page permissions and flush cache. Return 0 on
	*   success, 1 on error.
	*/
	CreateSimpleMCJITMemoryManager :: proc(Opaque: rawptr, AllocateCodeSection: MemoryManagerAllocateCodeSectionCallback, AllocateDataSection: MemoryManagerAllocateDataSectionCallback, FinalizeMemory: MemoryManagerFinalizeMemoryCallback, Destroy: MemoryManagerDestroyCallback) -> MCJITMemoryManagerRef ---
	DisposeMCJITMemoryManager      :: proc(MM: MCJITMemoryManagerRef) ---

	/*===-- JIT Event Listener functions -------------------------------------===*/
	CreateGDBRegistrationListener  :: proc() -> JITEventListenerRef ---
	CreateIntelJITEventListener    :: proc() -> JITEventListenerRef ---
	CreateOProfileJITEventListener :: proc() -> JITEventListenerRef ---
	CreatePerfJITEventListener     :: proc() -> JITEventListenerRef ---
}

