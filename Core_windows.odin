/*===-- llvm-c/Core.h - Core Library C Interface ------------------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to libLLVMCore.a, which implements    *|
|* the LLVM intermediate representation.                                      *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "llvm-install/lib/LLVM-C.lib"


/// External users depend on the following values being stable. It is not safe
/// to reorder them.
Opcode :: enum i32 {
	/* Terminator Instructions */
	Ret            = 1,
	Br             = 2,
	Switch         = 3,
	IndirectBr     = 4,
	Invoke         = 5,

	/* removed 6 due to API changes */
	Unreachable    = 7,
	CallBr         = 67,

	/* Standard Unary Operators */
	FNeg           = 66,

	/* Standard Binary Operators */
	Add            = 8,
	FAdd           = 9,
	Sub            = 10,
	FSub           = 11,
	Mul            = 12,
	FMul           = 13,
	UDiv           = 14,
	SDiv           = 15,
	FDiv           = 16,
	URem           = 17,
	SRem           = 18,
	FRem           = 19,

	/* Logical Operators */
	Shl            = 20,
	LShr           = 21,
	AShr           = 22,
	And            = 23,
	Or             = 24,
	Xor            = 25,

	/* Memory Operators */
	Alloca         = 26,
	Load           = 27,
	Store          = 28,
	GetElementPtr  = 29,

	/* Cast Operators */
	Trunc          = 30,
	ZExt           = 31,
	SExt           = 32,
	FPToUI         = 33,
	FPToSI         = 34,
	UIToFP         = 35,
	SIToFP         = 36,
	FPTrunc        = 37,
	FPExt          = 38,
	PtrToInt       = 39,
	PtrToAddr      = 69,
	IntToPtr       = 40,
	BitCast        = 41,
	AddrSpaceCast  = 60,

	/* Other Operators */
	ICmp           = 42,
	FCmp           = 43,
	PHI            = 44,
	Call           = 45,
	Select         = 46,
	UserOp1        = 47,
	UserOp2        = 48,
	VAArg          = 49,
	ExtractElement = 50,
	InsertElement  = 51,
	ShuffleVector  = 52,
	ExtractValue   = 53,
	InsertValue    = 54,
	Freeze         = 68,

	/* Atomic operators */
	Fence          = 55,
	AtomicCmpXchg  = 56,
	AtomicRMW      = 57,

	/* Exception Handling Operators */
	Resume         = 58,
	LandingPad     = 59,
	CleanupRet     = 61,
	CatchRet       = 62,
	CatchPad       = 63,
	CleanupPad     = 64,
	CatchSwitch    = 65,
}

TypeKind :: enum i32 {
	VoidTypeKind           = 0,  /**< type with no size */
	HalfTypeKind           = 1,  /**< 16 bit floating point type */
	FloatTypeKind          = 2,  /**< 32 bit floating point type */
	DoubleTypeKind         = 3,  /**< 64 bit floating point type */
	X86_FP80TypeKind       = 4,  /**< 80 bit floating point type (X87) */
	FP128TypeKind          = 5,  /**< 128 bit floating point type (112-bit mantissa)*/
	PPC_FP128TypeKind      = 6,  /**< 128 bit floating point type (two 64-bits) */
	LabelTypeKind          = 7,  /**< Labels */
	IntegerTypeKind        = 8,  /**< Arbitrary bit width integers */
	FunctionTypeKind       = 9,  /**< Functions */
	StructTypeKind         = 10, /**< Structures */
	ArrayTypeKind          = 11, /**< Arrays */
	PointerTypeKind        = 12, /**< Pointers */
	VectorTypeKind         = 13, /**< Fixed width SIMD vector type */
	MetadataTypeKind       = 14, /**< Metadata */

	/* 15 previously used by LLVMX86_MMXTypeKind */
	TokenTypeKind          = 16, /**< Tokens */
	ScalableVectorTypeKind = 17, /**< Scalable SIMD vector type */
	BFloatTypeKind         = 18, /**< 16 bit brain floating point type */
	X86_AMXTypeKind        = 19, /**< X86 AMX */
	TargetExtTypeKind      = 20, /**< Target extension type */
}

Linkage :: enum i32 {
	ExternalLinkage            = 0,  /**< Externally visible function */
	AvailableExternallyLinkage = 1,
	LinkOnceAnyLinkage         = 2,  /**< Keep one copy of function when linking (inline)*/
	LinkOnceODRLinkage         = 3,  /**< Same, but only replaced by something
                            equivalent. */
	LinkOnceODRAutoHideLinkage = 4,  /**< Obsolete */
	WeakAnyLinkage             = 5,  /**< Keep one copy of function when linking (weak) */
	WeakODRLinkage             = 6,  /**< Same, but only replaced by something
                            equivalent. */
	AppendingLinkage           = 7,  /**< Special purpose, only applies to global arrays */
	InternalLinkage            = 8,  /**< Rename collisions when linking (static
                               functions) */
	PrivateLinkage             = 9,  /**< Like Internal, but omit from symbol table */
	DLLImportLinkage           = 10, /**< Obsolete */
	DLLExportLinkage           = 11, /**< Obsolete */
	ExternalWeakLinkage        = 12, /**< ExternalWeak linkage description */
	GhostLinkage               = 13, /**< Obsolete */
	CommonLinkage              = 14, /**< Tentative definitions */
	LinkerPrivateLinkage       = 15, /**< Like Private, but linker removes. */
	LinkerPrivateWeakLinkage   = 16, /**< Like LinkerPrivate, but is weak. */
}

Visibility :: enum i32 {
	DefaultVisibility   = 0, /**< The GV is visible */
	HiddenVisibility    = 1, /**< The GV is hidden */
	ProtectedVisibility = 2, /**< The GV is protected */
}

UnnamedAddr :: enum i32 {
	NoUnnamedAddr     = 0, /**< Address of the GV is significant. */
	LocalUnnamedAddr  = 1, /**< Address of the GV is locally insignificant. */
	GlobalUnnamedAddr = 2, /**< Address of the GV is globally insignificant. */
}

DLLStorageClass :: enum i32 {
	efaultStorageClass   = 0,
	LLImportStorageClass = 1, /**< Function to be imported from DLL. */
	LLExportStorageClass = 2, /**< Function to be accessible from DLL. */
}

CallConv :: enum i32 {
	CCallConv             = 0,
	FastCallConv          = 8,
	ColdCallConv          = 9,
	GHCCallConv           = 10,
	HiPECallConv          = 11,
	AnyRegCallConv        = 13,
	PreserveMostCallConv  = 14,
	PreserveAllCallConv   = 15,
	SwiftCallConv         = 16,
	CXXFASTTLSCallConv    = 17,
	X86StdcallCallConv    = 64,
	X86FastcallCallConv   = 65,
	ARMAPCSCallConv       = 66,
	ARMAAPCSCallConv      = 67,
	ARMAAPCSVFPCallConv   = 68,
	MSP430INTRCallConv    = 69,
	X86ThisCallCallConv   = 70,
	PTXKernelCallConv     = 71,
	PTXDeviceCallConv     = 72,
	SPIRFUNCCallConv      = 75,
	SPIRKERNELCallConv    = 76,
	IntelOCLBICallConv    = 77,
	X8664SysVCallConv     = 78,
	Win64CallConv         = 79,
	X86VectorCallCallConv = 80,
	HHVMCallConv          = 81,
	HHVMCCallConv         = 82,
	X86INTRCallConv       = 83,
	AVRINTRCallConv       = 84,
	AVRSIGNALCallConv     = 85,
	AVRBUILTINCallConv    = 86,
	AMDGPUVSCallConv      = 87,
	AMDGPUGSCallConv      = 88,
	AMDGPUPSCallConv      = 89,
	AMDGPUCSCallConv      = 90,
	AMDGPUKERNELCallConv  = 91,
	X86RegCallCallConv    = 92,
	AMDGPUHSCallConv      = 93,
	MSP430BUILTINCallConv = 94,
	AMDGPULSCallConv      = 95,
	AMDGPUESCallConv      = 96,
}

ValueKind :: enum i32 {
	ArgumentValueKind              = 0,
	BasicBlockValueKind            = 1,
	MemoryUseValueKind             = 2,
	MemoryDefValueKind             = 3,
	MemoryPhiValueKind             = 4,
	FunctionValueKind              = 5,
	GlobalAliasValueKind           = 6,
	GlobalIFuncValueKind           = 7,
	GlobalVariableValueKind        = 8,
	BlockAddressValueKind          = 9,
	ConstantExprValueKind          = 10,
	ConstantArrayValueKind         = 11,
	ConstantStructValueKind        = 12,
	ConstantVectorValueKind        = 13,
	UndefValueValueKind            = 14,
	ConstantAggregateZeroValueKind = 15,
	ConstantDataArrayValueKind     = 16,
	ConstantDataVectorValueKind    = 17,
	ConstantIntValueKind           = 18,
	ConstantFPValueKind            = 19,
	ConstantPointerNullValueKind   = 20,
	ConstantTokenNoneValueKind     = 21,
	MetadataAsValueValueKind       = 22,
	InlineAsmValueKind             = 23,
	InstructionValueKind           = 24,
	PoisonValueValueKind           = 25,
	ConstantTargetNoneValueKind    = 26,
	ConstantPtrAuthValueKind       = 27,
}

IntPredicate :: enum i32 {
	EQ  = 32, /**< equal */
	NE  = 33, /**< not equal */
	UGT = 34, /**< unsigned greater than */
	UGE = 35, /**< unsigned greater or equal */
	ULT = 36, /**< unsigned less than */
	ULE = 37, /**< unsigned less or equal */
	SGT = 38, /**< signed greater than */
	SGE = 39, /**< signed greater or equal */
	SLT = 40, /**< signed less than */
	SLE = 41, /**< signed less or equal */
}

RealPredicate :: enum i32 {
	PredicateFalse = 0,  /**< Always false (always folded) */
	OEQ            = 1,  /**< True if ordered and equal */
	OGT            = 2,  /**< True if ordered and greater than */
	OGE            = 3,  /**< True if ordered and greater than or equal */
	OLT            = 4,  /**< True if ordered and less than */
	OLE            = 5,  /**< True if ordered and less than or equal */
	ONE            = 6,  /**< True if ordered and operands are unequal */
	ORD            = 7,  /**< True if ordered (no nans) */
	UNO            = 8,  /**< True if unordered: isnan(X) | isnan(Y) */
	UEQ            = 9,  /**< True if unordered or equal */
	UGT            = 10, /**< True if unordered or greater than */
	UGE            = 11, /**< True if unordered, greater than, or equal */
	ULT            = 12, /**< True if unordered or less than */
	ULE            = 13, /**< True if unordered, less than, or equal */
	UNE            = 14, /**< True if unordered or not equal */
	PredicateTrue  = 15, /**< Always true (always folded) */
}

ThreadLocalMode :: enum i32 {
	NotThreadLocal         = 0,
	GeneralDynamicTLSModel = 1,
	LocalDynamicTLSModel   = 2,
	InitialExecTLSModel    = 3,
	LocalExecTLSModel      = 4,
}

AtomicOrdering :: enum i32 {
	NotAtomic              = 0, /**< A load or store which is not atomic */
	Unordered              = 1, /**< Lowest level of atomicity, guarantees
                                     somewhat sane results, lock free. */
	Monotonic              = 2, /**< guarantees that if you take all the
                                     operations affecting a specific address,
                                     a consistent ordering exists */
	Acquire                = 4, /**< Acquire provides a barrier of the sort
                                   necessary to acquire a lock to access other
                                   memory with normal loads and stores. */
	Release                = 5, /**< Release is similar to Acquire, but with
                                   a barrier of the sort necessary to release
                                   a lock. */
	AcquireRelease         = 6, /**< provides both an Acquire and a
                                          Release barrier (for fences and
                                          operations which both read and write
                                           memory). */
	SequentiallyConsistent = 7, /**< provides Acquire semantics
                                                 for loads and Release
                                                 semantics for stores.
                                                 Additionally, it guarantees
                                                 that a total ordering exists
                                                 between all
                                                 SequentiallyConsistent
                                                 operations. */
}

AtomicRMWBinOp :: enum i32 {
	Xchg     = 0,  /**< Set the new value and return the one old */
	Add      = 1,  /**< Add a value and return the old one */
	Sub      = 2,  /**< Subtract a value and return the old one */
	And      = 3,  /**< And a value and return the old one */
	Nand     = 4,  /**< Not-And a value and return the old one */
	Or       = 5,  /**< OR a value and return the old one */
	Xor      = 6,  /**< Xor a value and return the old one */
	Max      = 7,  /**< Sets the value if it's greater than the
                            original using a signed comparison and return
                            the old one */
	Min      = 8,  /**< Sets the value if it's Smaller than the
                            original using a signed comparison and return
                            the old one */
	UMax     = 9,  /**< Sets the value if it's greater than the
                           original using an unsigned comparison and return
                           the old one */
	UMin     = 10, /**< Sets the value if it's greater than the
                            original using an unsigned comparison and return
                            the old one */
	FAdd     = 11, /**< Add a floating point value and return the
                            old one */
	FSub     = 12, /**< Subtract a floating point value and return the
                          old one */
	FMax     = 13, /**< Sets the value if it's greater than the
                           original using an floating point comparison and
                           return the old one */
	FMin     = 14, /**< Sets the value if it's smaller than the
                           original using an floating point comparison and
                           return the old one */
	UIncWrap = 15, /**< Increments the value, wrapping back to zero
                               when incremented above input value */
	UDecWrap = 16, /**< Decrements the value, wrapping back to
                               the input value when decremented below zero */
	USubCond = 17, /**<Subtracts the value only if no unsigned
                                 overflow */
	USubSat  = 18, /**<Subtracts the value, clamping to zero */
	FMaximum = 19, /**< Sets the value if it's greater than the
                           original using an floating point comparison and
                           return the old one */
	FMinimum = 20, /**< Sets the value if it's smaller than the
                           original using an floating point comparison and
                           return the old one */
}

DiagnosticSeverity :: enum i32 {
	Error   = 0,
	Warning = 1,
	Remark  = 2,
	Note    = 3,
}

InlineAsmDialect :: enum i32 {
	ATT   = 0,
	Intel = 1,
}

ModuleFlagBehavior :: enum i32 {
	/**
	* Emits an error if two values disagree, otherwise the resulting value is
	* that of the operands.
	*
	* @see Module::ModFlagBehavior::Error
	*/
	Error        = 0,

	/**
	* Emits a warning if two values disagree. The result value will be the
	* operand for the flag from the first module being linked.
	*
	* @see Module::ModFlagBehavior::Warning
	*/
	Warning      = 1,

	/**
	* Adds a requirement that another module flag be present and have a
	* specified value after linking is performed. The value must be a metadata
	* pair, where the first element of the pair is the ID of the module flag
	* to be restricted, and the second element of the pair is the value the
	* module flag should be restricted to. This behavior can be used to
	* restrict the allowable results (via triggering of an error) of linking
	* IDs with the **Override** behavior.
	*
	* @see Module::ModFlagBehavior::Require
	*/
	Require      = 2,

	/**
	* Uses the specified value, regardless of the behavior or value of the
	* other module. If both modules specify **Override**, but the values
	* differ, an error will be emitted.
	*
	* @see Module::ModFlagBehavior::Override
	*/
	Override     = 3,

	/**
	* Appends the two values, which are required to be metadata nodes.
	*
	* @see Module::ModFlagBehavior::Append
	*/
	Append       = 4,

	/**
	* Appends the two values, which are required to be metadata
	* nodes. However, duplicate entries in the second list are dropped
	* during the append operation.
	*
	* @see Module::ModFlagBehavior::AppendUnique
	*/
	AppendUnique = 5,
}

LLVMAttributeReturnIndex   :: 0
LLVMAttributeFunctionIndex :: -1

AttributeIndex :: u32

/**
* Tail call kind for LLVMSetTailCallKind and LLVMGetTailCallKind.
*
* Note that 'musttail' implies 'tail'.
*
* @see CallInst::TailCallKind
*/
TailCallKind :: enum i32 {
	None     = 0,
	Tail     = 1,
	MustTail = 2,
	NoTail   = 3,
}

LLVMFastMathAllowReassoc    :: 1
LLVMFastMathNoNaNs          :: 2
LLVMFastMathNoInfs          :: 4
LLVMFastMathNoSignedZeros   :: 8
LLVMFastMathAllowReciprocal :: 16
LLVMFastMathAllowContract   :: 32
LLVMFastMathApproxFunc      :: 64
LLVMFastMathNone            :: 0
LLVMFastMathAll             :: 127

/**
* Flags to indicate what fast-math-style optimizations are allowed
* on operations.
*
* See https://llvm.org/docs/LangRef.html#fast-math-flags
*/
FastMathFlags :: u32

LLVMGEPFlagInBounds :: 1
LLVMGEPFlagNUSW     :: 2
LLVMGEPFlagNUW      :: 4

/**
* Flags that constrain the allowed wrap semantics of a getelementptr
* instruction.
*
* See https://llvm.org/docs/LangRef.html#getelementptr-instruction
*/
GEPNoWrapFlags :: u32

DbgRecordKind :: enum i32 {
	Label   = 0,
	Declare = 1,
	Value   = 2,
	Assign  = 3,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/** Deallocate and destroy all ManagedStatic variables.
	@see llvm::llvm_shutdown
	@see ManagedStatic */
	Shutdown :: proc() ---

	/**
	* Return the major, minor, and patch version of LLVM
	*
	* The version components are returned via the function's three output
	* parameters or skipped if a NULL pointer was supplied.
	*/
	GetVersion :: proc(Major: ^u32, Minor: ^u32, Patch: ^u32) ---

	/*===-- Error handling ----------------------------------------------------===*/
	CreateMessage  :: proc(Message: cstring) -> cstring ---
	DisposeMessage :: proc(Message: cstring) ---
}

/**
* @defgroup LLVMCCoreContext Contexts
*
* Contexts are execution states for the core LLVM IR system.
*
* Most types are tied to a context instance. Multiple contexts can
* exist simultaneously. A single context is not thread safe. However,
* different contexts can execute on different threads simultaneously.
*
* @{
*/
DiagnosticHandler :: proc "c" (DiagnosticInfoRef, rawptr)
YieldCallback     :: proc "c" (ContextRef, rawptr)

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Create a new context.
	*
	* Every call to this function should be paired with a call to
	* LLVMContextDispose() or the context will leak memory.
	*/
	ContextCreate :: proc() -> ContextRef ---

	/**
	* Obtain the global context instance.
	*/
	GetGlobalContext :: proc() -> ContextRef ---

	/**
	* Set the diagnostic handler for this context.
	*/
	ContextSetDiagnosticHandler :: proc(C: ContextRef, Handler: DiagnosticHandler, DiagnosticContext: rawptr) ---

	/**
	* Get the diagnostic handler of this context.
	*/
	ContextGetDiagnosticHandler :: proc(C: ContextRef) -> DiagnosticHandler ---

	/**
	* Get the diagnostic context of this context.
	*/
	ContextGetDiagnosticContext :: proc(C: ContextRef) -> rawptr ---

	/**
	* Set the yield callback function for this context.
	*
	* @see LLVMContext::setYieldCallback()
	*/
	ContextSetYieldCallback :: proc(C: ContextRef, Callback: YieldCallback, OpaqueHandle: rawptr) ---

	/**
	* Retrieve whether the given context is set to discard all value names.
	*
	* @see LLVMContext::shouldDiscardValueNames()
	*/
	ContextShouldDiscardValueNames :: proc(C: ContextRef) -> Bool ---

	/**
	* Set whether the given context discards all value names.
	*
	* If true, only the names of GlobalValue objects will be available in the IR.
	* This can be used to save memory and runtime, especially in release mode.
	*
	* @see LLVMContext::setDiscardValueNames()
	*/
	ContextSetDiscardValueNames :: proc(C: ContextRef, Discard: Bool) ---

	/**
	* Destroy a context instance.
	*
	* This should be called for every call to LLVMContextCreate() or memory
	* will be leaked.
	*/
	ContextDispose :: proc(C: ContextRef) ---

	/**
	* Return a string representation of the DiagnosticInfo. Use
	* LLVMDisposeMessage to free the string.
	*
	* @see DiagnosticInfo::print()
	*/
	GetDiagInfoDescription :: proc(DI: DiagnosticInfoRef) -> cstring ---

	/**
	* Return an enum LLVMDiagnosticSeverity.
	*
	* @see DiagnosticInfo::getSeverity()
	*/
	GetDiagInfoSeverity  :: proc(DI: DiagnosticInfoRef) -> DiagnosticSeverity ---
	GetMDKindIDInContext :: proc(C: ContextRef, Name: cstring, SLen: u32) -> u32 ---
	GetMDKindID          :: proc(Name: cstring, SLen: u32) -> u32 ---

	/**
	* Maps a synchronization scope name to a ID unique within this context.
	*/
	GetSyncScopeID :: proc(C: ContextRef, Name: cstring, SLen: c.size_t) -> u32 ---

	/**
	* Return an unique id given the name of a enum attribute,
	* or 0 if no attribute by that name exists.
	*
	* See http://llvm.org/docs/LangRef.html#parameter-attributes
	* and http://llvm.org/docs/LangRef.html#function-attributes
	* for the list of available attributes.
	*
	* NB: Attribute names and/or id are subject to change without
	* going through the C API deprecation cycle.
	*/
	GetEnumAttributeKindForName :: proc(Name: cstring, SLen: c.size_t) -> u32 ---
	GetLastEnumAttributeKind    :: proc() -> u32 ---

	/**
	* Create an enum attribute.
	*/
	CreateEnumAttribute :: proc(C: ContextRef, KindID: u32, Val: u64) -> AttributeRef ---

	/**
	* Get the unique id corresponding to the enum attribute
	* passed as argument.
	*/
	GetEnumAttributeKind :: proc(A: AttributeRef) -> u32 ---

	/**
	* Get the enum attribute's value. 0 is returned if none exists.
	*/
	GetEnumAttributeValue :: proc(A: AttributeRef) -> u64 ---

	/**
	* Create a type attribute
	*/
	CreateTypeAttribute :: proc(C: ContextRef, KindID: u32, type_ref: TypeRef) -> AttributeRef ---

	/**
	* Get the type attribute's value.
	*/
	GetTypeAttributeValue :: proc(A: AttributeRef) -> TypeRef ---

	/**
	* Create a ConstantRange attribute.
	*
	* LowerWords and UpperWords need to be NumBits divided by 64 rounded up
	* elements long.
	*/
	CreateConstantRangeAttribute :: proc(C: ContextRef, KindID: u32, NumBits: u32, LowerWords: [^]u64, UpperWords: [^]u64) -> AttributeRef ---

	/**
	* Create a string attribute.
	*/
	CreateStringAttribute :: proc(C: ContextRef, K: cstring, KLength: u32, V: cstring, VLength: u32) -> AttributeRef ---

	/**
	* Get the string attribute's kind.
	*/
	GetStringAttributeKind :: proc(A: AttributeRef, Length: ^u32) -> cstring ---

	/**
	* Get the string attribute's value.
	*/
	GetStringAttributeValue :: proc(A: AttributeRef, Length: ^u32) -> cstring ---

	/**
	* Check for the different types of attributes.
	*/
	IsEnumAttribute   :: proc(A: AttributeRef) -> Bool ---
	IsStringAttribute :: proc(A: AttributeRef) -> Bool ---
	IsTypeAttribute   :: proc(A: AttributeRef) -> Bool ---

	/**
	* Obtain a Type from a context by its registered name.
	*/
	GetTypeByName2 :: proc(C: ContextRef, Name: cstring) -> TypeRef ---

	/**
	* Create a new, empty module in the global context.
	*
	* This is equivalent to calling LLVMModuleCreateWithNameInContext with
	* LLVMGetGlobalContext() as the context parameter.
	*
	* Every invocation should be paired with LLVMDisposeModule() or memory
	* will be leaked.
	*/
	ModuleCreateWithName :: proc(ModuleID: cstring) -> ModuleRef ---

	/**
	* Create a new, empty module in a specific context.
	*
	* Every invocation should be paired with LLVMDisposeModule() or memory
	* will be leaked.
	*/
	ModuleCreateWithNameInContext :: proc(ModuleID: cstring, C: ContextRef) -> ModuleRef ---

	/**
	* Return an exact copy of the specified module.
	*/
	CloneModule :: proc(M: ModuleRef) -> ModuleRef ---

	/**
	* Destroy a module instance.
	*
	* This must be called for every created module or memory will be
	* leaked.
	*/
	DisposeModule :: proc(M: ModuleRef) ---

	/**
	* Soon to be deprecated.
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* Returns true if the module is in the new debug info mode which uses
	* non-instruction debug records instead of debug intrinsics for variable
	* location tracking.
	*/
	IsNewDbgInfoFormat :: proc(M: ModuleRef) -> Bool ---

	/**
	* Soon to be deprecated.
	* See https://llvm.org/docs/RemoveDIsDebugInfo.html#c-api-changes
	*
	* Convert module into desired debug info format.
	*/
	SetIsNewDbgInfoFormat :: proc(M: ModuleRef, UseNewFormat: Bool) ---

	/**
	* Obtain the identifier of a module.
	*
	* @param M Module to obtain identifier of
	* @param Len Out parameter which holds the length of the returned string.
	* @return The identifier of M.
	* @see Module::getModuleIdentifier()
	*/
	GetModuleIdentifier :: proc(M: ModuleRef, Len: ^c.size_t) -> cstring ---

	/**
	* Set the identifier of a module to a string Ident with length Len.
	*
	* @param M The module to set identifier
	* @param Ident The string to set M's identifier to
	* @param Len Length of Ident
	* @see Module::setModuleIdentifier()
	*/
	SetModuleIdentifier :: proc(M: ModuleRef, Ident: cstring, Len: c.size_t) ---

	/**
	* Obtain the module's original source file name.
	*
	* @param M Module to obtain the name of
	* @param Len Out parameter which holds the length of the returned string
	* @return The original source file name of M
	* @see Module::getSourceFileName()
	*/
	GetSourceFileName :: proc(M: ModuleRef, Len: ^c.size_t) -> cstring ---

	/**
	* Set the original source file name of a module to a string Name with length
	* Len.
	*
	* @param M The module to set the source file name of
	* @param Name The string to set M's source file name to
	* @param Len Length of Name
	* @see Module::setSourceFileName()
	*/
	SetSourceFileName :: proc(M: ModuleRef, Name: cstring, Len: c.size_t) ---

	/**
	* Obtain the data layout for a module.
	*
	* @see Module::getDataLayoutStr()
	*
	* LLVMGetDataLayout is DEPRECATED, as the name is not only incorrect,
	* but match the name of another method on the module. Prefer the use
	* of LLVMGetDataLayoutStr, which is not ambiguous.
	*/
	GetDataLayoutStr :: proc(M: ModuleRef) -> cstring ---
	GetDataLayout    :: proc(M: ModuleRef) -> cstring ---

	/**
	* Set the data layout for a module.
	*
	* @see Module::setDataLayout()
	*/
	SetDataLayout :: proc(M: ModuleRef, DataLayoutStr: cstring) ---

	/**
	* Obtain the target triple for a module.
	*
	* @see Module::getTargetTriple()
	*/
	GetTarget :: proc(M: ModuleRef) -> cstring ---

	/**
	* Set the target triple for a module.
	*
	* @see Module::setTargetTriple()
	*/
	SetTarget :: proc(M: ModuleRef, Triple: cstring) ---

	/**
	* Returns the module flags as an array of flag-key-value triples.  The caller
	* is responsible for freeing this array by calling
	* \c LLVMDisposeModuleFlagsMetadata.
	*
	* @see Module::getModuleFlagsMetadata()
	*/
	CopyModuleFlagsMetadata :: proc(M: ModuleRef, Len: ^c.size_t) -> ^ModuleFlagEntry ---

	/**
	* Destroys module flags metadata entries.
	*/
	DisposeModuleFlagsMetadata :: proc(Entries: ^ModuleFlagEntry) ---

	/**
	* Returns the flag behavior for a module flag entry at a specific index.
	*
	* @see Module::ModuleFlagEntry::Behavior
	*/
	ModuleFlagEntriesGetFlagBehavior :: proc(Entries: ^ModuleFlagEntry, Index: u32) -> ModuleFlagBehavior ---

	/**
	* Returns the key for a module flag entry at a specific index.
	*
	* @see Module::ModuleFlagEntry::Key
	*/
	ModuleFlagEntriesGetKey :: proc(Entries: ^ModuleFlagEntry, Index: u32, Len: ^c.size_t) -> cstring ---

	/**
	* Returns the metadata for a module flag entry at a specific index.
	*
	* @see Module::ModuleFlagEntry::Val
	*/
	ModuleFlagEntriesGetMetadata :: proc(Entries: ^ModuleFlagEntry, Index: u32) -> MetadataRef ---

	/**
	* Add a module-level flag to the module-level flags metadata if it doesn't
	* already exist.
	*
	* @see Module::getModuleFlag()
	*/
	GetModuleFlag :: proc(M: ModuleRef, Key: cstring, KeyLen: c.size_t) -> MetadataRef ---

	/**
	* Add a module-level flag to the module-level flags metadata if it doesn't
	* already exist.
	*
	* @see Module::addModuleFlag()
	*/
	AddModuleFlag :: proc(M: ModuleRef, Behavior: ModuleFlagBehavior, Key: cstring, KeyLen: c.size_t, Val: MetadataRef) ---

	/**
	* Dump a representation of a module to stderr.
	*
	* @see Module::dump()
	*/
	DumpModule :: proc(M: ModuleRef) ---

	/**
	* Print a representation of a module to a file. The ErrorMessage needs to be
	* disposed with LLVMDisposeMessage. Returns 0 on success, 1 otherwise.
	*
	* @see Module::print()
	*/
	PrintModuleToFile :: proc(M: ModuleRef, Filename: cstring, ErrorMessage: ^cstring) -> Bool ---

	/**
	* Return a string representation of the module. Use
	* LLVMDisposeMessage to free the string.
	*
	* @see Module::print()
	*/
	PrintModuleToString :: proc(M: ModuleRef) -> cstring ---

	/**
	* Get inline assembly for a module.
	*
	* @see Module::getModuleInlineAsm()
	*/
	GetModuleInlineAsm :: proc(M: ModuleRef, Len: ^c.size_t) -> cstring ---

	/**
	* Set inline assembly for a module.
	*
	* @see Module::setModuleInlineAsm()
	*/
	SetModuleInlineAsm2 :: proc(M: ModuleRef, Asm: cstring, Len: c.size_t) ---

	/**
	* Append inline assembly to a module.
	*
	* @see Module::appendModuleInlineAsm()
	*/
	AppendModuleInlineAsm :: proc(M: ModuleRef, Asm: cstring, Len: c.size_t) ---

	/**
	* Create the specified uniqued inline asm string.
	*
	* @see InlineAsm::get()
	*/
	GetInlineAsm :: proc(Ty: TypeRef, AsmString: cstring, AsmStringSize: c.size_t, Constraints: cstring, ConstraintsSize: c.size_t, HasSideEffects: Bool, IsAlignStack: Bool, Dialect: InlineAsmDialect, CanThrow: Bool) -> ValueRef ---

	/**
	* Get the template string used for an inline assembly snippet
	*
	*/
	GetInlineAsmAsmString :: proc(InlineAsmVal: ValueRef, Len: ^c.size_t) -> cstring ---

	/**
	* Get the raw constraint string for an inline assembly snippet
	*
	*/
	GetInlineAsmConstraintString :: proc(InlineAsmVal: ValueRef, Len: ^c.size_t) -> cstring ---

	/**
	* Get the dialect used by the inline asm snippet
	*
	*/
	GetInlineAsmDialect :: proc(InlineAsmVal: ValueRef) -> InlineAsmDialect ---

	/**
	* Get the function type of the inline assembly snippet. The same type that
	* was passed into LLVMGetInlineAsm originally
	*
	* @see LLVMGetInlineAsm
	*
	*/
	GetInlineAsmFunctionType :: proc(InlineAsmVal: ValueRef) -> TypeRef ---

	/**
	* Get if the inline asm snippet has side effects
	*
	*/
	GetInlineAsmHasSideEffects :: proc(InlineAsmVal: ValueRef) -> Bool ---

	/**
	* Get if the inline asm snippet needs an aligned stack
	*
	*/
	GetInlineAsmNeedsAlignedStack :: proc(InlineAsmVal: ValueRef) -> Bool ---

	/**
	* Get if the inline asm snippet may unwind the stack
	*
	*/
	GetInlineAsmCanUnwind :: proc(InlineAsmVal: ValueRef) -> Bool ---

	/**
	* Obtain the context to which this module is associated.
	*
	* @see Module::getContext()
	*/
	GetModuleContext :: proc(M: ModuleRef) -> ContextRef ---

	/** Deprecated: Use LLVMGetTypeByName2 instead. */
	GetTypeByName :: proc(M: ModuleRef, Name: cstring) -> TypeRef ---

	/**
	* Obtain an iterator to the first NamedMDNode in a Module.
	*
	* @see llvm::Module::named_metadata_begin()
	*/
	GetFirstNamedMetadata :: proc(M: ModuleRef) -> NamedMDNodeRef ---

	/**
	* Obtain an iterator to the last NamedMDNode in a Module.
	*
	* @see llvm::Module::named_metadata_end()
	*/
	GetLastNamedMetadata :: proc(M: ModuleRef) -> NamedMDNodeRef ---

	/**
	* Advance a NamedMDNode iterator to the next NamedMDNode.
	*
	* Returns NULL if the iterator was already at the end and there are no more
	* named metadata nodes.
	*/
	GetNextNamedMetadata :: proc(NamedMDNode: NamedMDNodeRef) -> NamedMDNodeRef ---

	/**
	* Decrement a NamedMDNode iterator to the previous NamedMDNode.
	*
	* Returns NULL if the iterator was already at the beginning and there are
	* no previous named metadata nodes.
	*/
	GetPreviousNamedMetadata :: proc(NamedMDNode: NamedMDNodeRef) -> NamedMDNodeRef ---

	/**
	* Retrieve a NamedMDNode with the given name, returning NULL if no such
	* node exists.
	*
	* @see llvm::Module::getNamedMetadata()
	*/
	GetNamedMetadata :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t) -> NamedMDNodeRef ---

	/**
	* Retrieve a NamedMDNode with the given name, creating a new node if no such
	* node exists.
	*
	* @see llvm::Module::getOrInsertNamedMetadata()
	*/
	GetOrInsertNamedMetadata :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t) -> NamedMDNodeRef ---

	/**
	* Retrieve the name of a NamedMDNode.
	*
	* @see llvm::NamedMDNode::getName()
	*/
	GetNamedMetadataName :: proc(NamedMD: NamedMDNodeRef, NameLen: ^c.size_t) -> cstring ---

	/**
	* Obtain the number of operands for named metadata in a module.
	*
	* @see llvm::Module::getNamedMetadata()
	*/
	GetNamedMetadataNumOperands :: proc(M: ModuleRef, Name: cstring) -> u32 ---

	/**
	* Obtain the named metadata operands for a module.
	*
	* The passed LLVMValueRef pointer should refer to an array of
	* LLVMValueRef at least LLVMGetNamedMetadataNumOperands long. This
	* array will be populated with the LLVMValueRef instances. Each
	* instance corresponds to a llvm::MDNode.
	*
	* @see llvm::Module::getNamedMetadata()
	* @see llvm::MDNode::getOperand()
	*/
	GetNamedMetadataOperands :: proc(M: ModuleRef, Name: cstring, Dest: ^ValueRef) ---

	/**
	* Add an operand to named metadata.
	*
	* @see llvm::Module::getNamedMetadata()
	* @see llvm::MDNode::addOperand()
	*/
	AddNamedMetadataOperand :: proc(M: ModuleRef, Name: cstring, Val: ValueRef) ---

	/**
	* Return the directory of the debug location for this value, which must be
	* an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
	*
	* @see llvm::Instruction::getDebugLoc()
	* @see llvm::GlobalVariable::getDebugInfo()
	* @see llvm::Function::getSubprogram()
	*/
	GetDebugLocDirectory :: proc(Val: ValueRef, Length: ^u32) -> cstring ---

	/**
	* Return the filename of the debug location for this value, which must be
	* an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
	*
	* @see llvm::Instruction::getDebugLoc()
	* @see llvm::GlobalVariable::getDebugInfo()
	* @see llvm::Function::getSubprogram()
	*/
	GetDebugLocFilename :: proc(Val: ValueRef, Length: ^u32) -> cstring ---

	/**
	* Return the line number of the debug location for this value, which must be
	* an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
	*
	* @see llvm::Instruction::getDebugLoc()
	* @see llvm::GlobalVariable::getDebugInfo()
	* @see llvm::Function::getSubprogram()
	*/
	GetDebugLocLine :: proc(Val: ValueRef) -> u32 ---

	/**
	* Return the column number of the debug location for this value, which must be
	* an llvm::Instruction.
	*
	* @see llvm::Instruction::getDebugLoc()
	*/
	GetDebugLocColumn :: proc(Val: ValueRef) -> u32 ---

	/**
	* Add a function to a module under a specified name.
	*
	* @see llvm::Function::Create()
	*/
	AddFunction :: proc(M: ModuleRef, Name: cstring, FunctionTy: TypeRef) -> ValueRef ---

	/**
	* Obtain or insert a function into a module.
	*
	* If a function with the specified name already exists in the module, it
	* is returned. Otherwise, a new function is created in the module with the
	* specified name and type and is returned.
	*
	* The returned value corresponds to a llvm::Function instance.
	*
	* @see llvm::Module::getOrInsertFunction()
	*/
	GetOrInsertFunction :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t, FunctionTy: TypeRef) -> ValueRef ---

	/**
	* Obtain a Function value from a Module by its name.
	*
	* The returned value corresponds to a llvm::Function value.
	*
	* @see llvm::Module::getFunction()
	*/
	GetNamedFunction :: proc(M: ModuleRef, Name: cstring) -> ValueRef ---

	/**
	* Obtain a Function value from a Module by its name.
	*
	* The returned value corresponds to a llvm::Function value.
	*
	* @see llvm::Module::getFunction()
	*/
	GetNamedFunctionWithLength :: proc(M: ModuleRef, Name: cstring, Length: c.size_t) -> ValueRef ---

	/**
	* Obtain an iterator to the first Function in a Module.
	*
	* @see llvm::Module::begin()
	*/
	GetFirstFunction :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Obtain an iterator to the last Function in a Module.
	*
	* @see llvm::Module::end()
	*/
	GetLastFunction :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Advance a Function iterator to the next Function.
	*
	* Returns NULL if the iterator was already at the end and there are no more
	* functions.
	*/
	GetNextFunction :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Decrement a Function iterator to the previous Function.
	*
	* Returns NULL if the iterator was already at the beginning and there are
	* no previous functions.
	*/
	GetPreviousFunction :: proc(Fn: ValueRef) -> ValueRef ---

	/** Deprecated: Use LLVMSetModuleInlineAsm2 instead. */
	SetModuleInlineAsm :: proc(M: ModuleRef, Asm: cstring) ---

	/**
	* Obtain the enumerated type of a Type instance.
	*
	* @see llvm::Type:getTypeID()
	*/
	GetTypeKind :: proc(Ty: TypeRef) -> TypeKind ---

	/**
	* Whether the type has a known size.
	*
	* Things that don't have a size are abstract types, labels, and void.a
	*
	* @see llvm::Type::isSized()
	*/
	TypeIsSized :: proc(Ty: TypeRef) -> Bool ---

	/**
	* Obtain the context to which this type instance is associated.
	*
	* @see llvm::Type::getContext()
	*/
	GetTypeContext :: proc(Ty: TypeRef) -> ContextRef ---

	/**
	* Dump a representation of a type to stderr.
	*
	* @see llvm::Type::dump()
	*/
	DumpType :: proc(Val: TypeRef) ---

	/**
	* Return a string representation of the type. Use
	* LLVMDisposeMessage to free the string.
	*
	* @see llvm::Type::print()
	*/
	PrintTypeToString :: proc(Val: TypeRef) -> cstring ---

	/**
	* Obtain an integer type from a context with specified bit width.
	*/
	Int1TypeInContext   :: proc(C: ContextRef) -> TypeRef ---
	Int8TypeInContext   :: proc(C: ContextRef) -> TypeRef ---
	Int16TypeInContext  :: proc(C: ContextRef) -> TypeRef ---
	Int32TypeInContext  :: proc(C: ContextRef) -> TypeRef ---
	Int64TypeInContext  :: proc(C: ContextRef) -> TypeRef ---
	Int128TypeInContext :: proc(C: ContextRef) -> TypeRef ---
	IntTypeInContext    :: proc(C: ContextRef, NumBits: u32) -> TypeRef ---

	/**
	* Obtain an integer type from the global context with a specified bit
	* width.
	*/
	Int1Type        :: proc() -> TypeRef ---
	Int8Type        :: proc() -> TypeRef ---
	Int16Type       :: proc() -> TypeRef ---
	Int32Type       :: proc() -> TypeRef ---
	Int64Type       :: proc() -> TypeRef ---
	Int128Type      :: proc() -> TypeRef ---
	IntType         :: proc(NumBits: u32) -> TypeRef ---
	GetIntTypeWidth :: proc(IntegerTy: TypeRef) -> u32 ---

	/**
	* Obtain a 16-bit floating point type from a context.
	*/
	HalfTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 16-bit brain floating point type from a context.
	*/
	BFloatTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 32-bit floating point type from a context.
	*/
	FloatTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 64-bit floating point type from a context.
	*/
	DoubleTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 80-bit floating point type (X87) from a context.
	*/
	X86FP80TypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 128-bit floating point type (112-bit mantissa) from a
	* context.
	*/
	FP128TypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a 128-bit floating point type (two 64-bits) from a context.
	*/
	PPCFP128TypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Obtain a floating point type from the global context.
	*
	* These map to the functions in this group of the same name.
	*/
	HalfType     :: proc() -> TypeRef ---
	BFloatType   :: proc() -> TypeRef ---
	FloatType    :: proc() -> TypeRef ---
	DoubleType   :: proc() -> TypeRef ---
	X86FP80Type  :: proc() -> TypeRef ---
	FP128Type    :: proc() -> TypeRef ---
	PPCFP128Type :: proc() -> TypeRef ---

	/**
	* Obtain a function type consisting of a specified signature.
	*
	* The function is defined as a tuple of a return Type, a list of
	* parameter types, and whether the function is variadic.
	*/
	FunctionType :: proc(ReturnType: TypeRef, ParamTypes: ^TypeRef, ParamCount: u32, IsVarArg: Bool) -> TypeRef ---

	/**
	* Returns whether a function type is variadic.
	*/
	IsFunctionVarArg :: proc(FunctionTy: TypeRef) -> Bool ---

	/**
	* Obtain the Type this function Type returns.
	*/
	GetReturnType :: proc(FunctionTy: TypeRef) -> TypeRef ---

	/**
	* Obtain the number of parameters this function accepts.
	*/
	CountParamTypes :: proc(FunctionTy: TypeRef) -> u32 ---

	/**
	* Obtain the types of a function's parameters.
	*
	* The Dest parameter should point to a pre-allocated array of
	* LLVMTypeRef at least LLVMCountParamTypes() large. On return, the
	* first LLVMCountParamTypes() entries in the array will be populated
	* with LLVMTypeRef instances.
	*
	* @param FunctionTy The function type to operate on.
	* @param Dest Memory address of an array to be filled with result.
	*/
	GetParamTypes :: proc(FunctionTy: TypeRef, Dest: ^TypeRef) ---

	/**
	* Create a new structure type in a context.
	*
	* A structure is specified by a list of inner elements/types and
	* whether these can be packed together.
	*
	* @see llvm::StructType::create()
	*/
	StructTypeInContext :: proc(C: ContextRef, ElementTypes: ^TypeRef, ElementCount: u32, Packed: Bool) -> TypeRef ---

	/**
	* Create a new structure type in the global context.
	*
	* @see llvm::StructType::create()
	*/
	StructType :: proc(ElementTypes: ^TypeRef, ElementCount: u32, Packed: Bool) -> TypeRef ---

	/**
	* Create an empty structure in a context having a specified name.
	*
	* @see llvm::StructType::create()
	*/
	StructCreateNamed :: proc(C: ContextRef, Name: cstring) -> TypeRef ---

	/**
	* Obtain the name of a structure.
	*
	* @see llvm::StructType::getName()
	*/
	GetStructName :: proc(Ty: TypeRef) -> cstring ---

	/**
	* Set the contents of a structure type.
	*
	* @see llvm::StructType::setBody()
	*/
	StructSetBody :: proc(StructTy: TypeRef, ElementTypes: ^TypeRef, ElementCount: u32, Packed: Bool) ---

	/**
	* Get the number of elements defined inside the structure.
	*
	* @see llvm::StructType::getNumElements()
	*/
	CountStructElementTypes :: proc(StructTy: TypeRef) -> u32 ---

	/**
	* Get the elements within a structure.
	*
	* The function is passed the address of a pre-allocated array of
	* LLVMTypeRef at least LLVMCountStructElementTypes() long. After
	* invocation, this array will be populated with the structure's
	* elements. The objects in the destination array will have a lifetime
	* of the structure type itself, which is the lifetime of the context it
	* is contained in.
	*/
	GetStructElementTypes :: proc(StructTy: TypeRef, Dest: ^TypeRef) ---

	/**
	* Get the type of the element at a given index in the structure.
	*
	* @see llvm::StructType::getTypeAtIndex()
	*/
	StructGetTypeAtIndex :: proc(StructTy: TypeRef, i: u32) -> TypeRef ---

	/**
	* Determine whether a structure is packed.
	*
	* @see llvm::StructType::isPacked()
	*/
	IsPackedStruct :: proc(StructTy: TypeRef) -> Bool ---

	/**
	* Determine whether a structure is opaque.
	*
	* @see llvm::StructType::isOpaque()
	*/
	IsOpaqueStruct :: proc(StructTy: TypeRef) -> Bool ---

	/**
	* Determine whether a structure is literal.
	*
	* @see llvm::StructType::isLiteral()
	*/
	IsLiteralStruct :: proc(StructTy: TypeRef) -> Bool ---

	/**
	* Obtain the element type of an array or vector type.
	*
	* @see llvm::SequentialType::getElementType()
	*/
	GetElementType :: proc(Ty: TypeRef) -> TypeRef ---

	/**
	* Returns type's subtypes
	*
	* @see llvm::Type::subtypes()
	*/
	GetSubtypes :: proc(Tp: TypeRef, Arr: ^TypeRef) ---

	/**
	*  Return the number of types in the derived type.
	*
	* @see llvm::Type::getNumContainedTypes()
	*/
	GetNumContainedTypes :: proc(Tp: TypeRef) -> u32 ---

	/**
	* Create a fixed size array type that refers to a specific type.
	*
	* The created type will exist in the context that its element type
	* exists in.
	*
	* @deprecated LLVMArrayType is deprecated in favor of the API accurate
	* LLVMArrayType2
	* @see llvm::ArrayType::get()
	*/
	ArrayType :: proc(ElementType: TypeRef, ElementCount: u32) -> TypeRef ---

	/**
	* Create a fixed size array type that refers to a specific type.
	*
	* The created type will exist in the context that its element type
	* exists in.
	*
	* @see llvm::ArrayType::get()
	*/
	ArrayType2 :: proc(ElementType: TypeRef, ElementCount: u64) -> TypeRef ---

	/**
	* Obtain the length of an array type.
	*
	* This only works on types that represent arrays.
	*
	* @deprecated LLVMGetArrayLength is deprecated in favor of the API accurate
	* LLVMGetArrayLength2
	* @see llvm::ArrayType::getNumElements()
	*/
	GetArrayLength :: proc(ArrayTy: TypeRef) -> u32 ---

	/**
	* Obtain the length of an array type.
	*
	* This only works on types that represent arrays.
	*
	* @see llvm::ArrayType::getNumElements()
	*/
	GetArrayLength2 :: proc(ArrayTy: TypeRef) -> u64 ---

	/**
	* Create a pointer type that points to a defined type.
	*
	* The created type will exist in the context that its pointee type
	* exists in.
	*
	* @see llvm::PointerType::get()
	*/
	PointerType :: proc(ElementType: TypeRef, AddressSpace: u32) -> TypeRef ---

	/**
	* Determine whether a pointer is opaque.
	*
	* True if this is an instance of an opaque PointerType.
	*
	* @see llvm::Type::isOpaquePointerTy()
	*/
	PointerTypeIsOpaque :: proc(Ty: TypeRef) -> Bool ---

	/**
	* Create an opaque pointer type in a context.
	*
	* @see llvm::PointerType::get()
	*/
	PointerTypeInContext :: proc(C: ContextRef, AddressSpace: u32) -> TypeRef ---

	/**
	* Obtain the address space of a pointer type.
	*
	* This only works on types that represent pointers.
	*
	* @see llvm::PointerType::getAddressSpace()
	*/
	GetPointerAddressSpace :: proc(PointerTy: TypeRef) -> u32 ---

	/**
	* Create a vector type that contains a defined type and has a specific
	* number of elements.
	*
	* The created type will exist in the context thats its element type
	* exists in.
	*
	* @see llvm::VectorType::get()
	*/
	VectorType :: proc(ElementType: TypeRef, ElementCount: u32) -> TypeRef ---

	/**
	* Create a vector type that contains a defined type and has a scalable
	* number of elements.
	*
	* The created type will exist in the context thats its element type
	* exists in.
	*
	* @see llvm::ScalableVectorType::get()
	*/
	ScalableVectorType :: proc(ElementType: TypeRef, ElementCount: u32) -> TypeRef ---

	/**
	* Obtain the (possibly scalable) number of elements in a vector type.
	*
	* This only works on types that represent vectors (fixed or scalable).
	*
	* @see llvm::VectorType::getNumElements()
	*/
	GetVectorSize :: proc(VectorTy: TypeRef) -> u32 ---

	/**
	* Get the pointer value for the associated ConstantPtrAuth constant.
	*
	* @see llvm::ConstantPtrAuth::getPointer
	*/
	GetConstantPtrAuthPointer :: proc(PtrAuth: ValueRef) -> ValueRef ---

	/**
	* Get the key value for the associated ConstantPtrAuth constant.
	*
	* @see llvm::ConstantPtrAuth::getKey
	*/
	GetConstantPtrAuthKey :: proc(PtrAuth: ValueRef) -> ValueRef ---

	/**
	* Get the discriminator value for the associated ConstantPtrAuth constant.
	*
	* @see llvm::ConstantPtrAuth::getDiscriminator
	*/
	GetConstantPtrAuthDiscriminator :: proc(PtrAuth: ValueRef) -> ValueRef ---

	/**
	* Get the address discriminator value for the associated ConstantPtrAuth
	* constant.
	*
	* @see llvm::ConstantPtrAuth::getAddrDiscriminator
	*/
	GetConstantPtrAuthAddrDiscriminator :: proc(PtrAuth: ValueRef) -> ValueRef ---

	/**
	* Create a void type in a context.
	*/
	VoidTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Create a label type in a context.
	*/
	LabelTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Create a X86 AMX type in a context.
	*/
	X86AMXTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Create a token type in a context.
	*/
	TokenTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* Create a metadata type in a context.
	*/
	MetadataTypeInContext :: proc(C: ContextRef) -> TypeRef ---

	/**
	* These are similar to the above functions except they operate on the
	* global context.
	*/
	VoidType   :: proc() -> TypeRef ---
	LabelType  :: proc() -> TypeRef ---
	X86AMXType :: proc() -> TypeRef ---

	/**
	* Create a target extension type in LLVM context.
	*/
	TargetExtTypeInContext :: proc(C: ContextRef, Name: cstring, TypeParams: ^TypeRef, TypeParamCount: u32, IntParams: ^u32, IntParamCount: u32) -> TypeRef ---

	/**
	* Obtain the name for this target extension type.
	*
	* @see llvm::TargetExtType::getName()
	*/
	GetTargetExtTypeName :: proc(TargetExtTy: TypeRef) -> cstring ---

	/**
	* Obtain the number of type parameters for this target extension type.
	*
	* @see llvm::TargetExtType::getNumTypeParameters()
	*/
	GetTargetExtTypeNumTypeParams :: proc(TargetExtTy: TypeRef) -> u32 ---

	/**
	* Get the type parameter at the given index for the target extension type.
	*
	* @see llvm::TargetExtType::getTypeParameter()
	*/
	GetTargetExtTypeTypeParam :: proc(TargetExtTy: TypeRef, Idx: u32) -> TypeRef ---

	/**
	* Obtain the number of int parameters for this target extension type.
	*
	* @see llvm::TargetExtType::getNumIntParameters()
	*/
	GetTargetExtTypeNumIntParams :: proc(TargetExtTy: TypeRef) -> u32 ---

	/**
	* Get the int parameter at the given index for the target extension type.
	*
	* @see llvm::TargetExtType::getIntParameter()
	*/
	GetTargetExtTypeIntParam :: proc(TargetExtTy: TypeRef, Idx: u32) -> u32 ---

	/**
	* Obtain the type of a value.
	*
	* @see llvm::Value::getType()
	*/
	TypeOf :: proc(Val: ValueRef) -> TypeRef ---

	/**
	* Obtain the enumerated type of a Value instance.
	*
	* @see llvm::Value::getValueID()
	*/
	GetValueKind :: proc(Val: ValueRef) -> ValueKind ---

	/**
	* Obtain the string name of a value.
	*
	* @see llvm::Value::getName()
	*/
	GetValueName2 :: proc(Val: ValueRef, Length: ^c.size_t) -> cstring ---

	/**
	* Set the string name of a value.
	*
	* @see llvm::Value::setName()
	*/
	SetValueName2 :: proc(Val: ValueRef, Name: cstring, NameLen: c.size_t) ---

	/**
	* Dump a representation of a value to stderr.
	*
	* @see llvm::Value::dump()
	*/
	DumpValue :: proc(Val: ValueRef) ---

	/**
	* Return a string representation of the value. Use
	* LLVMDisposeMessage to free the string.
	*
	* @see llvm::Value::print()
	*/
	PrintValueToString :: proc(Val: ValueRef) -> cstring ---

	/**
	* Obtain the context to which this value is associated.
	*
	* @see llvm::Value::getContext()
	*/
	GetValueContext :: proc(Val: ValueRef) -> ContextRef ---

	/**
	* Return a string representation of the DbgRecord. Use
	* LLVMDisposeMessage to free the string.
	*
	* @see llvm::DbgRecord::print()
	*/
	PrintDbgRecordToString :: proc(Record: DbgRecordRef) -> cstring ---

	/**
	* Replace all uses of a value with another one.
	*
	* @see llvm::Value::replaceAllUsesWith()
	*/
	ReplaceAllUsesWith :: proc(OldVal: ValueRef, NewVal: ValueRef) ---

	/**
	* Determine whether the specified value instance is constant.
	*/
	IsConstant :: proc(Val: ValueRef) -> Bool ---

	/**
	* Determine whether a value instance is undefined.
	*/
	IsUndef :: proc(Val: ValueRef) -> Bool ---

	/**
	* Determine whether a value instance is poisonous.
	*/
	IsPoison                  :: proc(Val: ValueRef) -> Bool ---
	IsAArgument               :: proc(Val: ValueRef) -> ValueRef ---
	IsABasicBlock             :: proc(Val: ValueRef) -> ValueRef ---
	IsAInlineAsm              :: proc(Val: ValueRef) -> ValueRef ---
	IsAUser                   :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstant               :: proc(Val: ValueRef) -> ValueRef ---
	IsABlockAddress           :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantAggregateZero  :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantArray          :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantDataSequential :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantDataArray      :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantDataVector     :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantExpr           :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantFP             :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantInt            :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantPointerNull    :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantStruct         :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantTokenNone      :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantVector         :: proc(Val: ValueRef) -> ValueRef ---
	IsAConstantPtrAuth        :: proc(Val: ValueRef) -> ValueRef ---
	IsAGlobalValue            :: proc(Val: ValueRef) -> ValueRef ---
	IsAGlobalAlias            :: proc(Val: ValueRef) -> ValueRef ---
	IsAGlobalObject           :: proc(Val: ValueRef) -> ValueRef ---
	IsAFunction               :: proc(Val: ValueRef) -> ValueRef ---
	IsAGlobalVariable         :: proc(Val: ValueRef) -> ValueRef ---
	IsAGlobalIFunc            :: proc(Val: ValueRef) -> ValueRef ---
	IsAUndefValue             :: proc(Val: ValueRef) -> ValueRef ---
	IsAPoisonValue            :: proc(Val: ValueRef) -> ValueRef ---
	IsAInstruction            :: proc(Val: ValueRef) -> ValueRef ---
	IsAUnaryOperator          :: proc(Val: ValueRef) -> ValueRef ---
	IsABinaryOperator         :: proc(Val: ValueRef) -> ValueRef ---
	IsACallInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAIntrinsicInst          :: proc(Val: ValueRef) -> ValueRef ---
	IsADbgInfoIntrinsic       :: proc(Val: ValueRef) -> ValueRef ---
	IsADbgVariableIntrinsic   :: proc(Val: ValueRef) -> ValueRef ---
	IsADbgDeclareInst         :: proc(Val: ValueRef) -> ValueRef ---
	IsADbgLabelInst           :: proc(Val: ValueRef) -> ValueRef ---
	IsAMemIntrinsic           :: proc(Val: ValueRef) -> ValueRef ---
	IsAMemCpyInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAMemMoveInst            :: proc(Val: ValueRef) -> ValueRef ---
	IsAMemSetInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsACmpInst                :: proc(Val: ValueRef) -> ValueRef ---
	IsAFCmpInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAICmpInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAExtractElementInst     :: proc(Val: ValueRef) -> ValueRef ---
	IsAGetElementPtrInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsAInsertElementInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsAInsertValueInst        :: proc(Val: ValueRef) -> ValueRef ---
	IsALandingPadInst         :: proc(Val: ValueRef) -> ValueRef ---
	IsAPHINode                :: proc(Val: ValueRef) -> ValueRef ---
	IsASelectInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAShuffleVectorInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsAStoreInst              :: proc(Val: ValueRef) -> ValueRef ---
	IsABranchInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAIndirectBrInst         :: proc(Val: ValueRef) -> ValueRef ---
	IsAInvokeInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAReturnInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsASwitchInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAUnreachableInst        :: proc(Val: ValueRef) -> ValueRef ---
	IsAResumeInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsACleanupReturnInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsACatchReturnInst        :: proc(Val: ValueRef) -> ValueRef ---
	IsACatchSwitchInst        :: proc(Val: ValueRef) -> ValueRef ---
	IsACallBrInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAFuncletPadInst         :: proc(Val: ValueRef) -> ValueRef ---
	IsACatchPadInst           :: proc(Val: ValueRef) -> ValueRef ---
	IsACleanupPadInst         :: proc(Val: ValueRef) -> ValueRef ---
	IsAUnaryInstruction       :: proc(Val: ValueRef) -> ValueRef ---
	IsAAllocaInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsACastInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAAddrSpaceCastInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsABitCastInst            :: proc(Val: ValueRef) -> ValueRef ---
	IsAFPExtInst              :: proc(Val: ValueRef) -> ValueRef ---
	IsAFPToSIInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAFPToUIInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAFPTruncInst            :: proc(Val: ValueRef) -> ValueRef ---
	IsAIntToPtrInst           :: proc(Val: ValueRef) -> ValueRef ---
	IsAPtrToIntInst           :: proc(Val: ValueRef) -> ValueRef ---
	IsASExtInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsASIToFPInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsATruncInst              :: proc(Val: ValueRef) -> ValueRef ---
	IsAUIToFPInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAZExtInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAExtractValueInst       :: proc(Val: ValueRef) -> ValueRef ---
	IsALoadInst               :: proc(Val: ValueRef) -> ValueRef ---
	IsAVAArgInst              :: proc(Val: ValueRef) -> ValueRef ---
	IsAFreezeInst             :: proc(Val: ValueRef) -> ValueRef ---
	IsAAtomicCmpXchgInst      :: proc(Val: ValueRef) -> ValueRef ---
	IsAAtomicRMWInst          :: proc(Val: ValueRef) -> ValueRef ---
	IsAFenceInst              :: proc(Val: ValueRef) -> ValueRef ---
	IsAMDNode                 :: proc(Val: ValueRef) -> ValueRef ---
	IsAValueAsMetadata        :: proc(Val: ValueRef) -> ValueRef ---
	IsAMDString               :: proc(Val: ValueRef) -> ValueRef ---

	/** Deprecated: Use LLVMGetValueName2 instead. */
	GetValueName :: proc(Val: ValueRef) -> cstring ---

	/** Deprecated: Use LLVMSetValueName2 instead. */
	SetValueName :: proc(Val: ValueRef, Name: cstring) ---

	/**
	* Obtain the first use of a value.
	*
	* Uses are obtained in an iterator fashion. First, call this function
	* to obtain a reference to the first use. Then, call LLVMGetNextUse()
	* on that instance and all subsequently obtained instances until
	* LLVMGetNextUse() returns NULL.
	*
	* @see llvm::Value::use_begin()
	*/
	GetFirstUse :: proc(Val: ValueRef) -> UseRef ---

	/**
	* Obtain the next use of a value.
	*
	* This effectively advances the iterator. It returns NULL if you are on
	* the final use and no more are available.
	*/
	GetNextUse :: proc(U: UseRef) -> UseRef ---

	/**
	* Obtain the user value for a user.
	*
	* The returned value corresponds to a llvm::User type.
	*
	* @see llvm::Use::getUser()
	*/
	GetUser :: proc(U: UseRef) -> ValueRef ---

	/**
	* Obtain the value this use corresponds to.
	*
	* @see llvm::Use::get().
	*/
	GetUsedValue :: proc(U: UseRef) -> ValueRef ---

	/**
	* Obtain an operand at a specific index in a llvm::User value.
	*
	* @see llvm::User::getOperand()
	*/
	GetOperand :: proc(Val: ValueRef, Index: u32) -> ValueRef ---

	/**
	* Obtain the use of an operand at a specific index in a llvm::User value.
	*
	* @see llvm::User::getOperandUse()
	*/
	GetOperandUse :: proc(Val: ValueRef, Index: u32) -> UseRef ---

	/**
	* Set an operand at a specific index in a llvm::User value.
	*
	* @see llvm::User::setOperand()
	*/
	SetOperand :: proc(User: ValueRef, Index: u32, Val: ValueRef) ---

	/**
	* Obtain the number of operands in a llvm::User value.
	*
	* @see llvm::User::getNumOperands()
	*/
	GetNumOperands :: proc(Val: ValueRef) -> i32 ---

	/**
	* Obtain a constant value referring to the null instance of a type.
	*
	* @see llvm::Constant::getNullValue()
	*/
	ConstNull :: proc(Ty: TypeRef /* all zeroes */) -> ValueRef --- /* all zeroes */

	/**
	* Obtain a constant value referring to the instance of a type
	* consisting of all ones.
	*
	* This is only valid for integer types.
	*
	* @see llvm::Constant::getAllOnesValue()
	*/
	ConstAllOnes :: proc(Ty: TypeRef) -> ValueRef ---

	/**
	* Obtain a constant value referring to an undefined value of a type.
	*
	* @see llvm::UndefValue::get()
	*/
	GetUndef :: proc(Ty: TypeRef) -> ValueRef ---

	/**
	* Obtain a constant value referring to a poison value of a type.
	*
	* @see llvm::PoisonValue::get()
	*/
	GetPoison :: proc(Ty: TypeRef) -> ValueRef ---

	/**
	* Determine whether a value instance is null.
	*
	* @see llvm::Constant::isNullValue()
	*/
	IsNull :: proc(Val: ValueRef) -> Bool ---

	/**
	* Obtain a constant that is a constant pointer pointing to NULL for a
	* specified type.
	*/
	ConstPointerNull :: proc(Ty: TypeRef) -> ValueRef ---

	/**
	* Obtain a constant value for an integer type.
	*
	* The returned value corresponds to a llvm::ConstantInt.
	*
	* @see llvm::ConstantInt::get()
	*
	* @param IntTy Integer type to obtain value of.
	* @param N The value the returned instance should refer to.
	* @param SignExtend Whether to sign extend the produced value.
	*/
	ConstInt :: proc(IntTy: TypeRef, N: u64, SignExtend: Bool) -> ValueRef ---

	/**
	* Obtain a constant value for an integer of arbitrary precision.
	*
	* @see llvm::ConstantInt::get()
	*/
	ConstIntOfArbitraryPrecision :: proc(IntTy: TypeRef, NumWords: u32, Words: [^]u64) -> ValueRef ---

	/**
	* Obtain a constant value for an integer parsed from a string.
	*
	* A similar API, LLVMConstIntOfStringAndSize is also available. If the
	* string's length is available, it is preferred to call that function
	* instead.
	*
	* @see llvm::ConstantInt::get()
	*/
	ConstIntOfString :: proc(IntTy: TypeRef, Text: cstring, Radix: u8) -> ValueRef ---

	/**
	* Obtain a constant value for an integer parsed from a string with
	* specified length.
	*
	* @see llvm::ConstantInt::get()
	*/
	ConstIntOfStringAndSize :: proc(IntTy: TypeRef, Text: cstring, SLen: u32, Radix: u8) -> ValueRef ---

	/**
	* Obtain a constant value referring to a double floating point value.
	*/
	ConstReal :: proc(RealTy: TypeRef, N: f64) -> ValueRef ---

	/**
	* Obtain a constant for a floating point value parsed from a string.
	*
	* A similar API, LLVMConstRealOfStringAndSize is also available. It
	* should be used if the input string's length is known.
	*/
	ConstRealOfString :: proc(RealTy: TypeRef, Text: cstring) -> ValueRef ---

	/**
	* Obtain a constant for a floating point value parsed from a string.
	*/
	ConstRealOfStringAndSize :: proc(RealTy: TypeRef, Text: cstring, SLen: u32) -> ValueRef ---

	/**
	* Obtain a constant for a floating point value from array of 64 bit values.
	* The length of the array N must be ceildiv(bits, 64), where bits is the
	* scalar size in bits of the floating-point type.
	*/
	ConstFPFromBits :: proc(Ty: TypeRef, N: [^]u64) -> ValueRef ---

	/**
	* Obtain the zero extended value for an integer constant value.
	*
	* @see llvm::ConstantInt::getZExtValue()
	*/
	ConstIntGetZExtValue :: proc(ConstantVal: ValueRef) -> u64 ---

	/**
	* Obtain the sign extended value for an integer constant value.
	*
	* @see llvm::ConstantInt::getSExtValue()
	*/
	ConstIntGetSExtValue :: proc(ConstantVal: ValueRef) -> i64 ---

	/**
	* Obtain the double value for an floating point constant value.
	* losesInfo indicates if some precision was lost in the conversion.
	*
	* @see llvm::ConstantFP::getDoubleValue
	*/
	ConstRealGetDouble :: proc(ConstantVal: ValueRef, losesInfo: ^Bool) -> f64 ---

	/**
	* Create a ConstantDataSequential and initialize it with a string.
	*
	* @deprecated LLVMConstStringInContext is deprecated in favor of the API
	* accurate LLVMConstStringInContext2
	* @see llvm::ConstantDataArray::getString()
	*/
	ConstStringInContext :: proc(C: ContextRef, Str: cstring, Length: u32, DontNullTerminate: Bool) -> ValueRef ---

	/**
	* Create a ConstantDataSequential and initialize it with a string.
	*
	* @see llvm::ConstantDataArray::getString()
	*/
	ConstStringInContext2 :: proc(C: ContextRef, Str: cstring, Length: c.size_t, DontNullTerminate: Bool) -> ValueRef ---

	/**
	* Create a ConstantDataSequential with string content in the global context.
	*
	* This is the same as LLVMConstStringInContext except it operates on the
	* global context.
	*
	* @see LLVMConstStringInContext()
	* @see llvm::ConstantDataArray::getString()
	*/
	ConstString :: proc(Str: cstring, Length: u32, DontNullTerminate: Bool) -> ValueRef ---

	/**
	* Returns true if the specified constant is an array of i8.
	*
	* @see ConstantDataSequential::getAsString()
	*/
	IsConstantString :: proc(_c: ValueRef) -> Bool ---

	/**
	* Get the given constant data sequential as a string.
	*
	* @see ConstantDataSequential::getAsString()
	*/
	GetAsString :: proc(_c: ValueRef, Length: ^c.size_t) -> cstring ---

	/**
	* Get the raw, underlying bytes of the given constant data sequential.
	*
	* This is the same as LLVMGetAsString except it works for all constant data
	* sequentials, not just i8 arrays.
	*
	* @see ConstantDataSequential::getRawDataValues()
	*/
	GetRawDataValues :: proc(_c: ValueRef, SizeInBytes: ^c.size_t) -> cstring ---

	/**
	* Create an anonymous ConstantStruct with the specified values.
	*
	* @see llvm::ConstantStruct::getAnon()
	*/
	ConstStructInContext :: proc(C: ContextRef, ConstantVals: ^ValueRef, Count: u32, Packed: Bool) -> ValueRef ---

	/**
	* Create a ConstantStruct in the global Context.
	*
	* This is the same as LLVMConstStructInContext except it operates on the
	* global Context.
	*
	* @see LLVMConstStructInContext()
	*/
	ConstStruct :: proc(ConstantVals: ^ValueRef, Count: u32, Packed: Bool) -> ValueRef ---

	/**
	* Create a ConstantArray from values.
	*
	* @deprecated LLVMConstArray is deprecated in favor of the API accurate
	* LLVMConstArray2
	* @see llvm::ConstantArray::get()
	*/
	ConstArray :: proc(ElementTy: TypeRef, ConstantVals: ^ValueRef, Length: u32) -> ValueRef ---

	/**
	* Create a ConstantArray from values.
	*
	* @see llvm::ConstantArray::get()
	*/
	ConstArray2 :: proc(ElementTy: TypeRef, ConstantVals: ^ValueRef, Length: u64) -> ValueRef ---

	/**
	* Create a ConstantDataArray from raw values.
	*
	* ElementTy must be one of i8, i16, i32, i64, half, bfloat, float, or double.
	* Data points to a contiguous buffer of raw values in the host endianness. The
	* element count is inferred from the element type and the data size in bytes.
	*
	* @see llvm::ConstantDataArray::getRaw()
	*/
	ConstDataArray :: proc(ElementTy: TypeRef, Data: cstring, SizeInBytes: c.size_t) -> ValueRef ---

	/**
	* Create a non-anonymous ConstantStruct from values.
	*
	* @see llvm::ConstantStruct::get()
	*/
	ConstNamedStruct :: proc(StructTy: TypeRef, ConstantVals: ^ValueRef, Count: u32) -> ValueRef ---

	/**
	* Get element of a constant aggregate (struct, array or vector) at the
	* specified index. Returns null if the index is out of range, or it's not
	* possible to determine the element (e.g., because the constant is a
	* constant expression.)
	*
	* @see llvm::Constant::getAggregateElement()
	*/
	GetAggregateElement :: proc(C: ValueRef, Idx: u32) -> ValueRef ---

	/**
	* Get an element at specified index as a constant.
	*
	* @see ConstantDataSequential::getElementAsConstant()
	*/
	GetElementAsConstant :: proc(C: ValueRef, idx: u32) -> ValueRef ---

	/**
	* Create a ConstantVector from values.
	*
	* @see llvm::ConstantVector::get()
	*/
	ConstVector :: proc(ScalarConstantVals: ^ValueRef, Size: u32) -> ValueRef ---

	/**
	* Create a ConstantPtrAuth constant with the given values.
	*
	* @see llvm::ConstantPtrAuth::get()
	*/
	ConstantPtrAuth :: proc(Ptr: ValueRef, Key: ValueRef, Disc: ValueRef, AddrDisc: ValueRef) -> ValueRef ---

	/**
	* @defgroup LLVMCCoreValueConstantExpressions Constant Expressions
	*
	* Functions in this group correspond to APIs on llvm::ConstantExpr.
	*
	* @see llvm::ConstantExpr.
	*
	* @{
	*/
	GetConstOpcode    :: proc(ConstantVal: ValueRef) -> Opcode ---
	AlignOf           :: proc(Ty: TypeRef) -> ValueRef ---
	SizeOf            :: proc(Ty: TypeRef) -> ValueRef ---
	ConstNeg          :: proc(ConstantVal: ValueRef) -> ValueRef ---
	ConstNSWNeg       :: proc(ConstantVal: ValueRef) -> ValueRef ---
	ConstNUWNeg       :: proc(ConstantVal: ValueRef) -> ValueRef ---
	ConstNot          :: proc(ConstantVal: ValueRef) -> ValueRef ---
	ConstAdd          :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstNSWAdd       :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstNUWAdd       :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstSub          :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstNSWSub       :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstNUWSub       :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstXor          :: proc(LHSConstant: ValueRef, RHSConstant: ValueRef) -> ValueRef ---
	ConstGEP2         :: proc(Ty: TypeRef, ConstantVal: ValueRef, ConstantIndices: ^ValueRef, NumIndices: u32) -> ValueRef ---
	ConstInBoundsGEP2 :: proc(Ty: TypeRef, ConstantVal: ValueRef, ConstantIndices: ^ValueRef, NumIndices: u32) -> ValueRef ---

	/**
	* Creates a constant GetElementPtr expression. Similar to LLVMConstGEP2, but
	* allows specifying the no-wrap flags.
	*
	* @see llvm::ConstantExpr::getGetElementPtr()
	*/
	ConstGEPWithNoWrapFlags :: proc(Ty: TypeRef, ConstantVal: ValueRef, ConstantIndices: ^ValueRef, NumIndices: u32, NoWrapFlags: GEPNoWrapFlags) -> ValueRef ---
	ConstTrunc              :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstPtrToInt           :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstIntToPtr           :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstBitCast            :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstAddrSpaceCast      :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstTruncOrBitCast     :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstPointerCast        :: proc(ConstantVal: ValueRef, ToType: TypeRef) -> ValueRef ---
	ConstExtractElement     :: proc(VectorConstant: ValueRef, IndexConstant: ValueRef) -> ValueRef ---
	ConstInsertElement      :: proc(VectorConstant: ValueRef, ElementValueConstant: ValueRef, IndexConstant: ValueRef) -> ValueRef ---
	ConstShuffleVector      :: proc(VectorAConstant: ValueRef, VectorBConstant: ValueRef, MaskConstant: ValueRef) -> ValueRef ---
	BlockAddress            :: proc(F: ValueRef, BB: BasicBlockRef) -> ValueRef ---

	/**
	* Gets the function associated with a given BlockAddress constant value.
	*/
	GetBlockAddressFunction :: proc(BlockAddr: ValueRef) -> ValueRef ---

	/**
	* Gets the basic block associated with a given BlockAddress constant value.
	*/
	GetBlockAddressBasicBlock :: proc(BlockAddr: ValueRef) -> BasicBlockRef ---

	/** Deprecated: Use LLVMGetInlineAsm instead. */
	ConstInlineAsm :: proc(Ty: TypeRef, AsmString: cstring, Constraints: cstring, HasSideEffects: Bool, IsAlignStack: Bool) -> ValueRef ---

	/**
	* @defgroup LLVMCCoreValueConstantGlobals Global Values
	*
	* This group contains functions that operate on global values. Functions in
	* this group relate to functions in the llvm::GlobalValue class tree.
	*
	* @see llvm::GlobalValue
	*
	* @{
	*/
	GetGlobalParent    :: proc(Global: ValueRef) -> ModuleRef ---
	IsDeclaration      :: proc(Global: ValueRef) -> Bool ---
	GetLinkage         :: proc(Global: ValueRef) -> Linkage ---
	SetLinkage         :: proc(Global: ValueRef, Linkage: Linkage) ---
	GetSection         :: proc(Global: ValueRef) -> cstring ---
	SetSection         :: proc(Global: ValueRef, Section: cstring) ---
	GetVisibility      :: proc(Global: ValueRef) -> Visibility ---
	SetVisibility      :: proc(Global: ValueRef, Viz: Visibility) ---
	GetDLLStorageClass :: proc(Global: ValueRef) -> DLLStorageClass ---
	SetDLLStorageClass :: proc(Global: ValueRef, Class: DLLStorageClass) ---
	GetUnnamedAddress  :: proc(Global: ValueRef) -> UnnamedAddr ---
	SetUnnamedAddress  :: proc(Global: ValueRef, UnnamedAddr: UnnamedAddr) ---

	/**
	* Returns the "value type" of a global value.  This differs from the formal
	* type of a global value which is always a pointer type.
	*
	* @see llvm::GlobalValue::getValueType()
	* @see llvm::Function::getFunctionType()
	*/
	GlobalGetValueType :: proc(Global: ValueRef) -> TypeRef ---

	/** Deprecated: Use LLVMGetUnnamedAddress instead. */
	HasUnnamedAddr :: proc(Global: ValueRef) -> Bool ---

	/** Deprecated: Use LLVMSetUnnamedAddress instead. */
	SetUnnamedAddr :: proc(Global: ValueRef, HasUnnamedAddr: Bool) ---

	/**
	* Obtain the preferred alignment of the value.
	* @see llvm::AllocaInst::getAlignment()
	* @see llvm::LoadInst::getAlignment()
	* @see llvm::StoreInst::getAlignment()
	* @see llvm::AtomicRMWInst::setAlignment()
	* @see llvm::AtomicCmpXchgInst::setAlignment()
	* @see llvm::GlobalValue::getAlignment()
	*/
	GetAlignment :: proc(V: ValueRef) -> u32 ---

	/**
	* Set the preferred alignment of the value.
	* @see llvm::AllocaInst::setAlignment()
	* @see llvm::LoadInst::setAlignment()
	* @see llvm::StoreInst::setAlignment()
	* @see llvm::AtomicRMWInst::setAlignment()
	* @see llvm::AtomicCmpXchgInst::setAlignment()
	* @see llvm::GlobalValue::setAlignment()
	*/
	SetAlignment :: proc(V: ValueRef, Bytes: u32) ---

	/**
	* Sets a metadata attachment, erasing the existing metadata attachment if
	* it already exists for the given kind.
	*
	* @see llvm::GlobalObject::setMetadata()
	*/
	GlobalSetMetadata :: proc(Global: ValueRef, Kind: u32, MD: MetadataRef) ---

	/**
	* Adds a metadata attachment.
	*
	* @see llvm::GlobalObject::addMetadata()
	*/
	GlobalAddMetadata :: proc(Global: ValueRef, Kind: u32, MD: MetadataRef) ---

	/**
	* Erases a metadata attachment of the given kind if it exists.
	*
	* @see llvm::GlobalObject::eraseMetadata()
	*/
	GlobalEraseMetadata :: proc(Global: ValueRef, Kind: u32) ---

	/**
	* Removes all metadata attachments from this value.
	*
	* @see llvm::GlobalObject::clearMetadata()
	*/
	GlobalClearMetadata :: proc(Global: ValueRef) ---

	/**
	* Add debuginfo metadata to this global.
	*
	* @see llvm::GlobalVariable::addDebugInfo()
	*/
	GlobalAddDebugInfo :: proc(Global: ValueRef, GVE: MetadataRef) ---

	/**
	* Retrieves an array of metadata entries representing the metadata attached to
	* this value. The caller is responsible for freeing this array by calling
	* \c LLVMDisposeValueMetadataEntries.
	*
	* @see llvm::GlobalObject::getAllMetadata()
	*/
	GlobalCopyAllMetadata :: proc(Value: ValueRef, NumEntries: ^c.size_t) -> ^ValueMetadataEntry ---

	/**
	* Destroys value metadata entries.
	*/
	DisposeValueMetadataEntries :: proc(Entries: ^ValueMetadataEntry) ---

	/**
	* Returns the kind of a value metadata entry at a specific index.
	*/
	ValueMetadataEntriesGetKind :: proc(Entries: ^ValueMetadataEntry, Index: u32) -> u32 ---

	/**
	* Returns the underlying metadata node of a value metadata entry at a
	* specific index.
	*/
	ValueMetadataEntriesGetMetadata :: proc(Entries: ^ValueMetadataEntry, Index: u32) -> MetadataRef ---

	/**
	* @defgroup LLVMCoreValueConstantGlobalVariable Global Variables
	*
	* This group contains functions that operate on global variable values.
	*
	* @see llvm::GlobalVariable
	*
	* @{
	*/
	AddGlobal                :: proc(M: ModuleRef, Ty: TypeRef, Name: cstring) -> ValueRef ---
	AddGlobalInAddressSpace  :: proc(M: ModuleRef, Ty: TypeRef, Name: cstring, AddressSpace: u32) -> ValueRef ---
	GetNamedGlobal           :: proc(M: ModuleRef, Name: cstring) -> ValueRef ---
	GetNamedGlobalWithLength :: proc(M: ModuleRef, Name: cstring, Length: c.size_t) -> ValueRef ---
	GetFirstGlobal           :: proc(M: ModuleRef) -> ValueRef ---
	GetLastGlobal            :: proc(M: ModuleRef) -> ValueRef ---
	GetNextGlobal            :: proc(GlobalVar: ValueRef) -> ValueRef ---
	GetPreviousGlobal        :: proc(GlobalVar: ValueRef) -> ValueRef ---
	DeleteGlobal             :: proc(GlobalVar: ValueRef) ---
	GetInitializer           :: proc(GlobalVar: ValueRef) -> ValueRef ---
	SetInitializer           :: proc(GlobalVar: ValueRef, ConstantVal: ValueRef) ---
	IsThreadLocal            :: proc(GlobalVar: ValueRef) -> Bool ---
	SetThreadLocal           :: proc(GlobalVar: ValueRef, IsThreadLocal: Bool) ---
	IsGlobalConstant         :: proc(GlobalVar: ValueRef) -> Bool ---
	SetGlobalConstant        :: proc(GlobalVar: ValueRef, IsConstant: Bool) ---
	GetThreadLocalMode       :: proc(GlobalVar: ValueRef) -> ThreadLocalMode ---
	SetThreadLocalMode       :: proc(GlobalVar: ValueRef, Mode: ThreadLocalMode) ---
	IsExternallyInitialized  :: proc(GlobalVar: ValueRef) -> Bool ---
	SetExternallyInitialized :: proc(GlobalVar: ValueRef, IsExtInit: Bool) ---

	/**
	* Add a GlobalAlias with the given value type, address space and aliasee.
	*
	* @see llvm::GlobalAlias::create()
	*/
	AddAlias2 :: proc(M: ModuleRef, ValueTy: TypeRef, AddrSpace: u32, Aliasee: ValueRef, Name: cstring) -> ValueRef ---

	/**
	* Obtain a GlobalAlias value from a Module by its name.
	*
	* The returned value corresponds to a llvm::GlobalAlias value.
	*
	* @see llvm::Module::getNamedAlias()
	*/
	GetNamedGlobalAlias :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t) -> ValueRef ---

	/**
	* Obtain an iterator to the first GlobalAlias in a Module.
	*
	* @see llvm::Module::alias_begin()
	*/
	GetFirstGlobalAlias :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Obtain an iterator to the last GlobalAlias in a Module.
	*
	* @see llvm::Module::alias_end()
	*/
	GetLastGlobalAlias :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Advance a GlobalAlias iterator to the next GlobalAlias.
	*
	* Returns NULL if the iterator was already at the end and there are no more
	* global aliases.
	*/
	GetNextGlobalAlias :: proc(GA: ValueRef) -> ValueRef ---

	/**
	* Decrement a GlobalAlias iterator to the previous GlobalAlias.
	*
	* Returns NULL if the iterator was already at the beginning and there are
	* no previous global aliases.
	*/
	GetPreviousGlobalAlias :: proc(GA: ValueRef) -> ValueRef ---

	/**
	* Retrieve the target value of an alias.
	*/
	AliasGetAliasee :: proc(Alias: ValueRef) -> ValueRef ---

	/**
	* Set the target value of an alias.
	*/
	AliasSetAliasee :: proc(Alias: ValueRef, Aliasee: ValueRef) ---

	/**
	* Remove a function from its containing module and deletes it.
	*
	* @see llvm::Function::eraseFromParent()
	*/
	DeleteFunction :: proc(Fn: ValueRef) ---

	/**
	* Check whether the given function has a personality function.
	*
	* @see llvm::Function::hasPersonalityFn()
	*/
	HasPersonalityFn :: proc(Fn: ValueRef) -> Bool ---

	/**
	* Obtain the personality function attached to the function.
	*
	* @see llvm::Function::getPersonalityFn()
	*/
	GetPersonalityFn :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Set the personality function attached to the function.
	*
	* @see llvm::Function::setPersonalityFn()
	*/
	SetPersonalityFn :: proc(Fn: ValueRef, PersonalityFn: ValueRef) ---

	/**
	* Obtain the intrinsic ID number which matches the given function name.
	*
	* @see llvm::Intrinsic::lookupIntrinsicID()
	*/
	LookupIntrinsicID :: proc(Name: cstring, NameLen: c.size_t) -> u32 ---

	/**
	* Obtain the ID number from a function instance.
	*
	* @see llvm::Function::getIntrinsicID()
	*/
	GetIntrinsicID :: proc(Fn: ValueRef) -> u32 ---

	/**
	* Get or insert the declaration of an intrinsic.  For overloaded intrinsics,
	* parameter types must be provided to uniquely identify an overload.
	*
	* @see llvm::Intrinsic::getOrInsertDeclaration()
	*/
	GetIntrinsicDeclaration :: proc(Mod: ModuleRef, ID: u32, ParamTypes: ^TypeRef, ParamCount: c.size_t) -> ValueRef ---

	/**
	* Retrieves the type of an intrinsic.  For overloaded intrinsics, parameter
	* types must be provided to uniquely identify an overload.
	*
	* @see llvm::Intrinsic::getType()
	*/
	IntrinsicGetType :: proc(Ctx: ContextRef, ID: u32, ParamTypes: ^TypeRef, ParamCount: c.size_t) -> TypeRef ---

	/**
	* Retrieves the name of an intrinsic.
	*
	* @see llvm::Intrinsic::getName()
	*/
	IntrinsicGetName :: proc(ID: u32, NameLength: ^c.size_t) -> cstring ---

	/** Deprecated: Use LLVMIntrinsicCopyOverloadedName2 instead. */
	IntrinsicCopyOverloadedName :: proc(ID: u32, ParamTypes: ^TypeRef, ParamCount: c.size_t, NameLength: ^c.size_t) -> cstring ---

	/**
	* Copies the name of an overloaded intrinsic identified by a given list of
	* parameter types.
	*
	* Unlike LLVMIntrinsicGetName, the caller is responsible for freeing the
	* returned string.
	*
	* This version also supports unnamed types.
	*
	* @see llvm::Intrinsic::getName()
	*/
	IntrinsicCopyOverloadedName2 :: proc(Mod: ModuleRef, ID: u32, ParamTypes: ^TypeRef, ParamCount: c.size_t, NameLength: ^c.size_t) -> cstring ---

	/**
	* Obtain if the intrinsic identified by the given ID is overloaded.
	*
	* @see llvm::Intrinsic::isOverloaded()
	*/
	IntrinsicIsOverloaded :: proc(ID: u32) -> Bool ---

	/**
	* Obtain the calling function of a function.
	*
	* The returned value corresponds to the LLVMCallConv enumeration.
	*
	* @see llvm::Function::getCallingConv()
	*/
	GetFunctionCallConv :: proc(Fn: ValueRef) -> u32 ---

	/**
	* Set the calling convention of a function.
	*
	* @see llvm::Function::setCallingConv()
	*
	* @param Fn Function to operate on
	* @param CC LLVMCallConv to set calling convention to
	*/
	SetFunctionCallConv :: proc(Fn: ValueRef, CC: u32) ---

	/**
	* Obtain the name of the garbage collector to use during code
	* generation.
	*
	* @see llvm::Function::getGC()
	*/
	GetGC :: proc(Fn: ValueRef) -> cstring ---

	/**
	* Define the garbage collector to use during code generation.
	*
	* @see llvm::Function::setGC()
	*/
	SetGC :: proc(Fn: ValueRef, Name: cstring) ---

	/**
	* Gets the prefix data associated with a function. Only valid on functions, and
	* only if LLVMHasPrefixData returns true.
	* See https://llvm.org/docs/LangRef.html#prefix-data
	*/
	GetPrefixData :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Check if a given function has prefix data. Only valid on functions.
	* See https://llvm.org/docs/LangRef.html#prefix-data
	*/
	HasPrefixData :: proc(Fn: ValueRef) -> Bool ---

	/**
	* Sets the prefix data for the function. Only valid on functions.
	* See https://llvm.org/docs/LangRef.html#prefix-data
	*/
	SetPrefixData :: proc(Fn: ValueRef, prefixData: ValueRef) ---

	/**
	* Gets the prologue data associated with a function. Only valid on functions,
	* and only if LLVMHasPrologueData returns true.
	* See https://llvm.org/docs/LangRef.html#prologue-data
	*/
	GetPrologueData :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Check if a given function has prologue data. Only valid on functions.
	* See https://llvm.org/docs/LangRef.html#prologue-data
	*/
	HasPrologueData :: proc(Fn: ValueRef) -> Bool ---

	/**
	* Sets the prologue data for the function. Only valid on functions.
	* See https://llvm.org/docs/LangRef.html#prologue-data
	*/
	SetPrologueData :: proc(Fn: ValueRef, prologueData: ValueRef) ---

	/**
	* Add an attribute to a function.
	*
	* @see llvm::Function::addAttribute()
	*/
	AddAttributeAtIndex          :: proc(F: ValueRef, Idx: AttributeIndex, A: AttributeRef) ---
	GetAttributeCountAtIndex     :: proc(F: ValueRef, Idx: AttributeIndex) -> u32 ---
	GetAttributesAtIndex         :: proc(F: ValueRef, Idx: AttributeIndex, Attrs: ^AttributeRef) ---
	GetEnumAttributeAtIndex      :: proc(F: ValueRef, Idx: AttributeIndex, KindID: u32) -> AttributeRef ---
	GetStringAttributeAtIndex    :: proc(F: ValueRef, Idx: AttributeIndex, K: cstring, KLen: u32) -> AttributeRef ---
	RemoveEnumAttributeAtIndex   :: proc(F: ValueRef, Idx: AttributeIndex, KindID: u32) ---
	RemoveStringAttributeAtIndex :: proc(F: ValueRef, Idx: AttributeIndex, K: cstring, KLen: u32) ---

	/**
	* Add a target-dependent attribute to a function
	* @see llvm::AttrBuilder::addAttribute()
	*/
	AddTargetDependentFunctionAttr :: proc(Fn: ValueRef, A: cstring, V: cstring) ---

	/**
	* Obtain the number of parameters in a function.
	*
	* @see llvm::Function::arg_size()
	*/
	CountParams :: proc(Fn: ValueRef) -> u32 ---

	/**
	* Obtain the parameters in a function.
	*
	* The takes a pointer to a pre-allocated array of LLVMValueRef that is
	* at least LLVMCountParams() long. This array will be filled with
	* LLVMValueRef instances which correspond to the parameters the
	* function receives. Each LLVMValueRef corresponds to a llvm::Argument
	* instance.
	*
	* @see llvm::Function::arg_begin()
	*/
	GetParams :: proc(Fn: ValueRef, Params: ^ValueRef) ---

	/**
	* Obtain the parameter at the specified index.
	*
	* Parameters are indexed from 0.
	*
	* @see llvm::Function::arg_begin()
	*/
	GetParam :: proc(Fn: ValueRef, Index: u32) -> ValueRef ---

	/**
	* Obtain the function to which this argument belongs.
	*
	* Unlike other functions in this group, this one takes an LLVMValueRef
	* that corresponds to a llvm::Attribute.
	*
	* The returned LLVMValueRef is the llvm::Function to which this
	* argument belongs.
	*/
	GetParamParent :: proc(Inst: ValueRef) -> ValueRef ---

	/**
	* Obtain the first parameter to a function.
	*
	* @see llvm::Function::arg_begin()
	*/
	GetFirstParam :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Obtain the last parameter to a function.
	*
	* @see llvm::Function::arg_end()
	*/
	GetLastParam :: proc(Fn: ValueRef) -> ValueRef ---

	/**
	* Obtain the next parameter to a function.
	*
	* This takes an LLVMValueRef obtained from LLVMGetFirstParam() (which is
	* actually a wrapped iterator) and obtains the next parameter from the
	* underlying iterator.
	*/
	GetNextParam :: proc(Arg: ValueRef) -> ValueRef ---

	/**
	* Obtain the previous parameter to a function.
	*
	* This is the opposite of LLVMGetNextParam().
	*/
	GetPreviousParam :: proc(Arg: ValueRef) -> ValueRef ---

	/**
	* Set the alignment for a function parameter.
	*
	* @see llvm::Argument::addAttr()
	* @see llvm::AttrBuilder::addAlignmentAttr()
	*/
	SetParamAlignment :: proc(Arg: ValueRef, Align: u32) ---

	/**
	* Add a global indirect function to a module under a specified name.
	*
	* @see llvm::GlobalIFunc::create()
	*/
	AddGlobalIFunc :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t, Ty: TypeRef, AddrSpace: u32, Resolver: ValueRef) -> ValueRef ---

	/**
	* Obtain a GlobalIFunc value from a Module by its name.
	*
	* The returned value corresponds to a llvm::GlobalIFunc value.
	*
	* @see llvm::Module::getNamedIFunc()
	*/
	GetNamedGlobalIFunc :: proc(M: ModuleRef, Name: cstring, NameLen: c.size_t) -> ValueRef ---

	/**
	* Obtain an iterator to the first GlobalIFunc in a Module.
	*
	* @see llvm::Module::ifunc_begin()
	*/
	GetFirstGlobalIFunc :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Obtain an iterator to the last GlobalIFunc in a Module.
	*
	* @see llvm::Module::ifunc_end()
	*/
	GetLastGlobalIFunc :: proc(M: ModuleRef) -> ValueRef ---

	/**
	* Advance a GlobalIFunc iterator to the next GlobalIFunc.
	*
	* Returns NULL if the iterator was already at the end and there are no more
	* global aliases.
	*/
	GetNextGlobalIFunc :: proc(IFunc: ValueRef) -> ValueRef ---

	/**
	* Decrement a GlobalIFunc iterator to the previous GlobalIFunc.
	*
	* Returns NULL if the iterator was already at the beginning and there are
	* no previous global aliases.
	*/
	GetPreviousGlobalIFunc :: proc(IFunc: ValueRef) -> ValueRef ---

	/**
	* Retrieves the resolver function associated with this indirect function, or
	* NULL if it doesn't not exist.
	*
	* @see llvm::GlobalIFunc::getResolver()
	*/
	GetGlobalIFuncResolver :: proc(IFunc: ValueRef) -> ValueRef ---

	/**
	* Sets the resolver function associated with this indirect function.
	*
	* @see llvm::GlobalIFunc::setResolver()
	*/
	SetGlobalIFuncResolver :: proc(IFunc: ValueRef, Resolver: ValueRef) ---

	/**
	* Remove a global indirect function from its parent module and delete it.
	*
	* @see llvm::GlobalIFunc::eraseFromParent()
	*/
	EraseGlobalIFunc :: proc(IFunc: ValueRef) ---

	/**
	* Remove a global indirect function from its parent module.
	*
	* This unlinks the global indirect function from its containing module but
	* keeps it alive.
	*
	* @see llvm::GlobalIFunc::removeFromParent()
	*/
	RemoveGlobalIFunc :: proc(IFunc: ValueRef) ---

	/**
	* Create an MDString value from a given string value.
	*
	* The MDString value does not take ownership of the given string, it remains
	* the responsibility of the caller to free it.
	*
	* @see llvm::MDString::get()
	*/
	MDStringInContext2 :: proc(C: ContextRef, Str: cstring, SLen: c.size_t) -> MetadataRef ---

	/**
	* Create an MDNode value with the given array of operands.
	*
	* @see llvm::MDNode::get()
	*/
	MDNodeInContext2 :: proc(C: ContextRef, MDs: ^MetadataRef, Count: c.size_t) -> MetadataRef ---

	/**
	* Obtain a Metadata as a Value.
	*/
	MetadataAsValue :: proc(C: ContextRef, MD: MetadataRef) -> ValueRef ---

	/**
	* Obtain a Value as a Metadata.
	*/
	ValueAsMetadata :: proc(Val: ValueRef) -> MetadataRef ---

	/**
	* Obtain the underlying string from a MDString value.
	*
	* @param V Instance to obtain string from.
	* @param Length Memory address which will hold length of returned string.
	* @return String data in MDString.
	*/
	GetMDString :: proc(V: ValueRef, Length: ^u32) -> cstring ---

	/**
	* Obtain the number of operands from an MDNode value.
	*
	* @param V MDNode to get number of operands from.
	* @return Number of operands of the MDNode.
	*/
	GetMDNodeNumOperands :: proc(V: ValueRef) -> u32 ---

	/**
	* Obtain the given MDNode's operands.
	*
	* The passed LLVMValueRef pointer should point to enough memory to hold all of
	* the operands of the given MDNode (see LLVMGetMDNodeNumOperands) as
	* LLVMValueRefs. This memory will be populated with the LLVMValueRefs of the
	* MDNode's operands.
	*
	* @param V MDNode to get the operands from.
	* @param Dest Destination array for operands.
	*/
	GetMDNodeOperands :: proc(V: ValueRef, Dest: ^ValueRef) ---

	/**
	* Replace an operand at a specific index in a llvm::MDNode value.
	*
	* @see llvm::MDNode::replaceOperandWith()
	*/
	ReplaceMDNodeOperandWith :: proc(V: ValueRef, Index: u32, Replacement: MetadataRef) ---

	/** Deprecated: Use LLVMMDStringInContext2 instead. */
	MDStringInContext :: proc(C: ContextRef, Str: cstring, SLen: u32) -> ValueRef ---

	/** Deprecated: Use LLVMMDStringInContext2 instead. */
	MDString :: proc(Str: cstring, SLen: u32) -> ValueRef ---

	/** Deprecated: Use LLVMMDNodeInContext2 instead. */
	MDNodeInContext :: proc(C: ContextRef, Vals: ^ValueRef, Count: u32) -> ValueRef ---

	/** Deprecated: Use LLVMMDNodeInContext2 instead. */
	MDNode :: proc(Vals: ^ValueRef, Count: u32) -> ValueRef ---

	/**
	* Create a new operand bundle.
	*
	* Every invocation should be paired with LLVMDisposeOperandBundle() or memory
	* will be leaked.
	*
	* @param Tag Tag name of the operand bundle
	* @param TagLen Length of Tag
	* @param Args Memory address of an array of bundle operands
	* @param NumArgs Length of Args
	*/
	CreateOperandBundle :: proc(Tag: cstring, TagLen: c.size_t, Args: ^ValueRef, NumArgs: u32) -> OperandBundleRef ---

	/**
	* Destroy an operand bundle.
	*
	* This must be called for every created operand bundle or memory will be
	* leaked.
	*/
	DisposeOperandBundle :: proc(Bundle: OperandBundleRef) ---

	/**
	* Obtain the tag of an operand bundle as a string.
	*
	* @param Bundle Operand bundle to obtain tag of.
	* @param Len Out parameter which holds the length of the returned string.
	* @return The tag name of Bundle.
	* @see OperandBundleDef::getTag()
	*/
	GetOperandBundleTag :: proc(Bundle: OperandBundleRef, Len: ^c.size_t) -> cstring ---

	/**
	* Obtain the number of operands for an operand bundle.
	*
	* @param Bundle Operand bundle to obtain operand count of.
	* @return The number of operands.
	* @see OperandBundleDef::input_size()
	*/
	GetNumOperandBundleArgs :: proc(Bundle: OperandBundleRef) -> u32 ---

	/**
	* Obtain the operand for an operand bundle at the given index.
	*
	* @param Bundle Operand bundle to obtain operand of.
	* @param Index An operand index, must be less than
	* LLVMGetNumOperandBundleArgs().
	* @return The operand.
	*/
	GetOperandBundleArgAtIndex :: proc(Bundle: OperandBundleRef, Index: u32) -> ValueRef ---

	/**
	* Convert a basic block instance to a value type.
	*/
	BasicBlockAsValue :: proc(BB: BasicBlockRef) -> ValueRef ---

	/**
	* Determine whether an LLVMValueRef is itself a basic block.
	*/
	ValueIsBasicBlock :: proc(Val: ValueRef) -> Bool ---

	/**
	* Convert an LLVMValueRef to an LLVMBasicBlockRef instance.
	*/
	ValueAsBasicBlock :: proc(Val: ValueRef) -> BasicBlockRef ---

	/**
	* Obtain the string name of a basic block.
	*/
	GetBasicBlockName :: proc(BB: BasicBlockRef) -> cstring ---

	/**
	* Obtain the function to which a basic block belongs.
	*
	* @see llvm::BasicBlock::getParent()
	*/
	GetBasicBlockParent :: proc(BB: BasicBlockRef) -> ValueRef ---

	/**
	* Obtain the terminator instruction for a basic block.
	*
	* If the basic block does not have a terminator (it is not well-formed
	* if it doesn't), then NULL is returned.
	*
	* The returned LLVMValueRef corresponds to an llvm::Instruction.
	*
	* @see llvm::BasicBlock::getTerminator()
	*/
	GetBasicBlockTerminator :: proc(BB: BasicBlockRef) -> ValueRef ---

	/**
	* Obtain the number of basic blocks in a function.
	*
	* @param Fn Function value to operate on.
	*/
	CountBasicBlocks :: proc(Fn: ValueRef) -> u32 ---

	/**
	* Obtain all of the basic blocks in a function.
	*
	* This operates on a function value. The BasicBlocks parameter is a
	* pointer to a pre-allocated array of LLVMBasicBlockRef of at least
	* LLVMCountBasicBlocks() in length. This array is populated with
	* LLVMBasicBlockRef instances.
	*/
	GetBasicBlocks :: proc(Fn: ValueRef, BasicBlocks: ^BasicBlockRef) ---

	/**
	* Obtain the first basic block in a function.
	*
	* The returned basic block can be used as an iterator. You will likely
	* eventually call into LLVMGetNextBasicBlock() with it.
	*
	* @see llvm::Function::begin()
	*/
	GetFirstBasicBlock :: proc(Fn: ValueRef) -> BasicBlockRef ---

	/**
	* Obtain the last basic block in a function.
	*
	* @see llvm::Function::end()
	*/
	GetLastBasicBlock :: proc(Fn: ValueRef) -> BasicBlockRef ---

	/**
	* Advance a basic block iterator.
	*/
	GetNextBasicBlock :: proc(BB: BasicBlockRef) -> BasicBlockRef ---

	/**
	* Go backwards in a basic block iterator.
	*/
	GetPreviousBasicBlock :: proc(BB: BasicBlockRef) -> BasicBlockRef ---

	/**
	* Obtain the basic block that corresponds to the entry point of a
	* function.
	*
	* @see llvm::Function::getEntryBlock()
	*/
	GetEntryBasicBlock :: proc(Fn: ValueRef) -> BasicBlockRef ---

	/**
	* Insert the given basic block after the insertion point of the given builder.
	*
	* The insertion point must be valid.
	*
	* @see llvm::Function::BasicBlockListType::insertAfter()
	*/
	InsertExistingBasicBlockAfterInsertBlock :: proc(Builder: BuilderRef, BB: BasicBlockRef) ---

	/**
	* Append the given basic block to the basic block list of the given function.
	*
	* @see llvm::Function::BasicBlockListType::push_back()
	*/
	AppendExistingBasicBlock :: proc(Fn: ValueRef, BB: BasicBlockRef) ---

	/**
	* Create a new basic block without inserting it into a function.
	*
	* @see llvm::BasicBlock::Create()
	*/
	CreateBasicBlockInContext :: proc(C: ContextRef, Name: cstring) -> BasicBlockRef ---

	/**
	* Append a basic block to the end of a function.
	*
	* @see llvm::BasicBlock::Create()
	*/
	AppendBasicBlockInContext :: proc(C: ContextRef, Fn: ValueRef, Name: cstring) -> BasicBlockRef ---

	/**
	* Append a basic block to the end of a function using the global
	* context.
	*
	* @see llvm::BasicBlock::Create()
	*/
	AppendBasicBlock :: proc(Fn: ValueRef, Name: cstring) -> BasicBlockRef ---

	/**
	* Insert a basic block in a function before another basic block.
	*
	* The function to add to is determined by the function of the
	* passed basic block.
	*
	* @see llvm::BasicBlock::Create()
	*/
	InsertBasicBlockInContext :: proc(C: ContextRef, BB: BasicBlockRef, Name: cstring) -> BasicBlockRef ---

	/**
	* Insert a basic block in a function using the global context.
	*
	* @see llvm::BasicBlock::Create()
	*/
	InsertBasicBlock :: proc(InsertBeforeBB: BasicBlockRef, Name: cstring) -> BasicBlockRef ---

	/**
	* Remove a basic block from a function and delete it.
	*
	* This deletes the basic block from its containing function and deletes
	* the basic block itself.
	*
	* @see llvm::BasicBlock::eraseFromParent()
	*/
	DeleteBasicBlock :: proc(BB: BasicBlockRef) ---

	/**
	* Remove a basic block from a function.
	*
	* This deletes the basic block from its containing function but keep
	* the basic block alive.
	*
	* @see llvm::BasicBlock::removeFromParent()
	*/
	RemoveBasicBlockFromParent :: proc(BB: BasicBlockRef) ---

	/**
	* Move a basic block to before another one.
	*
	* @see llvm::BasicBlock::moveBefore()
	*/
	MoveBasicBlockBefore :: proc(BB: BasicBlockRef, MovePos: BasicBlockRef) ---

	/**
	* Move a basic block to after another one.
	*
	* @see llvm::BasicBlock::moveAfter()
	*/
	MoveBasicBlockAfter :: proc(BB: BasicBlockRef, MovePos: BasicBlockRef) ---

	/**
	* Obtain the first instruction in a basic block.
	*
	* The returned LLVMValueRef corresponds to a llvm::Instruction
	* instance.
	*/
	GetFirstInstruction :: proc(BB: BasicBlockRef) -> ValueRef ---

	/**
	* Obtain the last instruction in a basic block.
	*
	* The returned LLVMValueRef corresponds to an LLVM:Instruction.
	*/
	GetLastInstruction :: proc(BB: BasicBlockRef) -> ValueRef ---

	/**
	* Determine whether an instruction has any metadata attached.
	*/
	HasMetadata :: proc(Val: ValueRef) -> i32 ---

	/**
	* Return metadata associated with an instruction value.
	*/
	GetMetadata :: proc(Val: ValueRef, KindID: u32) -> ValueRef ---

	/**
	* Set metadata associated with an instruction value.
	*/
	SetMetadata :: proc(Val: ValueRef, KindID: u32, Node: ValueRef) ---

	/**
	* Returns the metadata associated with an instruction value, but filters out
	* all the debug locations.
	*
	* @see llvm::Instruction::getAllMetadataOtherThanDebugLoc()
	*/
	InstructionGetAllMetadataOtherThanDebugLoc :: proc(Instr: ValueRef, NumEntries: ^c.size_t) -> ^ValueMetadataEntry ---

	/**
	* Obtain the basic block to which an instruction belongs.
	*
	* @see llvm::Instruction::getParent()
	*/
	GetInstructionParent :: proc(Inst: ValueRef) -> BasicBlockRef ---

	/**
	* Obtain the instruction that occurs after the one specified.
	*
	* The next instruction will be from the same basic block.
	*
	* If this is the last instruction in a basic block, NULL will be
	* returned.
	*/
	GetNextInstruction :: proc(Inst: ValueRef) -> ValueRef ---

	/**
	* Obtain the instruction that occurred before this one.
	*
	* If the instruction is the first instruction in a basic block, NULL
	* will be returned.
	*/
	GetPreviousInstruction :: proc(Inst: ValueRef) -> ValueRef ---

	/**
	* Remove an instruction.
	*
	* The instruction specified is removed from its containing building
	* block but is kept alive.
	*
	* @see llvm::Instruction::removeFromParent()
	*/
	InstructionRemoveFromParent :: proc(Inst: ValueRef) ---

	/**
	* Remove and delete an instruction.
	*
	* The instruction specified is removed from its containing building
	* block and then deleted.
	*
	* @see llvm::Instruction::eraseFromParent()
	*/
	InstructionEraseFromParent :: proc(Inst: ValueRef) ---

	/**
	* Delete an instruction.
	*
	* The instruction specified is deleted. It must have previously been
	* removed from its containing building block.
	*
	* @see llvm::Value::deleteValue()
	*/
	DeleteInstruction :: proc(Inst: ValueRef) ---

	/**
	* Obtain the code opcode for an individual instruction.
	*
	* @see llvm::Instruction::getOpCode()
	*/
	GetInstructionOpcode :: proc(Inst: ValueRef) -> Opcode ---

	/**
	* Obtain the predicate of an instruction.
	*
	* This is only valid for instructions that correspond to llvm::ICmpInst.
	*
	* @see llvm::ICmpInst::getPredicate()
	*/
	GetICmpPredicate :: proc(Inst: ValueRef) -> IntPredicate ---

	/**
	* Get whether or not an icmp instruction has the samesign flag.
	*
	* This is only valid for instructions that correspond to llvm::ICmpInst.
	*
	* @see llvm::ICmpInst::hasSameSign()
	*/
	GetICmpSameSign :: proc(Inst: ValueRef) -> Bool ---

	/**
	* Set the samesign flag on an icmp instruction.
	*
	* This is only valid for instructions that correspond to llvm::ICmpInst.
	*
	* @see llvm::ICmpInst::setSameSign()
	*/
	SetICmpSameSign :: proc(Inst: ValueRef, SameSign: Bool) ---

	/**
	* Obtain the float predicate of an instruction.
	*
	* This is only valid for instructions that correspond to llvm::FCmpInst.
	*
	* @see llvm::FCmpInst::getPredicate()
	*/
	GetFCmpPredicate :: proc(Inst: ValueRef) -> RealPredicate ---

	/**
	* Create a copy of 'this' instruction that is identical in all ways
	* except the following:
	*   * The instruction has no parent
	*   * The instruction has no name
	*
	* @see llvm::Instruction::clone()
	*/
	InstructionClone :: proc(Inst: ValueRef) -> ValueRef ---

	/**
	* Determine whether an instruction is a terminator. This routine is named to
	* be compatible with historical functions that did this by querying the
	* underlying C++ type.
	*
	* @see llvm::Instruction::isTerminator()
	*/
	IsATerminatorInst :: proc(Inst: ValueRef) -> ValueRef ---

	/**
	* Obtain the first debug record attached to an instruction.
	*
	* Use LLVMGetNextDbgRecord() and LLVMGetPreviousDbgRecord() to traverse the
	* sequence of DbgRecords.
	*
	* Return the first DbgRecord attached to Inst or NULL if there are none.
	*
	* @see llvm::Instruction::getDbgRecordRange()
	*/
	GetFirstDbgRecord :: proc(Inst: ValueRef) -> DbgRecordRef ---

	/**
	* Obtain the last debug record attached to an instruction.
	*
	* Return the last DbgRecord attached to Inst or NULL if there are none.
	*
	* @see llvm::Instruction::getDbgRecordRange()
	*/
	GetLastDbgRecord :: proc(Inst: ValueRef) -> DbgRecordRef ---

	/**
	* Obtain the next DbgRecord in the sequence or NULL if there are no more.
	*
	* @see llvm::Instruction::getDbgRecordRange()
	*/
	GetNextDbgRecord :: proc(DbgRecord: DbgRecordRef) -> DbgRecordRef ---

	/**
	* Obtain the previous DbgRecord in the sequence or NULL if there are no more.
	*
	* @see llvm::Instruction::getDbgRecordRange()
	*/
	GetPreviousDbgRecord :: proc(DbgRecord: DbgRecordRef) -> DbgRecordRef ---

	/**
	* Get the debug location attached to the debug record.
	*
	* @see llvm::DbgRecord::getDebugLoc()
	*/
	DbgRecordGetDebugLoc :: proc(Rec: DbgRecordRef) -> MetadataRef ---
	DbgRecordGetKind     :: proc(Rec: DbgRecordRef) -> DbgRecordKind ---

	/**
	* Get the value of the DbgVariableRecord.
	*
	* @see llvm::DbgVariableRecord::getValue()
	*/
	DbgVariableRecordGetValue :: proc(Rec: DbgRecordRef, OpIdx: u32) -> ValueRef ---

	/**
	* Get the debug info variable of the DbgVariableRecord.
	*
	* @see llvm::DbgVariableRecord::getVariable()
	*/
	DbgVariableRecordGetVariable :: proc(Rec: DbgRecordRef) -> MetadataRef ---

	/**
	* Get the debug info expression of the DbgVariableRecord.
	*
	* @see llvm::DbgVariableRecord::getExpression()
	*/
	DbgVariableRecordGetExpression :: proc(Rec: DbgRecordRef) -> MetadataRef ---

	/**
	* Obtain the argument count for a call instruction.
	*
	* This expects an LLVMValueRef that corresponds to a llvm::CallInst,
	* llvm::InvokeInst, or llvm:FuncletPadInst.
	*
	* @see llvm::CallInst::getNumArgOperands()
	* @see llvm::InvokeInst::getNumArgOperands()
	* @see llvm::FuncletPadInst::getNumArgOperands()
	*/
	GetNumArgOperands :: proc(Instr: ValueRef) -> u32 ---

	/**
	* Set the calling convention for a call instruction.
	*
	* This expects an LLVMValueRef that corresponds to a llvm::CallInst or
	* llvm::InvokeInst.
	*
	* @see llvm::CallInst::setCallingConv()
	* @see llvm::InvokeInst::setCallingConv()
	*/
	SetInstructionCallConv :: proc(Instr: ValueRef, CC: u32) ---

	/**
	* Obtain the calling convention for a call instruction.
	*
	* This is the opposite of LLVMSetInstructionCallConv(). Reads its
	* usage.
	*
	* @see LLVMSetInstructionCallConv()
	*/
	GetInstructionCallConv        :: proc(Instr: ValueRef) -> u32 ---
	SetInstrParamAlignment        :: proc(Instr: ValueRef, Idx: AttributeIndex, Align: u32) ---
	AddCallSiteAttribute          :: proc(C: ValueRef, Idx: AttributeIndex, A: AttributeRef) ---
	GetCallSiteAttributeCount     :: proc(C: ValueRef, Idx: AttributeIndex) -> u32 ---
	GetCallSiteAttributes         :: proc(C: ValueRef, Idx: AttributeIndex, Attrs: ^AttributeRef) ---
	GetCallSiteEnumAttribute      :: proc(C: ValueRef, Idx: AttributeIndex, KindID: u32) -> AttributeRef ---
	GetCallSiteStringAttribute    :: proc(C: ValueRef, Idx: AttributeIndex, K: cstring, KLen: u32) -> AttributeRef ---
	RemoveCallSiteEnumAttribute   :: proc(C: ValueRef, Idx: AttributeIndex, KindID: u32) ---
	RemoveCallSiteStringAttribute :: proc(C: ValueRef, Idx: AttributeIndex, K: cstring, KLen: u32) ---

	/**
	* Obtain the function type called by this instruction.
	*
	* @see llvm::CallBase::getFunctionType()
	*/
	GetCalledFunctionType :: proc(C: ValueRef) -> TypeRef ---

	/**
	* Obtain the pointer to the function invoked by this instruction.
	*
	* This expects an LLVMValueRef that corresponds to a llvm::CallInst or
	* llvm::InvokeInst.
	*
	* @see llvm::CallInst::getCalledOperand()
	* @see llvm::InvokeInst::getCalledOperand()
	*/
	GetCalledValue :: proc(Instr: ValueRef) -> ValueRef ---

	/**
	* Obtain the number of operand bundles attached to this instruction.
	*
	* This only works on llvm::CallInst and llvm::InvokeInst instructions.
	*
	* @see llvm::CallBase::getNumOperandBundles()
	*/
	GetNumOperandBundles :: proc(C: ValueRef) -> u32 ---

	/**
	* Obtain the operand bundle attached to this instruction at the given index.
	* Use LLVMDisposeOperandBundle to free the operand bundle.
	*
	* This only works on llvm::CallInst and llvm::InvokeInst instructions.
	*/
	GetOperandBundleAtIndex :: proc(C: ValueRef, Index: u32) -> OperandBundleRef ---

	/**
	* Obtain whether a call instruction is a tail call.
	*
	* This only works on llvm::CallInst instructions.
	*
	* @see llvm::CallInst::isTailCall()
	*/
	IsTailCall :: proc(CallInst: ValueRef) -> Bool ---

	/**
	* Set whether a call instruction is a tail call.
	*
	* This only works on llvm::CallInst instructions.
	*
	* @see llvm::CallInst::setTailCall()
	*/
	SetTailCall :: proc(CallInst: ValueRef, IsTailCall: Bool) ---

	/**
	* Obtain a tail call kind of the call instruction.
	*
	* @see llvm::CallInst::setTailCallKind()
	*/
	GetTailCallKind :: proc(CallInst: ValueRef) -> TailCallKind ---

	/**
	* Set the call kind of the call instruction.
	*
	* @see llvm::CallInst::getTailCallKind()
	*/
	SetTailCallKind :: proc(CallInst: ValueRef, kind: TailCallKind) ---

	/**
	* Return the normal destination basic block.
	*
	* This only works on llvm::InvokeInst instructions.
	*
	* @see llvm::InvokeInst::getNormalDest()
	*/
	GetNormalDest :: proc(InvokeInst: ValueRef) -> BasicBlockRef ---

	/**
	* Return the unwind destination basic block.
	*
	* Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
	* llvm::CatchSwitchInst instructions.
	*
	* @see llvm::InvokeInst::getUnwindDest()
	* @see llvm::CleanupReturnInst::getUnwindDest()
	* @see llvm::CatchSwitchInst::getUnwindDest()
	*/
	GetUnwindDest :: proc(InvokeInst: ValueRef) -> BasicBlockRef ---

	/**
	* Set the normal destination basic block.
	*
	* This only works on llvm::InvokeInst instructions.
	*
	* @see llvm::InvokeInst::setNormalDest()
	*/
	SetNormalDest :: proc(InvokeInst: ValueRef, B: BasicBlockRef) ---

	/**
	* Set the unwind destination basic block.
	*
	* Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
	* llvm::CatchSwitchInst instructions.
	*
	* @see llvm::InvokeInst::setUnwindDest()
	* @see llvm::CleanupReturnInst::setUnwindDest()
	* @see llvm::CatchSwitchInst::setUnwindDest()
	*/
	SetUnwindDest :: proc(InvokeInst: ValueRef, B: BasicBlockRef) ---

	/**
	* Get the default destination of a CallBr instruction.
	*
	* @see llvm::CallBrInst::getDefaultDest()
	*/
	GetCallBrDefaultDest :: proc(CallBr: ValueRef) -> BasicBlockRef ---

	/**
	* Get the number of indirect destinations of a CallBr instruction.
	*
	* @see llvm::CallBrInst::getNumIndirectDests()
	
	*/
	GetCallBrNumIndirectDests :: proc(CallBr: ValueRef) -> u32 ---

	/**
	* Get the indirect destination of a CallBr instruction at the given index.
	*
	* @see llvm::CallBrInst::getIndirectDest()
	*/
	GetCallBrIndirectDest :: proc(CallBr: ValueRef, Idx: u32) -> BasicBlockRef ---

	/**
	* Return the number of successors that this terminator has.
	*
	* @see llvm::Instruction::getNumSuccessors
	*/
	GetNumSuccessors :: proc(Term: ValueRef) -> u32 ---

	/**
	* Return the specified successor.
	*
	* @see llvm::Instruction::getSuccessor
	*/
	GetSuccessor :: proc(Term: ValueRef, i: u32) -> BasicBlockRef ---

	/**
	* Update the specified successor to point at the provided block.
	*
	* @see llvm::Instruction::setSuccessor
	*/
	SetSuccessor :: proc(Term: ValueRef, i: u32, block: BasicBlockRef) ---

	/**
	* Return if a branch is conditional.
	*
	* This only works on llvm::BranchInst instructions.
	*
	* @see llvm::BranchInst::isConditional
	*/
	IsConditional :: proc(Branch: ValueRef) -> Bool ---

	/**
	* Return the condition of a branch instruction.
	*
	* This only works on llvm::BranchInst instructions.
	*
	* @see llvm::BranchInst::getCondition
	*/
	GetCondition :: proc(Branch: ValueRef) -> ValueRef ---

	/**
	* Set the condition of a branch instruction.
	*
	* This only works on llvm::BranchInst instructions.
	*
	* @see llvm::BranchInst::setCondition
	*/
	SetCondition :: proc(Branch: ValueRef, Cond: ValueRef) ---

	/**
	* Obtain the default destination basic block of a switch instruction.
	*
	* This only works on llvm::SwitchInst instructions.
	*
	* @see llvm::SwitchInst::getDefaultDest()
	*/
	GetSwitchDefaultDest :: proc(SwitchInstr: ValueRef) -> BasicBlockRef ---

	/**
	* Obtain the case value for a successor of a switch instruction. i corresponds
	* to the successor index. The first successor is the default destination, so i
	* must be greater than zero.
	*
	* This only works on llvm::SwitchInst instructions.
	*
	* @see llvm::SwitchInst::CaseHandle::getCaseValue()
	*/
	GetSwitchCaseValue :: proc(SwitchInstr: ValueRef, i: u32) -> ValueRef ---

	/**
	* Set the case value for a successor of a switch instruction. i corresponds to
	* the successor index. The first successor is the default destination, so i
	* must be greater than zero.
	*
	* This only works on llvm::SwitchInst instructions.
	*
	* @see llvm::SwitchInst::CaseHandle::setValue()
	*/
	SetSwitchCaseValue :: proc(SwitchInstr: ValueRef, i: u32, CaseValue: ValueRef) ---

	/**
	* Obtain the type that is being allocated by the alloca instruction.
	*/
	GetAllocatedType :: proc(Alloca: ValueRef) -> TypeRef ---

	/**
	* Check whether the given GEP operator is inbounds.
	*/
	IsInBounds :: proc(GEP: ValueRef) -> Bool ---

	/**
	* Set the given GEP instruction to be inbounds or not.
	*/
	SetIsInBounds :: proc(GEP: ValueRef, InBounds: Bool) ---

	/**
	* Get the source element type of the given GEP operator.
	*/
	GetGEPSourceElementType :: proc(GEP: ValueRef) -> TypeRef ---

	/**
	* Get the no-wrap related flags for the given GEP instruction.
	*
	* @see llvm::GetElementPtrInst::getNoWrapFlags
	*/
	GEPGetNoWrapFlags :: proc(GEP: ValueRef) -> GEPNoWrapFlags ---

	/**
	* Set the no-wrap related flags for the given GEP instruction.
	*
	* @see llvm::GetElementPtrInst::setNoWrapFlags
	*/
	GEPSetNoWrapFlags :: proc(GEP: ValueRef, NoWrapFlags: GEPNoWrapFlags) ---

	/**
	* Add an incoming value to the end of a PHI list.
	*/
	AddIncoming :: proc(PhiNode: ValueRef, IncomingValues: ^ValueRef, IncomingBlocks: ^BasicBlockRef, Count: u32) ---

	/**
	* Obtain the number of incoming basic blocks to a PHI node.
	*/
	CountIncoming :: proc(PhiNode: ValueRef) -> u32 ---

	/**
	* Obtain an incoming value to a PHI node as an LLVMValueRef.
	*/
	GetIncomingValue :: proc(PhiNode: ValueRef, Index: u32) -> ValueRef ---

	/**
	* Obtain an incoming value to a PHI node as an LLVMBasicBlockRef.
	*/
	GetIncomingBlock :: proc(PhiNode: ValueRef, Index: u32) -> BasicBlockRef ---

	/**
	* Obtain the number of indices.
	* NB: This also works on GEP operators.
	*/
	GetNumIndices :: proc(Inst: ValueRef) -> u32 ---

	/**
	* Obtain the indices as an array.
	*/
	GetIndices :: proc(Inst: ValueRef) -> ^u32 ---

	/**
	* @defgroup LLVMCCoreInstructionBuilder Instruction Builders
	*
	* An instruction builder represents a point within a basic block and is
	* the exclusive means of building instructions using the C interface.
	*
	* @{
	*/
	CreateBuilderInContext :: proc(C: ContextRef) -> BuilderRef ---
	CreateBuilder          :: proc() -> BuilderRef ---

	/**
	* Set the builder position before Instr but after any attached debug records,
	* or if Instr is null set the position to the end of Block.
	*/
	PositionBuilder :: proc(Builder: BuilderRef, Block: BasicBlockRef, Instr: ValueRef) ---

	/**
	* Set the builder position before Instr and any attached debug records,
	* or if Instr is null set the position to the end of Block.
	*/
	PositionBuilderBeforeDbgRecords :: proc(Builder: BuilderRef, Block: BasicBlockRef, Inst: ValueRef) ---

	/**
	* Set the builder position before Instr but after any attached debug records.
	*/
	PositionBuilderBefore :: proc(Builder: BuilderRef, Instr: ValueRef) ---

	/**
	* Set the builder position before Instr and any attached debug records.
	*/
	PositionBuilderBeforeInstrAndDbgRecords :: proc(Builder: BuilderRef, Instr: ValueRef) ---
	PositionBuilderAtEnd                    :: proc(Builder: BuilderRef, Block: BasicBlockRef) ---
	GetInsertBlock                          :: proc(Builder: BuilderRef) -> BasicBlockRef ---
	ClearInsertionPosition                  :: proc(Builder: BuilderRef) ---
	InsertIntoBuilder                       :: proc(Builder: BuilderRef, Instr: ValueRef) ---
	InsertIntoBuilderWithName               :: proc(Builder: BuilderRef, Instr: ValueRef, Name: cstring) ---
	DisposeBuilder                          :: proc(Builder: BuilderRef) ---

	/**
	* Get location information used by debugging information.
	*
	* @see llvm::IRBuilder::getCurrentDebugLocation()
	*/
	GetCurrentDebugLocation2 :: proc(Builder: BuilderRef) -> MetadataRef ---

	/**
	* Set location information used by debugging information.
	*
	* To clear the location metadata of the given instruction, pass NULL to \p Loc.
	*
	* @see llvm::IRBuilder::SetCurrentDebugLocation()
	*/
	SetCurrentDebugLocation2 :: proc(Builder: BuilderRef, Loc: MetadataRef) ---

	/**
	* Attempts to set the debug location for the given instruction using the
	* current debug location for the given builder.  If the builder has no current
	* debug location, this function is a no-op.
	*
	* @deprecated LLVMSetInstDebugLocation is deprecated in favor of the more general
	*             LLVMAddMetadataToInst.
	*
	* @see llvm::IRBuilder::SetInstDebugLocation()
	*/
	SetInstDebugLocation :: proc(Builder: BuilderRef, Inst: ValueRef) ---

	/**
	* Adds the metadata registered with the given builder to the given instruction.
	*
	* @see llvm::IRBuilder::AddMetadataToInst()
	*/
	AddMetadataToInst :: proc(Builder: BuilderRef, Inst: ValueRef) ---

	/**
	* Get the dafult floating-point math metadata for a given builder.
	*
	* @see llvm::IRBuilder::getDefaultFPMathTag()
	*/
	BuilderGetDefaultFPMathTag :: proc(Builder: BuilderRef) -> MetadataRef ---

	/**
	* Set the default floating-point math metadata for the given builder.
	*
	* To clear the metadata, pass NULL to \p FPMathTag.
	*
	* @see llvm::IRBuilder::setDefaultFPMathTag()
	*/
	BuilderSetDefaultFPMathTag :: proc(Builder: BuilderRef, FPMathTag: MetadataRef) ---

	/**
	* Obtain the context to which this builder is associated.
	*
	* @see llvm::IRBuilder::getContext()
	*/
	GetBuilderContext :: proc(Builder: BuilderRef) -> ContextRef ---

	/**
	* Deprecated: Passing the NULL location will crash.
	* Use LLVMGetCurrentDebugLocation2 instead.
	*/
	SetCurrentDebugLocation :: proc(Builder: BuilderRef, L: ValueRef) ---

	/**
	* Deprecated: Returning the NULL location will crash.
	* Use LLVMGetCurrentDebugLocation2 instead.
	*/
	GetCurrentDebugLocation :: proc(Builder: BuilderRef) -> ValueRef ---

	/* Terminators */
	BuildRetVoid                  :: proc(BuilderRef) -> ValueRef ---
	BuildRet                      :: proc(_: BuilderRef, V: ValueRef) -> ValueRef ---
	BuildAggregateRet             :: proc(_: BuilderRef, RetVals: ^ValueRef, N: u32) -> ValueRef ---
	BuildBr                       :: proc(_: BuilderRef, Dest: BasicBlockRef) -> ValueRef ---
	BuildCondBr                   :: proc(_: BuilderRef, If: ValueRef, Then: BasicBlockRef, Else: BasicBlockRef) -> ValueRef ---
	BuildSwitch                   :: proc(_: BuilderRef, V: ValueRef, Else: BasicBlockRef, NumCases: u32) -> ValueRef ---
	BuildIndirectBr               :: proc(B: BuilderRef, Addr: ValueRef, NumDests: u32) -> ValueRef ---
	BuildCallBr                   :: proc(B: BuilderRef, Ty: TypeRef, Fn: ValueRef, DefaultDest: BasicBlockRef, IndirectDests: ^BasicBlockRef, NumIndirectDests: u32, Args: ^ValueRef, NumArgs: u32, Bundles: ^OperandBundleRef, NumBundles: u32, Name: cstring) -> ValueRef ---
	BuildInvoke2                  :: proc(_: BuilderRef, Ty: TypeRef, Fn: ValueRef, Args: ^ValueRef, NumArgs: u32, Then: BasicBlockRef, Catch: BasicBlockRef, Name: cstring) -> ValueRef ---
	BuildInvokeWithOperandBundles :: proc(_: BuilderRef, Ty: TypeRef, Fn: ValueRef, Args: ^ValueRef, NumArgs: u32, Then: BasicBlockRef, Catch: BasicBlockRef, Bundles: ^OperandBundleRef, NumBundles: u32, Name: cstring) -> ValueRef ---
	BuildUnreachable              :: proc(BuilderRef) -> ValueRef ---

	/* Exception Handling */
	BuildResume      :: proc(B: BuilderRef, Exn: ValueRef) -> ValueRef ---
	BuildLandingPad  :: proc(B: BuilderRef, Ty: TypeRef, PersFn: ValueRef, NumClauses: u32, Name: cstring) -> ValueRef ---
	BuildCleanupRet  :: proc(B: BuilderRef, CatchPad: ValueRef, BB: BasicBlockRef) -> ValueRef ---
	BuildCatchRet    :: proc(B: BuilderRef, CatchPad: ValueRef, BB: BasicBlockRef) -> ValueRef ---
	BuildCatchPad    :: proc(B: BuilderRef, ParentPad: ValueRef, Args: ^ValueRef, NumArgs: u32, Name: cstring) -> ValueRef ---
	BuildCleanupPad  :: proc(B: BuilderRef, ParentPad: ValueRef, Args: ^ValueRef, NumArgs: u32, Name: cstring) -> ValueRef ---
	BuildCatchSwitch :: proc(B: BuilderRef, ParentPad: ValueRef, UnwindBB: BasicBlockRef, NumHandlers: u32, Name: cstring) -> ValueRef ---

	/* Add a case to the switch instruction */
	AddCase :: proc(Switch: ValueRef, OnVal: ValueRef, Dest: BasicBlockRef) ---

	/* Add a destination to the indirectbr instruction */
	AddDestination :: proc(IndirectBr: ValueRef, Dest: BasicBlockRef) ---

	/* Get the number of clauses on the landingpad instruction */
	GetNumClauses :: proc(LandingPad: ValueRef) -> u32 ---

	/* Get the value of the clause at index Idx on the landingpad instruction */
	GetClause :: proc(LandingPad: ValueRef, Idx: u32) -> ValueRef ---

	/* Add a catch or filter clause to the landingpad instruction */
	AddClause :: proc(LandingPad: ValueRef, ClauseVal: ValueRef) ---

	/* Get the 'cleanup' flag in the landingpad instruction */
	IsCleanup :: proc(LandingPad: ValueRef) -> Bool ---

	/* Set the 'cleanup' flag in the landingpad instruction */
	SetCleanup :: proc(LandingPad: ValueRef, Val: Bool) ---

	/* Add a destination to the catchswitch instruction */
	AddHandler :: proc(CatchSwitch: ValueRef, Dest: BasicBlockRef) ---

	/* Get the number of handlers on the catchswitch instruction */
	GetNumHandlers :: proc(CatchSwitch: ValueRef) -> u32 ---

	/**
	* Obtain the basic blocks acting as handlers for a catchswitch instruction.
	*
	* The Handlers parameter should point to a pre-allocated array of
	* LLVMBasicBlockRefs at least LLVMGetNumHandlers() large. On return, the
	* first LLVMGetNumHandlers() entries in the array will be populated
	* with LLVMBasicBlockRef instances.
	*
	* @param CatchSwitch The catchswitch instruction to operate on.
	* @param Handlers Memory address of an array to be filled with basic blocks.
	*/
	GetHandlers :: proc(CatchSwitch: ValueRef, Handlers: ^BasicBlockRef) ---

	/* Get the number of funcletpad arguments. */
	GetArgOperand :: proc(Funclet: ValueRef, i: u32) -> ValueRef ---

	/* Set a funcletpad argument at the given index. */
	SetArgOperand :: proc(Funclet: ValueRef, i: u32, value: ValueRef) ---

	/**
	* Get the parent catchswitch instruction of a catchpad instruction.
	*
	* This only works on llvm::CatchPadInst instructions.
	*
	* @see llvm::CatchPadInst::getCatchSwitch()
	*/
	GetParentCatchSwitch :: proc(CatchPad: ValueRef) -> ValueRef ---

	/**
	* Set the parent catchswitch instruction of a catchpad instruction.
	*
	* This only works on llvm::CatchPadInst instructions.
	*
	* @see llvm::CatchPadInst::setCatchSwitch()
	*/
	SetParentCatchSwitch :: proc(CatchPad: ValueRef, CatchSwitch: ValueRef) ---

	/* Arithmetic */
	BuildAdd       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNSWAdd    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNUWAdd    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFAdd      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildSub       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNSWSub    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNUWSub    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFSub      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildMul       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNSWMul    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNUWMul    :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFMul      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildUDiv      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildExactUDiv :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildSDiv      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildExactSDiv :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFDiv      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildURem      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildSRem      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFRem      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildShl       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildLShr      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildAShr      :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildAnd       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildOr        :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildXor       :: proc(_: BuilderRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildBinOp     :: proc(B: BuilderRef, Op: Opcode, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildNeg       :: proc(_: BuilderRef, V: ValueRef, Name: cstring) -> ValueRef ---
	BuildNSWNeg    :: proc(B: BuilderRef, V: ValueRef, Name: cstring) -> ValueRef ---
	BuildNUWNeg    :: proc(B: BuilderRef, V: ValueRef, Name: cstring) -> ValueRef ---
	BuildFNeg      :: proc(_: BuilderRef, V: ValueRef, Name: cstring) -> ValueRef ---
	BuildNot       :: proc(_: BuilderRef, V: ValueRef, Name: cstring) -> ValueRef ---
	GetNUW         :: proc(ArithInst: ValueRef) -> Bool ---
	SetNUW         :: proc(ArithInst: ValueRef, HasNUW: Bool) ---
	GetNSW         :: proc(ArithInst: ValueRef) -> Bool ---
	SetNSW         :: proc(ArithInst: ValueRef, HasNSW: Bool) ---
	GetExact       :: proc(DivOrShrInst: ValueRef) -> Bool ---
	SetExact       :: proc(DivOrShrInst: ValueRef, IsExact: Bool) ---

	/**
	* Gets if the instruction has the non-negative flag set.
	* Only valid for zext instructions.
	*/
	GetNNeg :: proc(NonNegInst: ValueRef) -> Bool ---

	/**
	* Sets the non-negative flag for the instruction.
	* Only valid for zext instructions.
	*/
	SetNNeg :: proc(NonNegInst: ValueRef, IsNonNeg: Bool) ---

	/**
	* Get the flags for which fast-math-style optimizations are allowed for this
	* value.
	*
	* Only valid on floating point instructions.
	* @see LLVMCanValueUseFastMathFlags
	*/
	GetFastMathFlags :: proc(FPMathInst: ValueRef) -> FastMathFlags ---

	/**
	* Sets the flags for which fast-math-style optimizations are allowed for this
	* value.
	*
	* Only valid on floating point instructions.
	* @see LLVMCanValueUseFastMathFlags
	*/
	SetFastMathFlags :: proc(FPMathInst: ValueRef, FMF: FastMathFlags) ---

	/**
	* Check if a given value can potentially have fast math flags.
	*
	* Will return true for floating point arithmetic instructions, and for select,
	* phi, and call instructions whose type is a floating point type, or a vector
	* or array thereof. See https://llvm.org/docs/LangRef.html#fast-math-flags
	*/
	CanValueUseFastMathFlags :: proc(Inst: ValueRef) -> Bool ---

	/**
	* Gets whether the instruction has the disjoint flag set.
	* Only valid for or instructions.
	*/
	GetIsDisjoint :: proc(Inst: ValueRef) -> Bool ---

	/**
	* Sets the disjoint flag for the instruction.
	* Only valid for or instructions.
	*/
	SetIsDisjoint :: proc(Inst: ValueRef, IsDisjoint: Bool) ---

	/* Memory */
	BuildMalloc      :: proc(_: BuilderRef, Ty: TypeRef, Name: cstring) -> ValueRef ---
	BuildArrayMalloc :: proc(_: BuilderRef, Ty: TypeRef, Val: ValueRef, Name: cstring) -> ValueRef ---

	/**
	* Creates and inserts a memset to the specified pointer and the
	* specified value.
	*
	* @see llvm::IRRBuilder::CreateMemSet()
	*/
	BuildMemSet :: proc(B: BuilderRef, Ptr: ValueRef, Val: ValueRef, Len: ValueRef, Align: u32) -> ValueRef ---

	/**
	* Creates and inserts a memcpy between the specified pointers.
	*
	* @see llvm::IRRBuilder::CreateMemCpy()
	*/
	BuildMemCpy :: proc(B: BuilderRef, Dst: ValueRef, DstAlign: u32, Src: ValueRef, SrcAlign: u32, Size: ValueRef) -> ValueRef ---

	/**
	* Creates and inserts a memmove between the specified pointers.
	*
	* @see llvm::IRRBuilder::CreateMemMove()
	*/
	BuildMemMove      :: proc(B: BuilderRef, Dst: ValueRef, DstAlign: u32, Src: ValueRef, SrcAlign: u32, Size: ValueRef) -> ValueRef ---
	BuildAlloca       :: proc(_: BuilderRef, Ty: TypeRef, Name: cstring) -> ValueRef ---
	BuildArrayAlloca  :: proc(_: BuilderRef, Ty: TypeRef, Val: ValueRef, Name: cstring) -> ValueRef ---
	BuildFree         :: proc(_: BuilderRef, PointerVal: ValueRef) -> ValueRef ---
	BuildLoad2        :: proc(_: BuilderRef, Ty: TypeRef, PointerVal: ValueRef, Name: cstring) -> ValueRef ---
	BuildStore        :: proc(_: BuilderRef, Val: ValueRef, Ptr: ValueRef) -> ValueRef ---
	BuildGEP2         :: proc(B: BuilderRef, Ty: TypeRef, Pointer: ValueRef, Indices: ^ValueRef, NumIndices: u32, Name: cstring) -> ValueRef ---
	BuildInBoundsGEP2 :: proc(B: BuilderRef, Ty: TypeRef, Pointer: ValueRef, Indices: ^ValueRef, NumIndices: u32, Name: cstring) -> ValueRef ---

	/**
	* Creates a GetElementPtr instruction. Similar to LLVMBuildGEP2, but allows
	* specifying the no-wrap flags.
	*
	* @see llvm::IRBuilder::CreateGEP()
	*/
	BuildGEPWithNoWrapFlags :: proc(B: BuilderRef, Ty: TypeRef, Pointer: ValueRef, Indices: ^ValueRef, NumIndices: u32, Name: cstring, NoWrapFlags: GEPNoWrapFlags) -> ValueRef ---
	BuildStructGEP2         :: proc(B: BuilderRef, Ty: TypeRef, Pointer: ValueRef, Idx: u32, Name: cstring) -> ValueRef ---
	BuildGlobalString       :: proc(B: BuilderRef, Str: cstring, Name: cstring) -> ValueRef ---

	/**
	* Deprecated: Use LLVMBuildGlobalString instead, which has identical behavior.
	*/
	BuildGlobalStringPtr :: proc(B: BuilderRef, Str: cstring, Name: cstring) -> ValueRef ---
	GetVolatile          :: proc(Inst: ValueRef) -> Bool ---
	SetVolatile          :: proc(MemoryAccessInst: ValueRef, IsVolatile: Bool) ---
	GetWeak              :: proc(CmpXchgInst: ValueRef) -> Bool ---
	SetWeak              :: proc(CmpXchgInst: ValueRef, IsWeak: Bool) ---
	GetOrdering          :: proc(MemoryAccessInst: ValueRef) -> AtomicOrdering ---
	SetOrdering          :: proc(MemoryAccessInst: ValueRef, Ordering: AtomicOrdering) ---
	GetAtomicRMWBinOp    :: proc(AtomicRMWInst: ValueRef) -> AtomicRMWBinOp ---
	SetAtomicRMWBinOp    :: proc(AtomicRMWInst: ValueRef, BinOp: AtomicRMWBinOp) ---

	/* Casts */
	BuildTrunc          :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildZExt           :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildSExt           :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildFPToUI         :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildFPToSI         :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildUIToFP         :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildSIToFP         :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildFPTrunc        :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildFPExt          :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildPtrToInt       :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildIntToPtr       :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildBitCast        :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildAddrSpaceCast  :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildZExtOrBitCast  :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildSExtOrBitCast  :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildTruncOrBitCast :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildCast           :: proc(B: BuilderRef, Op: Opcode, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildPointerCast    :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	BuildIntCast2       :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, IsSigned: Bool, Name: cstring) -> ValueRef ---
	BuildFPCast         :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---

	/** Deprecated: This cast is always signed. Use LLVMBuildIntCast2 instead. */
	BuildIntCast  :: proc(_: BuilderRef, Val: ValueRef, DestTy: TypeRef, Name: cstring) -> ValueRef ---
	GetCastOpcode :: proc(Src: ValueRef, SrcIsSigned: Bool, DestTy: TypeRef, DestIsSigned: Bool) -> Opcode ---

	/* Comparisons */
	BuildICmp :: proc(_: BuilderRef, Op: IntPredicate, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFCmp :: proc(_: BuilderRef, Op: RealPredicate, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---

	/* Miscellaneous instructions */
	BuildPhi                    :: proc(_: BuilderRef, Ty: TypeRef, Name: cstring) -> ValueRef ---
	BuildCall2                  :: proc(_: BuilderRef, _: TypeRef, Fn: ValueRef, Args: ^ValueRef, NumArgs: u32, Name: cstring) -> ValueRef ---
	BuildCallWithOperandBundles :: proc(_: BuilderRef, _: TypeRef, Fn: ValueRef, Args: ^ValueRef, NumArgs: u32, Bundles: ^OperandBundleRef, NumBundles: u32, Name: cstring) -> ValueRef ---
	BuildSelect                 :: proc(_: BuilderRef, If: ValueRef, Then: ValueRef, Else: ValueRef, Name: cstring) -> ValueRef ---
	BuildVAArg                  :: proc(_: BuilderRef, List: ValueRef, Ty: TypeRef, Name: cstring) -> ValueRef ---
	BuildExtractElement         :: proc(_: BuilderRef, VecVal: ValueRef, Index: ValueRef, Name: cstring) -> ValueRef ---
	BuildInsertElement          :: proc(_: BuilderRef, VecVal: ValueRef, EltVal: ValueRef, Index: ValueRef, Name: cstring) -> ValueRef ---
	BuildShuffleVector          :: proc(_: BuilderRef, V1: ValueRef, V2: ValueRef, Mask: ValueRef, Name: cstring) -> ValueRef ---
	BuildExtractValue           :: proc(_: BuilderRef, AggVal: ValueRef, Index: u32, Name: cstring) -> ValueRef ---
	BuildInsertValue            :: proc(_: BuilderRef, AggVal: ValueRef, EltVal: ValueRef, Index: u32, Name: cstring) -> ValueRef ---
	BuildFreeze                 :: proc(_: BuilderRef, Val: ValueRef, Name: cstring) -> ValueRef ---
	BuildIsNull                 :: proc(_: BuilderRef, Val: ValueRef, Name: cstring) -> ValueRef ---
	BuildIsNotNull              :: proc(_: BuilderRef, Val: ValueRef, Name: cstring) -> ValueRef ---
	BuildPtrDiff2               :: proc(_: BuilderRef, ElemTy: TypeRef, LHS: ValueRef, RHS: ValueRef, Name: cstring) -> ValueRef ---
	BuildFence                  :: proc(B: BuilderRef, ordering: AtomicOrdering, singleThread: Bool, Name: cstring) -> ValueRef ---
	BuildFenceSyncScope         :: proc(B: BuilderRef, ordering: AtomicOrdering, SSID: u32, Name: cstring) -> ValueRef ---
	BuildAtomicRMW              :: proc(B: BuilderRef, op: AtomicRMWBinOp, PTR: ValueRef, Val: ValueRef, ordering: AtomicOrdering, singleThread: Bool) -> ValueRef ---
	BuildAtomicRMWSyncScope     :: proc(B: BuilderRef, op: AtomicRMWBinOp, PTR: ValueRef, Val: ValueRef, ordering: AtomicOrdering, SSID: u32) -> ValueRef ---
	BuildAtomicCmpXchg          :: proc(B: BuilderRef, Ptr: ValueRef, Cmp: ValueRef, New: ValueRef, SuccessOrdering: AtomicOrdering, FailureOrdering: AtomicOrdering, SingleThread: Bool) -> ValueRef ---
	BuildAtomicCmpXchgSyncScope :: proc(B: BuilderRef, Ptr: ValueRef, Cmp: ValueRef, New: ValueRef, SuccessOrdering: AtomicOrdering, FailureOrdering: AtomicOrdering, SSID: u32) -> ValueRef ---

	/**
	* Get the number of elements in the mask of a ShuffleVector instruction.
	*/
	GetNumMaskElements :: proc(ShuffleVectorInst: ValueRef) -> u32 ---

	/**
	* \returns a constant that specifies that the result of a \c ShuffleVectorInst
	* is undefined.
	*/
	GetUndefMaskElem :: proc() -> i32 ---

	/**
	* Get the mask value at position Elt in the mask of a ShuffleVector
	* instruction.
	*
	* \Returns the result of \c LLVMGetUndefMaskElem() if the mask value is
	* poison at that position.
	*/
	GetMaskValue          :: proc(ShuffleVectorInst: ValueRef, Elt: u32) -> i32 ---
	IsAtomicSingleThread  :: proc(AtomicInst: ValueRef) -> Bool ---
	SetAtomicSingleThread :: proc(AtomicInst: ValueRef, SingleThread: Bool) ---

	/**
	* Returns whether an instruction is an atomic instruction, e.g., atomicrmw,
	* cmpxchg, fence, or loads and stores with atomic ordering.
	*/
	IsAtomic :: proc(Inst: ValueRef) -> Bool ---

	/**
	* Returns the synchronization scope ID of an atomic instruction.
	*/
	GetAtomicSyncScopeID :: proc(AtomicInst: ValueRef) -> u32 ---

	/**
	* Sets the synchronization scope ID of an atomic instruction.
	*/
	SetAtomicSyncScopeID      :: proc(AtomicInst: ValueRef, SSID: u32) ---
	GetCmpXchgSuccessOrdering :: proc(CmpXchgInst: ValueRef) -> AtomicOrdering ---
	SetCmpXchgSuccessOrdering :: proc(CmpXchgInst: ValueRef, Ordering: AtomicOrdering) ---
	GetCmpXchgFailureOrdering :: proc(CmpXchgInst: ValueRef) -> AtomicOrdering ---
	SetCmpXchgFailureOrdering :: proc(CmpXchgInst: ValueRef, Ordering: AtomicOrdering) ---

	/**
	* Changes the type of M so it can be passed to FunctionPassManagers and the
	* JIT.  They take ModuleProviders for historical reasons.
	*/
	CreateModuleProviderForExistingModule :: proc(M: ModuleRef) -> ModuleProviderRef ---

	/**
	* Destroys the module M.
	*/
	DisposeModuleProvider :: proc(M: ModuleProviderRef) ---

	/**
	* @defgroup LLVMCCoreMemoryBuffers Memory Buffers
	*
	* @{
	*/
	CreateMemoryBufferWithContentsOfFile  :: proc(Path: cstring, OutMemBuf: ^MemoryBufferRef, OutMessage: ^cstring) -> Bool ---
	CreateMemoryBufferWithSTDIN           :: proc(OutMemBuf: ^MemoryBufferRef, OutMessage: ^cstring) -> Bool ---
	CreateMemoryBufferWithMemoryRange     :: proc(InputData: cstring, InputDataLength: c.size_t, BufferName: cstring, RequiresNullTerminator: Bool) -> MemoryBufferRef ---
	CreateMemoryBufferWithMemoryRangeCopy :: proc(InputData: cstring, InputDataLength: c.size_t, BufferName: cstring) -> MemoryBufferRef ---
	GetBufferStart                        :: proc(MemBuf: MemoryBufferRef) -> cstring ---
	GetBufferSize                         :: proc(MemBuf: MemoryBufferRef) -> c.size_t ---
	DisposeMemoryBuffer                   :: proc(MemBuf: MemoryBufferRef) ---

	/** Constructs a new whole-module pass pipeline. This type of pipeline is
	suitable for link-time optimization and whole-module transformations.
	@see llvm::PassManager::PassManager */
	CreatePassManager :: proc() -> PassManagerRef ---

	/** Constructs a new function-by-function pass pipeline over the module
	provider. It does not take ownership of the module provider. This type of
	pipeline is suitable for code generation and JIT compilation tasks.
	@see llvm::FunctionPassManager::FunctionPassManager */
	CreateFunctionPassManagerForModule :: proc(M: ModuleRef) -> PassManagerRef ---

	/** Deprecated: Use LLVMCreateFunctionPassManagerForModule instead. */
	CreateFunctionPassManager :: proc(MP: ModuleProviderRef) -> PassManagerRef ---

	/** Initializes, executes on the provided module, and finalizes all of the
	passes scheduled in the pass manager. Returns 1 if any of the passes
	modified the module, 0 otherwise.
	@see llvm::PassManager::run(Module&) */
	RunPassManager :: proc(PM: PassManagerRef, M: ModuleRef) -> Bool ---

	/** Initializes all of the function passes scheduled in the function pass
	manager. Returns 1 if any of the passes modified the module, 0 otherwise.
	@see llvm::FunctionPassManager::doInitialization */
	InitializeFunctionPassManager :: proc(FPM: PassManagerRef) -> Bool ---

	/** Executes all of the function passes scheduled in the function pass manager
	on the provided function. Returns 1 if any of the passes modified the
	function, false otherwise.
	@see llvm::FunctionPassManager::run(Function&) */
	RunFunctionPassManager :: proc(FPM: PassManagerRef, F: ValueRef) -> Bool ---

	/** Finalizes all of the function passes scheduled in the function pass
	manager. Returns 1 if any of the passes modified the module, 0 otherwise.
	@see llvm::FunctionPassManager::doFinalization */
	FinalizeFunctionPassManager :: proc(FPM: PassManagerRef) -> Bool ---

	/** Frees the memory of a pass pipeline. For function pipelines, does not free
	the module provider.
	@see llvm::PassManagerBase::~PassManagerBase. */
	DisposePassManager :: proc(PM: PassManagerRef) ---

	/** Deprecated: Multi-threading can only be enabled/disabled with the compile
	time define LLVM_ENABLE_THREADS.  This function always returns
	LLVMIsMultithreaded(). */
	StartMultithreaded :: proc() -> Bool ---

	/** Deprecated: Multi-threading can only be enabled/disabled with the compile
	time define LLVM_ENABLE_THREADS. */
	StopMultithreaded :: proc() ---

	/** Check whether LLVM is executing in thread-safe mode or not.
	@see llvm::llvm_is_multithreaded */
	IsMultithreaded :: proc() -> Bool ---
}

