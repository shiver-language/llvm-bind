//===------------ DebugInfo.h - LLVM C API Debug Info API -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// This file declares the C API endpoints for generating DWARF Debug Info
///
/// Note: This interface is experimental. It is *NOT* stable, and may be
///       changed without warning.
///
//===----------------------------------------------------------------------===//
package llvm

import "core:c"

foreign import lib "system:LLVM"


/**
* Debug info flags.
*/
DIFlags :: enum u32 {
	Zero                = 0,
	Private             = 1,
	Protected           = 2,
	Public              = 3,
	FwdDecl             = 4,
	AppleBlock          = 8,
	ReservedBit4        = 16,
	Virtual             = 32,
	Artificial          = 64,
	Explicit            = 128,
	Prototyped          = 256,
	ObjcClassComplete   = 512,
	ObjectPointer       = 1024,
	Vector              = 2048,
	StaticMember        = 4096,
	LValueReference     = 8192,
	RValueReference     = 16384,
	Reserved            = 32768,
	SingleInheritance   = 65536,
	MultipleInheritance = 131072,
	VirtualInheritance  = 196608,
	IntroducedVirtual   = 262144,
	BitField            = 524288,
	NoReturn            = 1048576,
	TypePassByValue     = 4194304,
	TypePassByReference = 8388608,
	EnumClass           = 16777216,
	FixedEnum           = 16777216, // Deprecated.
	Thunk               = 33554432,
	NonTrivial          = 67108864,
	BigEndian           = 134217728,
	LittleEndian        = 268435456,
	IndirectVirtualBase = 36,
	Accessibility       = 3,
	PtrToMemberRep      = 196608,
}

/**
* Source languages known by DWARF.
*/
DWARFSourceLanguage :: enum u32 {
	C89                 = 0,
	C                   = 1,
	Ada83               = 2,
	C_plus_plus         = 3,
	Cobol74             = 4,
	Cobol85             = 5,
	Fortran77           = 6,
	Fortran90           = 7,
	Pascal83            = 8,
	Modula2             = 9,

	// New in DWARF v3:
	Java                = 10,
	C99                 = 11,
	Ada95               = 12,
	Fortran95           = 13,
	PLI                 = 14,
	ObjC                = 15,
	ObjC_plus_plus      = 16,
	UPC                 = 17,
	D                   = 18,

	// New in DWARF v4:
	Python              = 19,

	// New in DWARF v5:
	OpenCL              = 20,
	Go                  = 21,
	Modula3             = 22,
	Haskell             = 23,
	C_plus_plus_03      = 24,
	C_plus_plus_11      = 25,
	OCaml               = 26,
	Rust                = 27,
	C11                 = 28,
	Swift               = 29,
	Julia               = 30,
	Dylan               = 31,
	C_plus_plus_14      = 32,
	Fortran03           = 33,
	Fortran08           = 34,
	RenderScript        = 35,
	BLISS               = 36,
	Kotlin              = 37,
	Zig                 = 38,
	Crystal             = 39,
	C_plus_plus_17      = 40,
	C_plus_plus_20      = 41,
	C17                 = 42,
	Fortran18           = 43,
	Ada2005             = 44,
	Ada2012             = 45,
	HIP                 = 46,
	Assembly            = 47,
	C_sharp             = 48,
	Mojo                = 49,
	GLSL                = 50,
	GLSL_ES             = 51,
	HLSL                = 52,
	OpenCL_CPP          = 53,
	CPP_for_OpenCL      = 54,
	SYCL                = 55,
	Ruby                = 56,
	Move                = 57,
	Hylo                = 58,
	Metal               = 59,

	// Vendor extensions:
	Mips_Assembler      = 60,
	GOOGLE_RenderScript = 61,
	BORLAND_Delphi      = 62,
}

/**
* The amount of debug information to emit.
*/
DWARFEmissionKind :: enum u32 {
	None           = 0,
	Full           = 1,
	LineTablesOnly = 2,
}

LLVMMDStringMetadataKind                     :: 0
LLVMConstantAsMetadataMetadataKind           :: 1
LLVMLocalAsMetadataMetadataKind              :: 2
LLVMDistinctMDOperandPlaceholderMetadataKind :: 3
LLVMMDTupleMetadataKind                      :: 4
LLVMDILocationMetadataKind                   :: 5
LLVMDIExpressionMetadataKind                 :: 6
LLVMDIGlobalVariableExpressionMetadataKind   :: 7
LLVMGenericDINodeMetadataKind                :: 8
LLVMDISubrangeMetadataKind                   :: 9
LLVMDIEnumeratorMetadataKind                 :: 10
LLVMDIBasicTypeMetadataKind                  :: 11
LLVMDIDerivedTypeMetadataKind                :: 12
LLVMDICompositeTypeMetadataKind              :: 13
LLVMDISubroutineTypeMetadataKind             :: 14
LLVMDIFileMetadataKind                       :: 15
LLVMDICompileUnitMetadataKind                :: 16
LLVMDISubprogramMetadataKind                 :: 17
LLVMDILexicalBlockMetadataKind               :: 18
LLVMDILexicalBlockFileMetadataKind           :: 19
LLVMDINamespaceMetadataKind                  :: 20
LLVMDIModuleMetadataKind                     :: 21
LLVMDITemplateTypeParameterMetadataKind      :: 22
LLVMDITemplateValueParameterMetadataKind     :: 23
LLVMDIGlobalVariableMetadataKind             :: 24
LLVMDILocalVariableMetadataKind              :: 25
LLVMDILabelMetadataKind                      :: 26
LLVMDIObjCPropertyMetadataKind               :: 27
LLVMDIImportedEntityMetadataKind             :: 28
LLVMDIMacroMetadataKind                      :: 29
LLVMDIMacroFileMetadataKind                  :: 30
LLVMDICommonBlockMetadataKind                :: 31
LLVMDIStringTypeMetadataKind                 :: 32
LLVMDIGenericSubrangeMetadataKind            :: 33
LLVMDIArgListMetadataKind                    :: 34
LLVMDIAssignIDMetadataKind                   :: 35
LLVMDISubrangeTypeMetadataKind               :: 36
LLVMDIFixedPointTypeMetadataKind             :: 37

MetadataKind :: u32

/**
* An LLVM DWARF type encoding.
*/
DWARFTypeEncoding :: u32

/**
* Describes the kind of macro declaration used for LLVMDIBuilderCreateMacro.
* @see llvm::dwarf::MacinfoRecordType
* @note Values are from DW_MACINFO_* constants in the DWARF specification.
*/
DWARFMacinfoRecordType :: enum u32 {
	Define    = 1,
	Macro     = 2,
	StartFile = 3,
	EndFile   = 4,
	VendorExt = 255,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* The current debug metadata version number.
	*/
	DebugMetadataVersion :: proc() -> u32 ---

	/**
	* The version of debug metadata that's present in the provided \c Module.
	*/
	GetModuleDebugMetadataVersion :: proc(Module: ModuleRef) -> u32 ---

	/**
	* Strip debug info in the module if it exists.
	* To do this, we remove all calls to the debugger intrinsics and any named
	* metadata for debugging. We also remove debug locations for instructions.
	* Return true if module is modified.
	*/
	StripModuleDebugInfo :: proc(Module: ModuleRef) -> Bool ---

	/**
	* Construct a builder for a module, and do not allow for unresolved nodes
	* attached to the module.
	*/
	CreateDIBuilderDisallowUnresolved :: proc(M: ModuleRef) -> DIBuilderRef ---

	/**
	* Construct a builder for a module and collect unresolved nodes attached
	* to the module in order to resolve cycles during a call to
	* \c LLVMDIBuilderFinalize.
	*/
	CreateDIBuilder :: proc(M: ModuleRef) -> DIBuilderRef ---

	/**
	* Deallocates the \c DIBuilder and everything it owns.
	* @note You must call \c LLVMDIBuilderFinalize before this
	*/
	DisposeDIBuilder :: proc(Builder: DIBuilderRef) ---

	/**
	* Construct any deferred debug info descriptors.
	*/
	DIBuilderFinalize :: proc(Builder: DIBuilderRef) ---

	/**
	* Finalize a specific subprogram.
	* No new variables may be added to this subprogram afterwards.
	*/
	DIBuilderFinalizeSubprogram :: proc(Builder: DIBuilderRef, Subprogram: MetadataRef) ---

	/**
	* A CompileUnit provides an anchor for all debugging
	* information generated during this instance of compilation.
	* \param Lang          Source programming language, eg.
	*                      \c LLVMDWARFSourceLanguageC99
	* \param FileRef       File info.
	* \param Producer      Identify the producer of debugging information
	*                      and code.  Usually this is a compiler
	*                      version string.
	* \param ProducerLen   The length of the C string passed to \c Producer.
	* \param isOptimized   A boolean flag which indicates whether optimization
	*                      is enabled or not.
	* \param Flags         This string lists command line options. This
	*                      string is directly embedded in debug info
	*                      output which may be used by a tool
	*                      analyzing generated debugging information.
	* \param FlagsLen      The length of the C string passed to \c Flags.
	* \param RuntimeVer    This indicates runtime version for languages like
	*                      Objective-C.
	* \param SplitName     The name of the file that we'll split debug info
	*                      out into.
	* \param SplitNameLen  The length of the C string passed to \c SplitName.
	* \param Kind          The kind of debug information to generate.
	* \param DWOId         The DWOId if this is a split skeleton compile unit.
	* \param SplitDebugInlining    Whether to emit inline debug info.
	* \param DebugInfoForProfiling Whether to emit extra debug info for
	*                              profile collection.
	* \param SysRoot         The Clang system root (value of -isysroot).
	* \param SysRootLen      The length of the C string passed to \c SysRoot.
	* \param SDK           The SDK. On Darwin, the last component of the sysroot.
	* \param SDKLen        The length of the C string passed to \c SDK.
	*/
	DIBuilderCreateCompileUnit :: proc(Builder: DIBuilderRef, Lang: DWARFSourceLanguage, FileRef: MetadataRef, Producer: cstring, ProducerLen: c.size_t, isOptimized: Bool, Flags: cstring, FlagsLen: c.size_t, RuntimeVer: u32, SplitName: cstring, SplitNameLen: c.size_t, Kind: DWARFEmissionKind, DWOId: u32, SplitDebugInlining: Bool, DebugInfoForProfiling: Bool, SysRoot: cstring, SysRootLen: c.size_t, SDK: cstring, SDKLen: c.size_t) -> MetadataRef ---

	/**
	* Create a file descriptor to hold debugging information for a file.
	* \param Builder      The \c DIBuilder.
	* \param Filename     File name.
	* \param FilenameLen  The length of the C string passed to \c Filename.
	* \param Directory    Directory.
	* \param DirectoryLen The length of the C string passed to \c Directory.
	*/
	DIBuilderCreateFile :: proc(Builder: DIBuilderRef, Filename: cstring, FilenameLen: c.size_t, Directory: cstring, DirectoryLen: c.size_t) -> MetadataRef ---

	/**
	* Creates a new descriptor for a module with the specified parent scope.
	* \param Builder         The \c DIBuilder.
	* \param ParentScope     The parent scope containing this module declaration.
	* \param Name            Module name.
	* \param NameLen         The length of the C string passed to \c Name.
	* \param ConfigMacros    A space-separated shell-quoted list of -D macro
	definitions as they would appear on a command line.
	* \param ConfigMacrosLen The length of the C string passed to \c ConfigMacros.
	* \param IncludePath     The path to the module map file.
	* \param IncludePathLen  The length of the C string passed to \c IncludePath.
	* \param APINotesFile    The path to an API notes file for the module.
	* \param APINotesFileLen The length of the C string passed to \c APINotestFile.
	*/
	DIBuilderCreateModule :: proc(Builder: DIBuilderRef, ParentScope: MetadataRef, Name: cstring, NameLen: c.size_t, ConfigMacros: cstring, ConfigMacrosLen: c.size_t, IncludePath: cstring, IncludePathLen: c.size_t, APINotesFile: cstring, APINotesFileLen: c.size_t) -> MetadataRef ---

	/**
	* Creates a new descriptor for a namespace with the specified parent scope.
	* \param Builder          The \c DIBuilder.
	* \param ParentScope      The parent scope containing this module declaration.
	* \param Name             NameSpace name.
	* \param NameLen          The length of the C string passed to \c Name.
	* \param ExportSymbols    Whether or not the namespace exports symbols, e.g.
	*                         this is true of C++ inline namespaces.
	*/
	DIBuilderCreateNameSpace :: proc(Builder: DIBuilderRef, ParentScope: MetadataRef, Name: cstring, NameLen: c.size_t, ExportSymbols: Bool) -> MetadataRef ---

	/**
	* Create a new descriptor for the specified subprogram.
	* \param Builder         The \c DIBuilder.
	* \param Scope           Function scope.
	* \param Name            Function name.
	* \param NameLen         Length of enumeration name.
	* \param LinkageName     Mangled function name.
	* \param LinkageNameLen  Length of linkage name.
	* \param File            File where this variable is defined.
	* \param LineNo          Line number.
	* \param Ty              Function type.
	* \param IsLocalToUnit   True if this function is not externally visible.
	* \param IsDefinition    True if this is a function definition.
	* \param ScopeLine       Set to the beginning of the scope this starts
	* \param Flags           E.g.: \c LLVMDIFlagLValueReference. These flags are
	*                        used to emit dwarf attributes.
	* \param IsOptimized     True if optimization is ON.
	*/
	DIBuilderCreateFunction :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, LinkageName: cstring, LinkageNameLen: c.size_t, File: MetadataRef, LineNo: u32, Ty: MetadataRef, IsLocalToUnit: Bool, IsDefinition: Bool, ScopeLine: u32, Flags: DIFlags, IsOptimized: Bool) -> MetadataRef ---

	/**
	* Create a descriptor for a lexical block with the specified parent context.
	* \param Builder      The \c DIBuilder.
	* \param Scope        Parent lexical block.
	* \param File         Source file.
	* \param Line         The line in the source file.
	* \param Column       The column in the source file.
	*/
	DIBuilderCreateLexicalBlock :: proc(Builder: DIBuilderRef, Scope: MetadataRef, File: MetadataRef, Line: u32, Column: u32) -> MetadataRef ---

	/**
	* Create a descriptor for a lexical block with a new file attached.
	* \param Builder        The \c DIBuilder.
	* \param Scope          Lexical block.
	* \param File           Source file.
	* \param Discriminator  DWARF path discriminator value.
	*/
	DIBuilderCreateLexicalBlockFile :: proc(Builder: DIBuilderRef, Scope: MetadataRef, File: MetadataRef, Discriminator: u32) -> MetadataRef ---

	/**
	* Create a descriptor for an imported namespace. Suitable for e.g. C++
	* using declarations.
	* \param Builder    The \c DIBuilder.
	* \param Scope      The scope this module is imported into
	* \param File       File where the declaration is located.
	* \param Line       Line number of the declaration.
	*/
	DIBuilderCreateImportedModuleFromNamespace :: proc(Builder: DIBuilderRef, Scope: MetadataRef, NS: MetadataRef, File: MetadataRef, Line: u32) -> MetadataRef ---

	/**
	* Create a descriptor for an imported module that aliases another
	* imported entity descriptor.
	* \param Builder        The \c DIBuilder.
	* \param Scope          The scope this module is imported into
	* \param ImportedEntity Previous imported entity to alias.
	* \param File           File where the declaration is located.
	* \param Line           Line number of the declaration.
	* \param Elements       Renamed elements.
	* \param NumElements    Number of renamed elements.
	*/
	DIBuilderCreateImportedModuleFromAlias :: proc(Builder: DIBuilderRef, Scope: MetadataRef, ImportedEntity: MetadataRef, File: MetadataRef, Line: u32, Elements: ^MetadataRef, NumElements: u32) -> MetadataRef ---

	/**
	* Create a descriptor for an imported module.
	* \param Builder        The \c DIBuilder.
	* \param Scope          The scope this module is imported into
	* \param M              The module being imported here
	* \param File           File where the declaration is located.
	* \param Line           Line number of the declaration.
	* \param Elements       Renamed elements.
	* \param NumElements    Number of renamed elements.
	*/
	DIBuilderCreateImportedModuleFromModule :: proc(Builder: DIBuilderRef, Scope: MetadataRef, M: MetadataRef, File: MetadataRef, Line: u32, Elements: ^MetadataRef, NumElements: u32) -> MetadataRef ---

	/**
	* Create a descriptor for an imported function, type, or variable.  Suitable
	* for e.g. FORTRAN-style USE declarations.
	* \param Builder        The DIBuilder.
	* \param Scope          The scope this module is imported into.
	* \param Decl           The declaration (or definition) of a function, type,
	or variable.
	* \param File           File where the declaration is located.
	* \param Line           Line number of the declaration.
	* \param Name           A name that uniquely identifies this imported
	declaration.
	* \param NameLen        The length of the C string passed to \c Name.
	* \param Elements       Renamed elements.
	* \param NumElements    Number of renamed elements.
	*/
	DIBuilderCreateImportedDeclaration :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Decl: MetadataRef, File: MetadataRef, Line: u32, Name: cstring, NameLen: c.size_t, Elements: ^MetadataRef, NumElements: u32) -> MetadataRef ---

	/**
	* Creates a new DebugLocation that describes a source location.
	* \param Line The line in the source file.
	* \param Column The column in the source file.
	* \param Scope The scope in which the location resides.
	* \param InlinedAt The scope where this location was inlined, if at all.
	*                  (optional).
	* \note If the item to which this location is attached cannot be
	*       attributed to a source line, pass 0 for the line and column.
	*/
	DIBuilderCreateDebugLocation :: proc(Ctx: ContextRef, Line: u32, Column: u32, Scope: MetadataRef, InlinedAt: MetadataRef) -> MetadataRef ---

	/**
	* Get the line number of this debug location.
	* \param Location     The debug location.
	*
	* @see DILocation::getLine()
	*/
	DILocationGetLine :: proc(Location: MetadataRef) -> u32 ---

	/**
	* Get the column number of this debug location.
	* \param Location     The debug location.
	*
	* @see DILocation::getColumn()
	*/
	DILocationGetColumn :: proc(Location: MetadataRef) -> u32 ---

	/**
	* Get the local scope associated with this debug location.
	* \param Location     The debug location.
	*
	* @see DILocation::getScope()
	*/
	DILocationGetScope :: proc(Location: MetadataRef) -> MetadataRef ---

	/**
	* Get the "inline at" location associated with this debug location.
	* \param Location     The debug location.
	*
	* @see DILocation::getInlinedAt()
	*/
	DILocationGetInlinedAt :: proc(Location: MetadataRef) -> MetadataRef ---

	/**
	* Get the metadata of the file associated with a given scope.
	* \param Scope     The scope object.
	*
	* @see DIScope::getFile()
	*/
	DIScopeGetFile :: proc(Scope: MetadataRef) -> MetadataRef ---

	/**
	* Get the directory of a given file.
	* \param File     The file object.
	* \param Len      The length of the returned string.
	*
	* @see DIFile::getDirectory()
	*/
	DIFileGetDirectory :: proc(File: MetadataRef, Len: ^u32) -> cstring ---

	/**
	* Get the name of a given file.
	* \param File     The file object.
	* \param Len      The length of the returned string.
	*
	* @see DIFile::getFilename()
	*/
	DIFileGetFilename :: proc(File: MetadataRef, Len: ^u32) -> cstring ---

	/**
	* Get the source of a given file.
	* \param File     The file object.
	* \param Len      The length of the returned string.
	*
	* @see DIFile::getSource()
	*/
	DIFileGetSource :: proc(File: MetadataRef, Len: ^u32) -> cstring ---

	/**
	* Create a type array.
	* \param Builder        The DIBuilder.
	* \param Data           The type elements.
	* \param NumElements    Number of type elements.
	*/
	DIBuilderGetOrCreateTypeArray :: proc(Builder: DIBuilderRef, Data: ^MetadataRef, NumElements: c.size_t) -> MetadataRef ---

	/**
	* Create subroutine type.
	* \param Builder        The DIBuilder.
	* \param File            The file in which the subroutine resides.
	* \param ParameterTypes  An array of subroutine parameter types. This
	*                        includes return type at 0th index.
	* \param NumParameterTypes The number of parameter types in \c ParameterTypes
	* \param Flags           E.g.: \c LLVMDIFlagLValueReference.
	*                        These flags are used to emit dwarf attributes.
	*/
	DIBuilderCreateSubroutineType :: proc(Builder: DIBuilderRef, File: MetadataRef, ParameterTypes: ^MetadataRef, NumParameterTypes: u32, Flags: DIFlags) -> MetadataRef ---

	/**
	* Create debugging information entry for a macro.
	* @param Builder         The DIBuilder.
	* @param ParentMacroFile Macro parent (could be NULL).
	* @param Line            Source line number where the macro is defined.
	* @param RecordType      DW_MACINFO_define or DW_MACINFO_undef.
	* @param Name            Macro name.
	* @param NameLen         Macro name length.
	* @param Value           Macro value.
	* @param ValueLen        Macro value length.
	*/
	DIBuilderCreateMacro :: proc(Builder: DIBuilderRef, ParentMacroFile: MetadataRef, Line: u32, RecordType: DWARFMacinfoRecordType, Name: cstring, NameLen: c.size_t, Value: cstring, ValueLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information temporary entry for a macro file.
	* List of macro node direct children will be calculated by DIBuilder,
	* using the \p ParentMacroFile relationship.
	* @param Builder         The DIBuilder.
	* @param ParentMacroFile Macro parent (could be NULL).
	* @param Line            Source line number where the macro file is included.
	* @param File            File descriptor containing the name of the macro file.
	*/
	DIBuilderCreateTempMacroFile :: proc(Builder: DIBuilderRef, ParentMacroFile: MetadataRef, Line: u32, File: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for an enumerator.
	* @param Builder        The DIBuilder.
	* @param Name           Enumerator name.
	* @param NameLen        Length of enumerator name.
	* @param Value          Enumerator value.
	* @param IsUnsigned     True if the value is unsigned.
	*/
	DIBuilderCreateEnumerator :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t, Value: i64, IsUnsigned: Bool) -> MetadataRef ---

	/**
	* Create debugging information entry for an enumerator of arbitrary precision.
	* @param Builder        The DIBuilder.
	* @param Name           Enumerator name.
	* @param NameLen        Length of enumerator name.
	* @param SizeInBits     Number of bits of the value.
	* @param Words          The words that make up the value.
	* @param IsUnsigned     True if the value is unsigned.
	*/
	DIBuilderCreateEnumeratorOfArbitraryPrecision :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t, SizeInBits: u64, Words: [^]u64, IsUnsigned: Bool) -> MetadataRef ---

	/**
	* Create debugging information entry for an enumeration.
	* \param Builder        The DIBuilder.
	* \param Scope          Scope in which this enumeration is defined.
	* \param Name           Enumeration name.
	* \param NameLen        Length of enumeration name.
	* \param File           File where this member is defined.
	* \param LineNumber     Line number.
	* \param SizeInBits     Member size.
	* \param AlignInBits    Member alignment.
	* \param Elements       Enumeration elements.
	* \param NumElements    Number of enumeration elements.
	* \param ClassTy        Underlying type of a C++11/ObjC fixed enum.
	*/
	DIBuilderCreateEnumerationType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, AlignInBits: u32, Elements: ^MetadataRef, NumElements: u32, ClassTy: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a union.
	* \param Builder      The DIBuilder.
	* \param Scope        Scope in which this union is defined.
	* \param Name         Union name.
	* \param NameLen      Length of union name.
	* \param File         File where this member is defined.
	* \param LineNumber   Line number.
	* \param SizeInBits   Member size.
	* \param AlignInBits  Member alignment.
	* \param Flags        Flags to encode member attribute, e.g. private
	* \param Elements     Union elements.
	* \param NumElements  Number of union elements.
	* \param RunTimeLang  Optional parameter, Objective-C runtime version.
	* \param UniqueId     A unique identifier for the union.
	* \param UniqueIdLen  Length of unique identifier.
	*/
	DIBuilderCreateUnionType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, AlignInBits: u32, Flags: DIFlags, Elements: ^MetadataRef, NumElements: u32, RunTimeLang: u32, UniqueId: cstring, UniqueIdLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information entry for an array.
	* \param Builder      The DIBuilder.
	* \param Size         Array size.
	* \param AlignInBits  Alignment.
	* \param Ty           Element type.
	* \param Subscripts   Subscripts.
	* \param NumSubscripts Number of subscripts.
	*/
	DIBuilderCreateArrayType :: proc(Builder: DIBuilderRef, Size: u64, AlignInBits: u32, Ty: MetadataRef, Subscripts: ^MetadataRef, NumSubscripts: u32) -> MetadataRef ---

	/**
	* Create debugging information entry for a set.
	* \param Builder        The DIBuilder.
	* \param Scope          The scope in which the set is defined.
	* \param Name           A name that uniquely identifies this set.
	* \param NameLen        The length of the C string passed to \c Name.
	* \param File           File where the set is located.
	* \param Line           Line number of the declaration.
	* \param SizeInBits     Set size.
	* \param AlignInBits    Set alignment.
	* \param BaseTy         The base type of the set.
	*/
	DIBuilderCreateSetType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, AlignInBits: u32, BaseTy: MetadataRef) -> MetadataRef ---

	/**
	* Create a descriptor for a subrange with dynamic bounds.
	* \param Builder    The DIBuilder.
	* \param Scope      The scope in which the subrange is defined.
	* \param Name       A name that uniquely identifies this subrange.
	* \param NameLen    The length of the C string passed to \c Name.
	* \param LineNo     Line number.
	* \param File       File where the subrange is located.
	* \param SizeInBits Member size.
	* \param AlignInBits Member alignment.
	* \param Flags      Flags.
	* \param BaseTy     The base type of the subrange. eg integer or enumeration
	* \param LowerBound Lower bound of the subrange.
	* \param UpperBound Upper bound of the subrange.
	* \param Stride     Stride of the subrange.
	* \param Bias       Bias of the subrange.
	*/
	DIBuilderCreateSubrangeType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, LineNo: u32, File: MetadataRef, SizeInBits: u64, AlignInBits: u32, Flags: DIFlags, BaseTy: MetadataRef, LowerBound: MetadataRef, UpperBound: MetadataRef, Stride: MetadataRef, Bias: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a dynamic array.
	* \param Builder      The DIBuilder.
	* \param Size         Array size.
	* \param AlignInBits  Alignment.
	* \param Ty           Element type.
	* \param Subscripts   Subscripts.
	* \param NumSubscripts Number of subscripts.
	* \param DataLocation DataLocation. (DIVariable, DIExpression or NULL)
	* \param Associated   Associated. (DIVariable, DIExpression or NULL)
	* \param Allocated    Allocated. (DIVariable, DIExpression or NULL)
	* \param Rank         Rank. (DIVariable, DIExpression or NULL)
	* \param BitStride    BitStride.
	*/
	DIBuilderCreateDynamicArrayType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, LineNo: u32, File: MetadataRef, Size: u64, AlignInBits: u32, Ty: MetadataRef, Subscripts: ^MetadataRef, NumSubscripts: u32, DataLocation: MetadataRef, Associated: MetadataRef, Allocated: MetadataRef, Rank: MetadataRef, BitStride: MetadataRef) -> MetadataRef ---

	/**
	* Replace arrays.
	*
	* @see DIBuilder::replaceArrays()
	*/
	ReplaceArrays :: proc(Builder: DIBuilderRef, T: ^MetadataRef, Elements: ^MetadataRef, NumElements: u32) ---

	/**
	* Create debugging information entry for a vector type.
	* \param Builder      The DIBuilder.
	* \param Size         Vector size.
	* \param AlignInBits  Alignment.
	* \param Ty           Element type.
	* \param Subscripts   Subscripts.
	* \param NumSubscripts Number of subscripts.
	*/
	DIBuilderCreateVectorType :: proc(Builder: DIBuilderRef, Size: u64, AlignInBits: u32, Ty: MetadataRef, Subscripts: ^MetadataRef, NumSubscripts: u32) -> MetadataRef ---

	/**
	* Create a DWARF unspecified type.
	* \param Builder   The DIBuilder.
	* \param Name      The unspecified type's name.
	* \param NameLen   Length of type name.
	*/
	DIBuilderCreateUnspecifiedType :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information entry for a basic
	* type.
	* \param Builder     The DIBuilder.
	* \param Name        Type name.
	* \param NameLen     Length of type name.
	* \param SizeInBits  Size of the type.
	* \param Encoding    DWARF encoding code, e.g. \c LLVMDWARFTypeEncoding_float.
	* \param Flags       Flags to encode optional attribute like endianity
	*/
	DIBuilderCreateBasicType :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t, SizeInBits: u64, Encoding: DWARFTypeEncoding, Flags: DIFlags) -> MetadataRef ---

	/**
	* Create debugging information entry for a pointer.
	* \param Builder     The DIBuilder.
	* \param PointeeTy         Type pointed by this pointer.
	* \param SizeInBits        Size.
	* \param AlignInBits       Alignment. (optional, pass 0 to ignore)
	* \param AddressSpace      DWARF address space. (optional, pass 0 to ignore)
	* \param Name              Pointer type name. (optional)
	* \param NameLen           Length of pointer type name. (optional)
	*/
	DIBuilderCreatePointerType :: proc(Builder: DIBuilderRef, PointeeTy: MetadataRef, SizeInBits: u64, AlignInBits: u32, AddressSpace: u32, Name: cstring, NameLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information entry for a struct.
	* \param Builder     The DIBuilder.
	* \param Scope        Scope in which this struct is defined.
	* \param Name         Struct name.
	* \param NameLen      Struct name length.
	* \param File         File where this member is defined.
	* \param LineNumber   Line number.
	* \param SizeInBits   Member size.
	* \param AlignInBits  Member alignment.
	* \param Flags        Flags to encode member attribute, e.g. private
	* \param Elements     Struct elements.
	* \param NumElements  Number of struct elements.
	* \param RunTimeLang  Optional parameter, Objective-C runtime version.
	* \param VTableHolder The object containing the vtable for the struct.
	* \param UniqueId     A unique identifier for the struct.
	* \param UniqueIdLen  Length of the unique identifier for the struct.
	*/
	DIBuilderCreateStructType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, AlignInBits: u32, Flags: DIFlags, DerivedFrom: MetadataRef, Elements: ^MetadataRef, NumElements: u32, RunTimeLang: u32, VTableHolder: MetadataRef, UniqueId: cstring, UniqueIdLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information entry for a member.
	* \param Builder      The DIBuilder.
	* \param Scope        Member scope.
	* \param Name         Member name.
	* \param NameLen      Length of member name.
	* \param File         File where this member is defined.
	* \param LineNo       Line number.
	* \param SizeInBits   Member size.
	* \param AlignInBits  Member alignment.
	* \param OffsetInBits Member offset.
	* \param Flags        Flags to encode member attribute, e.g. private
	* \param Ty           Parent type.
	*/
	DIBuilderCreateMemberType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, SizeInBits: u64, AlignInBits: u32, OffsetInBits: u64, Flags: DIFlags, Ty: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a
	* C++ static data member.
	* \param Builder      The DIBuilder.
	* \param Scope        Member scope.
	* \param Name         Member name.
	* \param NameLen      Length of member name.
	* \param File         File where this member is declared.
	* \param LineNumber   Line number.
	* \param Type         Type of the static member.
	* \param Flags        Flags to encode member attribute, e.g. private.
	* \param ConstantVal  Const initializer of the member.
	* \param AlignInBits  Member alignment.
	*/
	DIBuilderCreateStaticMemberType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, Type: MetadataRef, Flags: DIFlags, ConstantVal: ValueRef, AlignInBits: u32) -> MetadataRef ---

	/**
	* Create debugging information entry for a pointer to member.
	* \param Builder      The DIBuilder.
	* \param PointeeType  Type pointed to by this pointer.
	* \param ClassType    Type for which this pointer points to members of.
	* \param SizeInBits   Size.
	* \param AlignInBits  Alignment.
	* \param Flags        Flags.
	*/
	DIBuilderCreateMemberPointerType :: proc(Builder: DIBuilderRef, PointeeType: MetadataRef, ClassType: MetadataRef, SizeInBits: u64, AlignInBits: u32, Flags: DIFlags) -> MetadataRef ---

	/**
	* Create debugging information entry for Objective-C instance variable.
	* \param Builder      The DIBuilder.
	* \param Name         Member name.
	* \param NameLen      The length of the C string passed to \c Name.
	* \param File         File where this member is defined.
	* \param LineNo       Line number.
	* \param SizeInBits   Member size.
	* \param AlignInBits  Member alignment.
	* \param OffsetInBits Member offset.
	* \param Flags        Flags to encode member attribute, e.g. private
	* \param Ty           Parent type.
	* \param PropertyNode Property associated with this ivar.
	*/
	DIBuilderCreateObjCIVar :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, SizeInBits: u64, AlignInBits: u32, OffsetInBits: u64, Flags: DIFlags, Ty: MetadataRef, PropertyNode: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for Objective-C property.
	* \param Builder            The DIBuilder.
	* \param Name               Property name.
	* \param NameLen            The length of the C string passed to \c Name.
	* \param File               File where this property is defined.
	* \param LineNo             Line number.
	* \param GetterName         Name of the Objective C property getter selector.
	* \param GetterNameLen      The length of the C string passed to \c GetterName.
	* \param SetterName         Name of the Objective C property setter selector.
	* \param SetterNameLen      The length of the C string passed to \c SetterName.
	* \param PropertyAttributes Objective C property attributes.
	* \param Ty                 Type.
	*/
	DIBuilderCreateObjCProperty :: proc(Builder: DIBuilderRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, GetterName: cstring, GetterNameLen: c.size_t, SetterName: cstring, SetterNameLen: c.size_t, PropertyAttributes: u32, Ty: MetadataRef) -> MetadataRef ---

	/**
	* Create a uniqued DIType* clone with FlagObjectPointer. If \c Implicit
	* is true, then also set FlagArtificial.
	* \param Builder   The DIBuilder.
	* \param Type      The underlying type to which this pointer points.
	* \param Implicit  Indicates whether this pointer was implicitly generated
	*                  (i.e., not spelled out in source).
	*/
	DIBuilderCreateObjectPointerType :: proc(Builder: DIBuilderRef, Type: MetadataRef, Implicit: Bool) -> MetadataRef ---

	/**
	* Create debugging information entry for a qualified
	* type, e.g. 'const int'.
	* \param Builder     The DIBuilder.
	* \param Tag         Tag identifying type,
	*                    e.g. LLVMDWARFTypeQualifier_volatile_type
	* \param Type        Base Type.
	*/
	DIBuilderCreateQualifiedType :: proc(Builder: DIBuilderRef, Tag: u32, Type: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a c++
	* style reference or rvalue reference type.
	* \param Builder   The DIBuilder.
	* \param Tag       Tag identifying type,
	* \param Type      Base Type.
	*/
	DIBuilderCreateReferenceType :: proc(Builder: DIBuilderRef, Tag: u32, Type: MetadataRef) -> MetadataRef ---

	/**
	* Create C++11 nullptr type.
	* \param Builder   The DIBuilder.
	*/
	DIBuilderCreateNullPtrType :: proc(Builder: DIBuilderRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a typedef.
	* \param Builder    The DIBuilder.
	* \param Type       Original type.
	* \param Name       Typedef name.
	* \param File       File where this type is defined.
	* \param LineNo     Line number.
	* \param Scope      The surrounding context for the typedef.
	*/
	DIBuilderCreateTypedef :: proc(Builder: DIBuilderRef, Type: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, Scope: MetadataRef, AlignInBits: u32) -> MetadataRef ---

	/**
	* Create debugging information entry to establish inheritance relationship
	* between two types.
	* \param Builder       The DIBuilder.
	* \param Ty            Original type.
	* \param BaseTy        Base type. Ty is inherits from base.
	* \param BaseOffset    Base offset.
	* \param VBPtrOffset  Virtual base pointer offset.
	* \param Flags         Flags to describe inheritance attribute, e.g. private
	*/
	DIBuilderCreateInheritance :: proc(Builder: DIBuilderRef, Ty: MetadataRef, BaseTy: MetadataRef, BaseOffset: u64, VBPtrOffset: u32, Flags: DIFlags) -> MetadataRef ---

	/**
	* Create a permanent forward-declared type.
	* \param Builder             The DIBuilder.
	* \param Tag                 A unique tag for this type.
	* \param Name                Type name.
	* \param NameLen             Length of type name.
	* \param Scope               Type scope.
	* \param File                File where this type is defined.
	* \param Line                Line number where this type is defined.
	* \param RuntimeLang         Indicates runtime version for languages like
	*                            Objective-C.
	* \param SizeInBits          Member size.
	* \param AlignInBits         Member alignment.
	* \param UniqueIdentifier    A unique identifier for the type.
	* \param UniqueIdentifierLen Length of the unique identifier.
	*/
	DIBuilderCreateForwardDecl :: proc(Builder: DIBuilderRef, Tag: u32, Name: cstring, NameLen: c.size_t, Scope: MetadataRef, File: MetadataRef, Line: u32, RuntimeLang: u32, SizeInBits: u64, AlignInBits: u32, UniqueIdentifier: cstring, UniqueIdentifierLen: c.size_t) -> MetadataRef ---

	/**
	* Create a temporary forward-declared type.
	* \param Builder             The DIBuilder.
	* \param Tag                 A unique tag for this type.
	* \param Name                Type name.
	* \param NameLen             Length of type name.
	* \param Scope               Type scope.
	* \param File                File where this type is defined.
	* \param Line                Line number where this type is defined.
	* \param RuntimeLang         Indicates runtime version for languages like
	*                            Objective-C.
	* \param SizeInBits          Member size.
	* \param AlignInBits         Member alignment.
	* \param Flags               Flags.
	* \param UniqueIdentifier    A unique identifier for the type.
	* \param UniqueIdentifierLen Length of the unique identifier.
	*/
	DIBuilderCreateReplaceableCompositeType :: proc(Builder: DIBuilderRef, Tag: u32, Name: cstring, NameLen: c.size_t, Scope: MetadataRef, File: MetadataRef, Line: u32, RuntimeLang: u32, SizeInBits: u64, AlignInBits: u32, Flags: DIFlags, UniqueIdentifier: cstring, UniqueIdentifierLen: c.size_t) -> MetadataRef ---

	/**
	* Create debugging information entry for a bit field member.
	* \param Builder             The DIBuilder.
	* \param Scope               Member scope.
	* \param Name                Member name.
	* \param NameLen             Length of member name.
	* \param File                File where this member is defined.
	* \param LineNumber          Line number.
	* \param SizeInBits          Member size.
	* \param OffsetInBits        Member offset.
	* \param StorageOffsetInBits Member storage offset.
	* \param Flags               Flags to encode member attribute.
	* \param Type                Parent type.
	*/
	DIBuilderCreateBitFieldMemberType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, OffsetInBits: u64, StorageOffsetInBits: u64, Flags: DIFlags, Type: MetadataRef) -> MetadataRef ---

	/**
	* Create debugging information entry for a class.
	* \param Scope               Scope in which this class is defined.
	* \param Name                Class name.
	* \param NameLen             The length of the C string passed to \c Name.
	* \param File                File where this member is defined.
	* \param LineNumber          Line number.
	* \param SizeInBits          Member size.
	* \param AlignInBits         Member alignment.
	* \param OffsetInBits        Member offset.
	* \param Flags               Flags to encode member attribute, e.g. private.
	* \param DerivedFrom         Debug info of the base class of this type.
	* \param Elements            Class members.
	* \param NumElements         Number of class elements.
	* \param VTableHolder        Debug info of the base class that contains vtable
	*                            for this type. This is used in
	*                            DW_AT_containing_type. See DWARF documentation
	*                            for more info.
	* \param TemplateParamsNode  Template type parameters.
	* \param UniqueIdentifier    A unique identifier for the type.
	* \param UniqueIdentifierLen Length of the unique identifier.
	*/
	DIBuilderCreateClassType :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNumber: u32, SizeInBits: u64, AlignInBits: u32, OffsetInBits: u64, Flags: DIFlags, DerivedFrom: MetadataRef, Elements: ^MetadataRef, NumElements: u32, VTableHolder: MetadataRef, TemplateParamsNode: MetadataRef, UniqueIdentifier: cstring, UniqueIdentifierLen: c.size_t) -> MetadataRef ---

	/**
	* Create a uniqued DIType* clone with FlagArtificial set.
	* \param Builder     The DIBuilder.
	* \param Type        The underlying type.
	*/
	DIBuilderCreateArtificialType :: proc(Builder: DIBuilderRef, Type: MetadataRef) -> MetadataRef ---

	/**
	* Get the name of this DIType.
	* \param DType     The DIType.
	* \param Length    The length of the returned string.
	*
	* @see DIType::getName()
	*/
	DITypeGetName :: proc(DType: MetadataRef, Length: ^c.size_t) -> cstring ---

	/**
	* Get the size of this DIType in bits.
	* \param DType     The DIType.
	*
	* @see DIType::getSizeInBits()
	*/
	DITypeGetSizeInBits :: proc(DType: MetadataRef) -> u64 ---

	/**
	* Get the offset of this DIType in bits.
	* \param DType     The DIType.
	*
	* @see DIType::getOffsetInBits()
	*/
	DITypeGetOffsetInBits :: proc(DType: MetadataRef) -> u64 ---

	/**
	* Get the alignment of this DIType in bits.
	* \param DType     The DIType.
	*
	* @see DIType::getAlignInBits()
	*/
	DITypeGetAlignInBits :: proc(DType: MetadataRef) -> u32 ---

	/**
	* Get the source line where this DIType is declared.
	* \param DType     The DIType.
	*
	* @see DIType::getLine()
	*/
	DITypeGetLine :: proc(DType: MetadataRef) -> u32 ---

	/**
	* Get the flags associated with this DIType.
	* \param DType     The DIType.
	*
	* @see DIType::getFlags()
	*/
	DITypeGetFlags :: proc(DType: MetadataRef) -> DIFlags ---

	/**
	* Create a descriptor for a value range.
	* \param Builder    The DIBuilder.
	* \param LowerBound Lower bound of the subrange, e.g. 0 for C, 1 for Fortran.
	* \param Count      Count of elements in the subrange.
	*/
	DIBuilderGetOrCreateSubrange :: proc(Builder: DIBuilderRef, LowerBound: i64, Count: i64) -> MetadataRef ---

	/**
	* Create an array of DI Nodes.
	* \param Builder        The DIBuilder.
	* \param Data           The DI Node elements.
	* \param NumElements    Number of DI Node elements.
	*/
	DIBuilderGetOrCreateArray :: proc(Builder: DIBuilderRef, Data: ^MetadataRef, NumElements: c.size_t) -> MetadataRef ---

	/**
	* Create a new descriptor for the specified variable which has a complex
	* address expression for its address.
	* \param Builder     The DIBuilder.
	* \param Addr        An array of complex address operations.
	* \param Length      Length of the address operation array.
	*/
	DIBuilderCreateExpression :: proc(Builder: DIBuilderRef, Addr: ^u64, Length: c.size_t) -> MetadataRef ---

	/**
	* Create a new descriptor for the specified variable that does not have an
	* address, but does have a constant value.
	* \param Builder     The DIBuilder.
	* \param Value       The constant value.
	*/
	DIBuilderCreateConstantValueExpression :: proc(Builder: DIBuilderRef, Value: u64) -> MetadataRef ---

	/**
	* Create a new descriptor for the specified variable.
	* \param Scope       Variable scope.
	* \param Name        Name of the variable.
	* \param NameLen     The length of the C string passed to \c Name.
	* \param Linkage     Mangled  name of the variable.
	* \param LinkLen     The length of the C string passed to \c Linkage.
	* \param File        File where this variable is defined.
	* \param LineNo      Line number.
	* \param Ty          Variable Type.
	* \param LocalToUnit Boolean flag indicate whether this variable is
	*                    externally visible or not.
	* \param Expr        The location of the global relative to the attached
	*                    GlobalVariable.
	* \param Decl        Reference to the corresponding declaration.
	*                    variables.
	* \param AlignInBits Variable alignment(or 0 if no alignment attr was
	*                    specified)
	*/
	DIBuilderCreateGlobalVariableExpression :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, Linkage: cstring, LinkLen: c.size_t, File: MetadataRef, LineNo: u32, Ty: MetadataRef, LocalToUnit: Bool, Expr: MetadataRef, Decl: MetadataRef, AlignInBits: u32) -> MetadataRef ---

	/**
	* Get the dwarf::Tag of a DINode
	*/
	GetDINodeTag :: proc(MD: MetadataRef) -> u16 ---

	/**
	* Retrieves the \c DIVariable associated with this global variable expression.
	* \param GVE    The global variable expression.
	*
	* @see llvm::DIGlobalVariableExpression::getVariable()
	*/
	DIGlobalVariableExpressionGetVariable :: proc(GVE: MetadataRef) -> MetadataRef ---

	/**
	* Retrieves the \c DIExpression associated with this global variable expression.
	* \param GVE    The global variable expression.
	*
	* @see llvm::DIGlobalVariableExpression::getExpression()
	*/
	DIGlobalVariableExpressionGetExpression :: proc(GVE: MetadataRef) -> MetadataRef ---

	/**
	* Get the metadata of the file associated with a given variable.
	* \param Var     The variable object.
	*
	* @see DIVariable::getFile()
	*/
	DIVariableGetFile :: proc(Var: MetadataRef) -> MetadataRef ---

	/**
	* Get the metadata of the scope associated with a given variable.
	* \param Var     The variable object.
	*
	* @see DIVariable::getScope()
	*/
	DIVariableGetScope :: proc(Var: MetadataRef) -> MetadataRef ---

	/**
	* Get the source line where this \c DIVariable is declared.
	* \param Var     The DIVariable.
	*
	* @see DIVariable::getLine()
	*/
	DIVariableGetLine :: proc(Var: MetadataRef) -> u32 ---

	/**
	* Create a new temporary \c MDNode.  Suitable for use in constructing cyclic
	* \c MDNode structures. A temporary \c MDNode is not uniqued, may be RAUW'd,
	* and must be manually deleted with \c LLVMDisposeTemporaryMDNode.
	* \param Ctx            The context in which to construct the temporary node.
	* \param Data           The metadata elements.
	* \param NumElements    Number of metadata elements.
	*/
	TemporaryMDNode :: proc(Ctx: ContextRef, Data: ^MetadataRef, NumElements: c.size_t) -> MetadataRef ---

	/**
	* Deallocate a temporary node.
	*
	* Calls \c replaceAllUsesWith(nullptr) before deleting, so any remaining
	* references will be reset.
	* \param TempNode    The temporary metadata node.
	*/
	DisposeTemporaryMDNode :: proc(TempNode: MetadataRef) ---

	/**
	* Replace all uses of temporary metadata.
	* \param TempTargetMetadata    The temporary metadata node.
	* \param Replacement           The replacement metadata node.
	*/
	MetadataReplaceAllUsesWith :: proc(TempTargetMetadata: MetadataRef, Replacement: MetadataRef) ---

	/**
	* Create a new descriptor for the specified global variable that is temporary
	* and meant to be RAUWed.
	* \param Scope       Variable scope.
	* \param Name        Name of the variable.
	* \param NameLen     The length of the C string passed to \c Name.
	* \param Linkage     Mangled  name of the variable.
	* \param LnkLen      The length of the C string passed to \c Linkage.
	* \param File        File where this variable is defined.
	* \param LineNo      Line number.
	* \param Ty          Variable Type.
	* \param LocalToUnit Boolean flag indicate whether this variable is
	*                    externally visible or not.
	* \param Decl        Reference to the corresponding declaration.
	* \param AlignInBits Variable alignment(or 0 if no alignment attr was
	*                    specified)
	*/
	DIBuilderCreateTempGlobalVariableFwdDecl :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, Linkage: cstring, LnkLen: c.size_t, File: MetadataRef, LineNo: u32, Ty: MetadataRef, LocalToUnit: Bool, Decl: MetadataRef, AlignInBits: u32) -> MetadataRef ---

	/**
	* Only use in "new debug format" (LLVMIsNewDbgInfoFormat() is true).
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* The debug format can be switched later after inserting the records using
	* LLVMSetIsNewDbgInfoFormat, if needed for legacy or transitionary reasons.
	*
	* Insert a Declare DbgRecord before the given instruction.
	* \param Builder     The DIBuilder.
	* \param Storage     The storage of the variable to declare.
	* \param VarInfo     The variable's debug info descriptor.
	* \param Expr        A complex location expression for the variable.
	* \param DebugLoc    Debug info location.
	* \param Instr       Instruction acting as a location for the new record.
	*/
	DIBuilderInsertDeclareRecordBefore :: proc(Builder: DIBuilderRef, Storage: ValueRef, VarInfo: MetadataRef, Expr: MetadataRef, DebugLoc: MetadataRef, Instr: ValueRef) -> DbgRecordRef ---

	/**
	* Only use in "new debug format" (LLVMIsNewDbgInfoFormat() is true).
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* The debug format can be switched later after inserting the records using
	* LLVMSetIsNewDbgInfoFormat, if needed for legacy or transitionary reasons.
	*
	* Insert a Declare DbgRecord at the end of the given basic block. If the basic
	* block has a terminator instruction, the record is inserted before that
	* terminator instruction.
	* \param Builder     The DIBuilder.
	* \param Storage     The storage of the variable to declare.
	* \param VarInfo     The variable's debug info descriptor.
	* \param Expr        A complex location expression for the variable.
	* \param DebugLoc    Debug info location.
	* \param Block       Basic block acting as a location for the new record.
	*/
	DIBuilderInsertDeclareRecordAtEnd :: proc(Builder: DIBuilderRef, Storage: ValueRef, VarInfo: MetadataRef, Expr: MetadataRef, DebugLoc: MetadataRef, Block: BasicBlockRef) -> DbgRecordRef ---

	/**
	* Only use in "new debug format" (LLVMIsNewDbgInfoFormat() is true).
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* The debug format can be switched later after inserting the records using
	* LLVMSetIsNewDbgInfoFormat, if needed for legacy or transitionary reasons.
	*
	* Insert a new debug record before the given instruction.
	* \param Builder     The DIBuilder.
	* \param Val         The value of the variable.
	* \param VarInfo     The variable's debug info descriptor.
	* \param Expr        A complex location expression for the variable.
	* \param DebugLoc    Debug info location.
	* \param Instr       Instruction acting as a location for the new record.
	*/
	DIBuilderInsertDbgValueRecordBefore :: proc(Builder: DIBuilderRef, Val: ValueRef, VarInfo: MetadataRef, Expr: MetadataRef, DebugLoc: MetadataRef, Instr: ValueRef) -> DbgRecordRef ---

	/**
	* Only use in "new debug format" (LLVMIsNewDbgInfoFormat() is true).
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* The debug format can be switched later after inserting the records using
	* LLVMSetIsNewDbgInfoFormat, if needed for legacy or transitionary reasons.
	*
	* Insert a new debug record at the end of the given basic block. If the
	* basic block has a terminator instruction, the record is inserted before
	* that terminator instruction.
	* \param Builder     The DIBuilder.
	* \param Val         The value of the variable.
	* \param VarInfo     The variable's debug info descriptor.
	* \param Expr        A complex location expression for the variable.
	* \param DebugLoc    Debug info location.
	* \param Block       Basic block acting as a location for the new record.
	*/
	DIBuilderInsertDbgValueRecordAtEnd :: proc(Builder: DIBuilderRef, Val: ValueRef, VarInfo: MetadataRef, Expr: MetadataRef, DebugLoc: MetadataRef, Block: BasicBlockRef) -> DbgRecordRef ---

	/**
	* Create a new descriptor for a local auto variable.
	* \param Builder         The DIBuilder.
	* \param Scope           The local scope the variable is declared in.
	* \param Name            Variable name.
	* \param NameLen         Length of variable name.
	* \param File            File where this variable is defined.
	* \param LineNo          Line number.
	* \param Ty              Metadata describing the type of the variable.
	* \param AlwaysPreserve  If true, this descriptor will survive optimizations.
	* \param Flags           Flags.
	* \param AlignInBits     Variable alignment.
	*/
	DIBuilderCreateAutoVariable :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, Ty: MetadataRef, AlwaysPreserve: Bool, Flags: DIFlags, AlignInBits: u32) -> MetadataRef ---

	/**
	* Create a new descriptor for a function parameter variable.
	* \param Builder         The DIBuilder.
	* \param Scope           The local scope the variable is declared in.
	* \param Name            Variable name.
	* \param NameLen         Length of variable name.
	* \param ArgNo           Unique argument number for this variable; starts at 1.
	* \param File            File where this variable is defined.
	* \param LineNo          Line number.
	* \param Ty              Metadata describing the type of the variable.
	* \param AlwaysPreserve  If true, this descriptor will survive optimizations.
	* \param Flags           Flags.
	*/
	DIBuilderCreateParameterVariable :: proc(Builder: DIBuilderRef, Scope: MetadataRef, Name: cstring, NameLen: c.size_t, ArgNo: u32, File: MetadataRef, LineNo: u32, Ty: MetadataRef, AlwaysPreserve: Bool, Flags: DIFlags) -> MetadataRef ---

	/**
	* Get the metadata of the subprogram attached to a function.
	*
	* @see llvm::Function::getSubprogram()
	*/
	GetSubprogram :: proc(Func: ValueRef) -> MetadataRef ---

	/**
	* Set the subprogram attached to a function.
	*
	* @see llvm::Function::setSubprogram()
	*/
	SetSubprogram :: proc(Func: ValueRef, SP: MetadataRef) ---

	/**
	* Get the line associated with a given subprogram.
	* \param Subprogram     The subprogram object.
	*
	* @see DISubprogram::getLine()
	*/
	DISubprogramGetLine :: proc(Subprogram: MetadataRef) -> u32 ---

	/**
	* Replace the subprogram subroutine type.
	* \param Subprogram        The subprogram object.
	* \param SubroutineType    The new subroutine type.
	*
	* @see DISubprogram::replaceType()
	*/
	DISubprogramReplaceType :: proc(Subprogram: MetadataRef, SubroutineType: MetadataRef) ---

	/**
	* Get the debug location for the given instruction.
	*
	* @see llvm::Instruction::getDebugLoc()
	*/
	InstructionGetDebugLoc :: proc(Inst: ValueRef) -> MetadataRef ---

	/**
	* Set the debug location for the given instruction.
	*
	* To clear the location metadata of the given instruction, pass NULL to \p Loc.
	*
	* @see llvm::Instruction::setDebugLoc()
	*/
	InstructionSetDebugLoc :: proc(Inst: ValueRef, Loc: MetadataRef) ---

	/**
	* Create a new descriptor for a label
	*
	* \param Builder         The DIBuilder.
	* \param Scope           The scope to create the label in.
	* \param Name            Variable name.
	* \param NameLen         Length of variable name.
	* \param File            The file to create the label in.
	* \param LineNo          Line Number.
	* \param AlwaysPreserve  Preserve the label regardless of optimization.
	*
	* @see llvm::DIBuilder::createLabel()
	*/
	DIBuilderCreateLabel :: proc(Builder: DIBuilderRef, Context: MetadataRef, Name: cstring, NameLen: c.size_t, File: MetadataRef, LineNo: u32, AlwaysPreserve: Bool) -> MetadataRef ---

	/**
	* Insert a new llvm.dbg.label intrinsic call
	*
	* \param Builder         The DIBuilder.
	* \param LabelInfo       The Label's debug info descriptor
	* \param Location        The debug info location
	* \param InsertBefore    Location for the new intrinsic.
	*
	* @see llvm::DIBuilder::insertLabel()
	*/
	DIBuilderInsertLabelBefore :: proc(Builder: DIBuilderRef, LabelInfo: MetadataRef, Location: MetadataRef, InsertBefore: ValueRef) -> DbgRecordRef ---

	/**
	* Insert a new llvm.dbg.label intrinsic call
	*
	* \param Builder         The DIBuilder.
	* \param LabelInfo       The Label's debug info descriptor
	* \param Location        The debug info location
	* \param InsertAtEnd     Location for the new intrinsic.
	*
	* @see llvm::DIBuilder::insertLabel()
	*/
	DIBuilderInsertLabelAtEnd :: proc(Builder: DIBuilderRef, LabelInfo: MetadataRef, Location: MetadataRef, InsertAtEnd: BasicBlockRef) -> DbgRecordRef ---

	/**
	* Obtain the enumerated type of a Metadata instance.
	*
	* @see llvm::Metadata::getMetadataID()
	*/
	GetMetadataKind :: proc(Metadata: MetadataRef) -> MetadataKind ---
}

