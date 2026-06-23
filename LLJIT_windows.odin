/*===----------- llvm-c/LLJIT.h - OrcV2 LLJIT C bindings ----------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to the LLJIT class in                 *|
|* libLLVMOrcJIT.a, which provides a simple MCJIT-like ORC JIT.               *|
|*                                                                            *|
|* Many exotic languages can interoperate with C code but have a harder time  *|
|* with C++ due to name mangling. So in addition to C, this interface enables *|
|* tools written in such languages.                                           *|
|*                                                                            *|
|* Note: This interface is experimental. It is *NOT* stable, and may be       *|
|*       changed without warning. Only C API usage documentation is           *|
|*       provided. See the C++ documentation for all higher level ORC API     *|
|*       details.                                                             *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


/**
* A function for constructing an ObjectLinkingLayer instance to be used
* by an LLJIT instance.
*
* Clients can call LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator to
* set the creator function to use when constructing an LLJIT instance.
* This can be used to override the default linking layer implementation
* that would otherwise be chosen by LLJITBuilder.
*
* Object linking layers returned by this function will become owned by the
* LLJIT instance. The client is not responsible for managing their lifetimes
* after the function returns.
*/
OrcLLJITBuilderObjectLinkingLayerCreatorFunction :: proc "c" (Ctx: rawptr, ES: OrcExecutionSessionRef, Triple: cstring) -> OrcObjectLayerRef
OrcOpaqueLLJITBuilder                            :: struct {}

/**
* A reference to an orc::LLJITBuilder instance.
*/
OrcLLJITBuilderRef :: ^OrcOpaqueLLJITBuilder
OrcOpaqueLLJIT     :: struct {}

/**
* A reference to an orc::LLJIT instance.
*/
OrcLLJITRef :: ^OrcOpaqueLLJIT

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Create an LLVMOrcLLJITBuilder.
	*
	* The client owns the resulting LLJITBuilder and should dispose of it using
	* LLVMOrcDisposeLLJITBuilder once they are done with it.
	*/
	OrcCreateLLJITBuilder :: proc() -> OrcLLJITBuilderRef ---

	/**
	* Dispose of an LLVMOrcLLJITBuilderRef. This should only be called if ownership
	* has not been passed to LLVMOrcCreateLLJIT (e.g. because some error prevented
	* that function from being called).
	*/
	OrcDisposeLLJITBuilder :: proc(Builder: OrcLLJITBuilderRef) ---

	/**
	* Set the JITTargetMachineBuilder to be used when constructing the LLJIT
	* instance. Calling this function is optional: if it is not called then the
	* LLJITBuilder will use JITTargeTMachineBuilder::detectHost to construct a
	* JITTargetMachineBuilder.
	*
	* This function takes ownership of the JTMB argument: clients should not
	* dispose of the JITTargetMachineBuilder after calling this function.
	*/
	OrcLLJITBuilderSetJITTargetMachineBuilder :: proc(Builder: OrcLLJITBuilderRef, JTMB: OrcJITTargetMachineBuilderRef) ---

	/**
	* Set an ObjectLinkingLayer creator function for this LLJIT instance.
	*/
	OrcLLJITBuilderSetObjectLinkingLayerCreator :: proc(Builder: OrcLLJITBuilderRef, F: OrcLLJITBuilderObjectLinkingLayerCreatorFunction, Ctx: rawptr) ---

	/**
	* Create an LLJIT instance from an LLJITBuilder.
	*
	* This operation takes ownership of the Builder argument: clients should not
	* dispose of the builder after calling this function (even if the function
	* returns an error). If a null Builder argument is provided then a
	* default-constructed LLJITBuilder will be used.
	*
	* On success the resulting LLJIT instance is uniquely owned by the client and
	* automatically manages the memory of all JIT'd code and all modules that are
	* transferred to it (e.g. via LLVMOrcLLJITAddLLVMIRModule). Disposing of the
	* LLJIT instance will free all memory managed by the JIT, including JIT'd code
	* and not-yet compiled modules.
	*/
	OrcCreateLLJIT :: proc(Result: ^OrcLLJITRef, Builder: OrcLLJITBuilderRef) -> ErrorRef ---

	/**
	* Dispose of an LLJIT instance.
	*/
	OrcDisposeLLJIT :: proc(J: OrcLLJITRef) -> ErrorRef ---

	/**
	* Get a reference to the ExecutionSession for this LLJIT instance.
	*
	* The ExecutionSession is owned by the LLJIT instance. The client is not
	* responsible for managing its memory.
	*/
	OrcLLJITGetExecutionSession :: proc(J: OrcLLJITRef) -> OrcExecutionSessionRef ---

	/**
	* Return a reference to the Main JITDylib.
	*
	* The JITDylib is owned by the LLJIT instance. The client is not responsible
	* for managing its memory.
	*/
	OrcLLJITGetMainJITDylib :: proc(J: OrcLLJITRef) -> OrcJITDylibRef ---

	/**
	* Return the target triple for this LLJIT instance. This string is owned by
	* the LLJIT instance and should not be freed by the client.
	*/
	OrcLLJITGetTripleString :: proc(J: OrcLLJITRef) -> cstring ---

	/**
	* Returns the global prefix character according to the LLJIT's DataLayout.
	*/
	OrcLLJITGetGlobalPrefix :: proc(J: OrcLLJITRef) -> i8 ---

	/**
	* Mangles the given string according to the LLJIT instance's DataLayout, then
	* interns the result in the SymbolStringPool and returns a reference to the
	* pool entry. Clients should call LLVMOrcReleaseSymbolStringPoolEntry to
	* decrement the ref-count on the pool entry once they are finished with this
	* value.
	*/
	OrcLLJITMangleAndIntern :: proc(J: OrcLLJITRef, UnmangledName: cstring) -> OrcSymbolStringPoolEntryRef ---

	/**
	* Add a buffer representing an object file to the given JITDylib in the given
	* LLJIT instance. This operation transfers ownership of the buffer to the
	* LLJIT instance. The buffer should not be disposed of or referenced once this
	* function returns.
	*
	* Resources associated with the given object will be tracked by the given
	* JITDylib's default resource tracker.
	*/
	OrcLLJITAddObjectFile :: proc(J: OrcLLJITRef, JD: OrcJITDylibRef, ObjBuffer: MemoryBufferRef) -> ErrorRef ---

	/**
	* Add a buffer representing an object file to the given ResourceTracker's
	* JITDylib in the given LLJIT instance. This operation transfers ownership of
	* the buffer to the LLJIT instance. The buffer should not be disposed of or
	* referenced once this function returns.
	*
	* Resources associated with the given object will be tracked by ResourceTracker
	* RT.
	*/
	OrcLLJITAddObjectFileWithRT :: proc(J: OrcLLJITRef, RT: OrcResourceTrackerRef, ObjBuffer: MemoryBufferRef) -> ErrorRef ---

	/**
	* Add an IR module to the given JITDylib in the given LLJIT instance. This
	* operation transfers ownership of the TSM argument to the LLJIT instance.
	* The TSM argument should not be disposed of or referenced once this
	* function returns.
	*
	* Resources associated with the given Module will be tracked by the given
	* JITDylib's default resource tracker.
	*/
	OrcLLJITAddLLVMIRModule :: proc(J: OrcLLJITRef, JD: OrcJITDylibRef, TSM: OrcThreadSafeModuleRef) -> ErrorRef ---

	/**
	* Add an IR module to the given ResourceTracker's JITDylib in the given LLJIT
	* instance. This operation transfers ownership of the TSM argument to the LLJIT
	* instance. The TSM argument should not be disposed of or referenced once this
	* function returns.
	*
	* Resources associated with the given Module will be tracked by ResourceTracker
	* RT.
	*/
	OrcLLJITAddLLVMIRModuleWithRT :: proc(J: OrcLLJITRef, JD: OrcResourceTrackerRef, TSM: OrcThreadSafeModuleRef) -> ErrorRef ---

	/**
	* Look up the given symbol in the main JITDylib of the given LLJIT instance.
	*
	* This operation does not take ownership of the Name argument.
	*/
	OrcLLJITLookup :: proc(J: OrcLLJITRef, Result: ^OrcExecutorAddress, Name: cstring) -> ErrorRef ---

	/**
	* Returns a non-owning reference to the LLJIT instance's object linking layer.
	*/
	OrcLLJITGetObjLinkingLayer :: proc(J: OrcLLJITRef) -> OrcObjectLayerRef ---

	/**
	* Returns a non-owning reference to the LLJIT instance's object linking layer.
	*/
	OrcLLJITGetObjTransformLayer :: proc(J: OrcLLJITRef) -> OrcObjectTransformLayerRef ---

	/**
	* Returns a non-owning reference to the LLJIT instance's IR transform layer.
	*/
	OrcLLJITGetIRTransformLayer :: proc(J: OrcLLJITRef) -> OrcIRTransformLayerRef ---

	/**
	* Get the LLJIT instance's default data layout string.
	*
	* This string is owned by the LLJIT instance and does not need to be freed
	* by the caller.
	*/
	OrcLLJITGetDataLayoutStr :: proc(J: OrcLLJITRef) -> cstring ---
}

