/*===-- llvm-c/Target.h - Target Lib C Iface --------------------*- C++ -*-===*/
/*                                                                            */
/* Part of the LLVM Project, under the Apache License v2.0 with LLVM          */
/* Exceptions.                                                                */
/* See https://llvm.org/LICENSE.txt for license information.                  */
/* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    */
/*                                                                            */
/*===----------------------------------------------------------------------===*/
/*                                                                            */
/* This header declares the C interface to libLLVMTarget.a, which             */
/* implements target information.                                             */
/*                                                                            */
/* Many exotic languages can interoperate with C code but have a harder time  */
/* with C++ due to name mangling. So in addition to C, this interface enables */
/* tools written in such languages.                                           */
/*                                                                            */
/*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


/**
* @defgroup LLVMCTarget Target information
* @ingroup LLVMC
*
* @{
*/
ByteOrdering :: enum i32 {
	/**
	* @defgroup LLVMCTarget Target information
	* @ingroup LLVMC
	*
	* @{
	*/
	BigEndian    = 0,

	/**
	* @defgroup LLVMCTarget Target information
	* @ingroup LLVMC
	*
	* @{
	*/
	LittleEndian = 1,
}

OpaqueTargetData             :: struct {}
TargetDataRef                :: ^OpaqueTargetData
OpaqueTargetLibraryInfotData :: struct {}
TargetLibraryInfoRef         :: ^OpaqueTargetLibraryInfotData

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Obtain the data layout for a module.
	*
	* @see Module::getDataLayout()
	*/
	GetModuleDataLayout :: proc(M: ModuleRef) -> TargetDataRef ---

	/**
	* Set the data layout for a module.
	*
	* @see Module::setDataLayout()
	*/
	SetModuleDataLayout :: proc(M: ModuleRef, DL: TargetDataRef) ---

	/** Creates target data from a target layout string.
	See the constructor llvm::DataLayout::DataLayout. */
	CreateTargetData :: proc(StringRep: cstring) -> TargetDataRef ---

	/** Deallocates a TargetData.
	See the destructor llvm::DataLayout::~DataLayout. */
	DisposeTargetData :: proc(TD: TargetDataRef) ---

	/** Adds target library information to a pass manager. This does not take
	ownership of the target library info.
	See the method llvm::PassManagerBase::add. */
	AddTargetLibraryInfo :: proc(TLI: TargetLibraryInfoRef, PM: PassManagerRef) ---

	/** Converts target data to a target layout string. The string must be disposed
	with LLVMDisposeMessage.
	See the constructor llvm::DataLayout::DataLayout. */
	CopyStringRepOfTargetData :: proc(TD: TargetDataRef) -> cstring ---

	/** Returns the byte order of a target, either LLVMBigEndian or
	LLVMLittleEndian.
	See the method llvm::DataLayout::isLittleEndian. */
	ByteOrder :: proc(TD: TargetDataRef) -> ByteOrdering ---

	/** Returns the pointer size in bytes for a target.
	See the method llvm::DataLayout::getPointerSize. */
	PointerSize :: proc(TD: TargetDataRef) -> u32 ---

	/** Returns the pointer size in bytes for a target for a specified
	address space.
	See the method llvm::DataLayout::getPointerSize. */
	PointerSizeForAS :: proc(TD: TargetDataRef, AS: u32) -> u32 ---

	/** Returns the integer type that is the same size as a pointer on a target.
	See the method llvm::DataLayout::getIntPtrType. */
	IntPtrType :: proc(TD: TargetDataRef) -> TypeRef ---

	/** Returns the integer type that is the same size as a pointer on a target.
	This version allows the address space to be specified.
	See the method llvm::DataLayout::getIntPtrType. */
	IntPtrTypeForAS :: proc(TD: TargetDataRef, AS: u32) -> TypeRef ---

	/** Returns the integer type that is the same size as a pointer on a target.
	See the method llvm::DataLayout::getIntPtrType. */
	IntPtrTypeInContext :: proc(C: ContextRef, TD: TargetDataRef) -> TypeRef ---

	/** Returns the integer type that is the same size as a pointer on a target.
	This version allows the address space to be specified.
	See the method llvm::DataLayout::getIntPtrType. */
	IntPtrTypeForASInContext :: proc(C: ContextRef, TD: TargetDataRef, AS: u32) -> TypeRef ---

	/** Computes the size of a type in bits for a target.
	See the method llvm::DataLayout::getTypeSizeInBits. */
	SizeOfTypeInBits :: proc(TD: TargetDataRef, Ty: TypeRef) -> u64 ---

	/** Computes the storage size of a type in bytes for a target.
	See the method llvm::DataLayout::getTypeStoreSize. */
	StoreSizeOfType :: proc(TD: TargetDataRef, Ty: TypeRef) -> u64 ---

	/** Computes the ABI size of a type in bytes for a target.
	See the method llvm::DataLayout::getTypeAllocSize. */
	ABISizeOfType :: proc(TD: TargetDataRef, Ty: TypeRef) -> u64 ---

	/** Computes the ABI alignment of a type in bytes for a target.
	See the method llvm::DataLayout::getTypeABISize. */
	ABIAlignmentOfType :: proc(TD: TargetDataRef, Ty: TypeRef) -> u32 ---

	/** Computes the call frame alignment of a type in bytes for a target.
	See the method llvm::DataLayout::getTypeABISize. */
	CallFrameAlignmentOfType :: proc(TD: TargetDataRef, Ty: TypeRef) -> u32 ---

	/** Computes the preferred alignment of a type in bytes for a target.
	See the method llvm::DataLayout::getTypeABISize. */
	PreferredAlignmentOfType :: proc(TD: TargetDataRef, Ty: TypeRef) -> u32 ---

	/** Computes the preferred alignment of a global variable in bytes for a target.
	See the method llvm::DataLayout::getPreferredAlignment. */
	PreferredAlignmentOfGlobal :: proc(TD: TargetDataRef, GlobalVar: ValueRef) -> u32 ---

	/** Computes the structure element that contains the byte offset for a target.
	See the method llvm::StructLayout::getElementContainingOffset. */
	ElementAtOffset :: proc(TD: TargetDataRef, StructTy: TypeRef, Offset: u64) -> u32 ---

	/** Computes the byte offset of the indexed struct element for a target.
	See the method llvm::StructLayout::getElementContainingOffset. */
	OffsetOfElement :: proc(TD: TargetDataRef, StructTy: TypeRef, Element: u32) -> u64 ---
}

