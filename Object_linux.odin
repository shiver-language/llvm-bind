/*===-- llvm-c/Object.h - Object Lib C Iface --------------------*- C++ -*-===*/
/*                                                                            */
/* Part of the LLVM Project, under the Apache License v2.0 with LLVM          */
/* Exceptions.                                                                */
/* See https://llvm.org/LICENSE.txt for license information.                  */
/* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    */
/*                                                                            */
/*===----------------------------------------------------------------------===*/
/*                                                                            */
/* This header declares the C interface to libLLVMObject.a, which             */
/* implements object file reading and writing.                                */
/*                                                                            */
/* Many exotic languages can interoperate with C code but have a harder time  */
/* with C++ due to name mangling. So in addition to C, this interface enables */
/* tools written in such languages.                                           */
/*                                                                            */
/*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "system:LLVM"


OpaqueSectionIterator :: struct {}

// Opaque type wrappers
SectionIteratorRef       :: ^OpaqueSectionIterator
OpaqueSymbolIterator     :: struct {}
SymbolIteratorRef        :: ^OpaqueSymbolIterator
OpaqueRelocationIterator :: struct {}
RelocationIteratorRef    :: ^OpaqueRelocationIterator

BinaryType :: enum u32 {
	Archive              = 0,  /**< Archive file. */
	MachOUniversalBinary = 1,  /**< Mach-O Universal Binary file. */
	COFFImportFile       = 2,  /**< COFF Import file. */
	IR                   = 3,  /**< LLVM IR. */
	WinRes               = 4,  /**< Windows resource (.res) file. */
	COFF                 = 5,  /**< COFF Object file. */
	ELF32L               = 6,  /**< ELF 32-bit, little endian. */
	ELF32B               = 7,  /**< ELF 32-bit, big endian. */
	ELF64L               = 8,  /**< ELF 64-bit, little endian. */
	ELF64B               = 9,  /**< ELF 64-bit, big endian. */
	MachO32L             = 10, /**< MachO 32-bit, little endian. */
	MachO32B             = 11, /**< MachO 32-bit, big endian. */
	MachO64L             = 12, /**< MachO 64-bit, little endian. */
	MachO64B             = 13, /**< MachO 64-bit, big endian. */
	Wasm                 = 14, /**< Web Assembly. */
	Offload              = 15, /**< Offloading fatbinary. */
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Create a binary file from the given memory buffer.
	*
	* The exact type of the binary file will be inferred automatically, and the
	* appropriate implementation selected.  The context may be NULL except if
	* the resulting file is an LLVM IR file.
	*
	* The memory buffer is not consumed by this function.  It is the responsibilty
	* of the caller to free it with \c LLVMDisposeMemoryBuffer.
	*
	* If NULL is returned, the \p ErrorMessage parameter is populated with the
	* error's description.  It is then the caller's responsibility to free this
	* message by calling \c LLVMDisposeMessage.
	*
	* @see llvm::object::createBinary
	*/
	CreateBinary :: proc(MemBuf: MemoryBufferRef, Context: ContextRef, ErrorMessage: ^cstring) -> BinaryRef ---

	/**
	* Dispose of a binary file.
	*
	* The binary file does not own its backing buffer.  It is the responsibilty
	* of the caller to free it with \c LLVMDisposeMemoryBuffer.
	*/
	DisposeBinary :: proc(BR: BinaryRef) ---

	/**
	* Retrieves a copy of the memory buffer associated with this object file.
	*
	* The returned buffer is merely a shallow copy and does not own the actual
	* backing buffer of the binary. Nevertheless, it is the responsibility of the
	* caller to free it with \c LLVMDisposeMemoryBuffer.
	*
	* @see llvm::object::getMemoryBufferRef
	*/
	BinaryCopyMemoryBuffer :: proc(BR: BinaryRef) -> MemoryBufferRef ---

	/**
	* Retrieve the specific type of a binary.
	*
	* @see llvm::object::Binary::getType
	*/
	BinaryGetType :: proc(BR: BinaryRef) -> BinaryType ---

	/*
	* For a Mach-O universal binary file, retrieves the object file corresponding
	* to the given architecture if it is present as a slice.
	*
	* If NULL is returned, the \p ErrorMessage parameter is populated with the
	* error's description.  It is then the caller's responsibility to free this
	* message by calling \c LLVMDisposeMessage.
	*
	* It is the responsiblity of the caller to free the returned object file by
	* calling \c LLVMDisposeBinary.
	*/
	MachOUniversalBinaryCopyObjectForArch :: proc(BR: BinaryRef, Arch: cstring, ArchLen: c.size_t, ErrorMessage: ^cstring) -> BinaryRef ---

	/**
	* Retrieve a copy of the section iterator for this object file.
	*
	* If there are no sections, the result is NULL.
	*
	* The returned iterator is merely a shallow copy. Nevertheless, it is
	* the responsibility of the caller to free it with
	* \c LLVMDisposeSectionIterator.
	*
	* @see llvm::object::sections()
	*/
	ObjectFileCopySectionIterator :: proc(BR: BinaryRef) -> SectionIteratorRef ---

	/**
	* Returns whether the given section iterator is at the end.
	*
	* @see llvm::object::section_end
	*/
	ObjectFileIsSectionIteratorAtEnd :: proc(BR: BinaryRef, SI: SectionIteratorRef) -> Bool ---

	/**
	* Retrieve a copy of the symbol iterator for this object file.
	*
	* If there are no symbols, the result is NULL.
	*
	* The returned iterator is merely a shallow copy. Nevertheless, it is
	* the responsibility of the caller to free it with
	* \c LLVMDisposeSymbolIterator.
	*
	* @see llvm::object::symbols()
	*/
	ObjectFileCopySymbolIterator :: proc(BR: BinaryRef) -> SymbolIteratorRef ---

	/**
	* Returns whether the given symbol iterator is at the end.
	*
	* @see llvm::object::symbol_end
	*/
	ObjectFileIsSymbolIteratorAtEnd :: proc(BR: BinaryRef, SI: SymbolIteratorRef) -> Bool ---
	DisposeSectionIterator          :: proc(SI: SectionIteratorRef) ---
	MoveToNextSection               :: proc(SI: SectionIteratorRef) ---
	MoveToContainingSection         :: proc(Sect: SectionIteratorRef, Sym: SymbolIteratorRef) ---

	// ObjectFile Symbol iterators
	DisposeSymbolIterator :: proc(SI: SymbolIteratorRef) ---
	MoveToNextSymbol      :: proc(SI: SymbolIteratorRef) ---

	// SectionRef accessors
	GetSectionName           :: proc(SI: SectionIteratorRef) -> cstring ---
	GetSectionSize           :: proc(SI: SectionIteratorRef) -> u64 ---
	GetSectionContents       :: proc(SI: SectionIteratorRef) -> cstring ---
	GetSectionAddress        :: proc(SI: SectionIteratorRef) -> u64 ---
	GetSectionContainsSymbol :: proc(SI: SectionIteratorRef, Sym: SymbolIteratorRef) -> Bool ---

	// Section Relocation iterators
	GetRelocations            :: proc(Section: SectionIteratorRef) -> RelocationIteratorRef ---
	DisposeRelocationIterator :: proc(RI: RelocationIteratorRef) ---
	IsRelocationIteratorAtEnd :: proc(Section: SectionIteratorRef, RI: RelocationIteratorRef) -> Bool ---
	MoveToNextRelocation      :: proc(RI: RelocationIteratorRef) ---

	// SymbolRef accessors
	GetSymbolName    :: proc(SI: SymbolIteratorRef) -> cstring ---
	GetSymbolAddress :: proc(SI: SymbolIteratorRef) -> u64 ---
	GetSymbolSize    :: proc(SI: SymbolIteratorRef) -> u64 ---

	// RelocationRef accessors
	GetRelocationOffset :: proc(RI: RelocationIteratorRef) -> u64 ---
	GetRelocationSymbol :: proc(RI: RelocationIteratorRef) -> SymbolIteratorRef ---
	GetRelocationType   :: proc(RI: RelocationIteratorRef) -> u64 ---

	// NOTE: Caller takes ownership of returned string of the two
	// following functions.
	GetRelocationTypeName    :: proc(RI: RelocationIteratorRef) -> cstring ---
	GetRelocationValueString :: proc(RI: RelocationIteratorRef) -> cstring ---
}

OpaqueObjectFile :: struct {}

/** Deprecated: Use LLVMBinaryRef instead. */
ObjectFileRef :: ^OpaqueObjectFile

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/** Deprecated: Use LLVMCreateBinary instead. */
	CreateObjectFile :: proc(MemBuf: MemoryBufferRef) -> ObjectFileRef ---

	/** Deprecated: Use LLVMDisposeBinary instead. */
	DisposeObjectFile :: proc(ObjectFile: ObjectFileRef) ---

	/** Deprecated: Use LLVMObjectFileCopySectionIterator instead. */
	GetSections :: proc(ObjectFile: ObjectFileRef) -> SectionIteratorRef ---

	/** Deprecated: Use LLVMObjectFileIsSectionIteratorAtEnd instead. */
	IsSectionIteratorAtEnd :: proc(ObjectFile: ObjectFileRef, SI: SectionIteratorRef) -> Bool ---

	/** Deprecated: Use LLVMObjectFileCopySymbolIterator instead. */
	GetSymbols :: proc(ObjectFile: ObjectFileRef) -> SymbolIteratorRef ---

	/** Deprecated: Use LLVMObjectFileIsSymbolIteratorAtEnd instead. */
	IsSymbolIteratorAtEnd :: proc(ObjectFile: ObjectFileRef, SI: SymbolIteratorRef) -> Bool ---
}

