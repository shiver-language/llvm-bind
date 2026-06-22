/*===-- llvm-c/Support.h - C Interface Types declarations ---------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file defines types used by the C interface to LLVM.                   *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "system:LLVM"


/**
* @defgroup LLVMCSupportTypes Types and Enumerations
*
* @{
*/
Bool               :: i32
OpaqueMemoryBuffer :: struct {}

/**
* Used to pass regions of memory through LLVM interfaces.
*
* @see llvm::MemoryBuffer
*/
MemoryBufferRef :: ^OpaqueMemoryBuffer
OpaqueContext   :: struct {}

/**
* The top-level container for all LLVM global data. See the LLVMContext class.
*/
ContextRef   :: ^OpaqueContext
OpaqueModule :: struct {}

/**
* The top-level container for all other LLVM Intermediate Representation (IR)
* objects.
*
* @see llvm::Module
*/
ModuleRef  :: ^OpaqueModule
OpaqueType :: struct {}

/**
* Each value in the LLVM IR has a type, an LLVMTypeRef.
*
* @see llvm::Type
*/
TypeRef     :: ^OpaqueType
OpaqueValue :: struct {}

/**
* Represents an individual value in LLVM IR.
*
* This models llvm::Value.
*/
ValueRef         :: ^OpaqueValue
OpaqueBasicBlock :: struct {}

/**
* Represents a basic block of instructions in LLVM IR.
*
* This models llvm::BasicBlock.
*/
BasicBlockRef  :: ^OpaqueBasicBlock
OpaqueMetadata :: struct {}

/**
* Represents an LLVM Metadata.
*
* This models llvm::Metadata.
*/
MetadataRef       :: ^OpaqueMetadata
OpaqueNamedMDNode :: struct {}

/**
* Represents an LLVM Named Metadata Node.
*
* This models llvm::NamedMDNode.
*/
NamedMDNodeRef           :: ^OpaqueNamedMDNode
OpaqueValueMetadataEntry :: struct {}

/**
* Represents an entry in a Global Object's metadata attachments.
*
* This models std::pair<unsigned, MDNode *>
*/
ValueMetadataEntry :: OpaqueValueMetadataEntry
OpaqueBuilder      :: struct {}

/**
* Represents an LLVM basic block builder.
*
* This models llvm::IRBuilder.
*/
BuilderRef      :: ^OpaqueBuilder
OpaqueDIBuilder :: struct {}

/**
* Represents an LLVM debug info builder.
*
* This models llvm::DIBuilder.
*/
DIBuilderRef         :: ^OpaqueDIBuilder
OpaqueModuleProvider :: struct {}

/**
* Interface used to provide a module to JIT or interpreter.
* This is now just a synonym for llvm::Module, but we have to keep using the
* different type to keep binary compatibility.
*/
ModuleProviderRef :: ^OpaqueModuleProvider
OpaquePassManager :: struct {}

/** @see llvm::PassManagerBase */
PassManagerRef :: ^OpaquePassManager
OpaqueUse      :: struct {}

/**
* Used to get the users and usees of a Value.
*
* @see llvm::Use */
UseRef              :: ^OpaqueUse
OpaqueOperandBundle :: struct {}

/**
* @see llvm::OperandBundleDef
*/
OperandBundleRef   :: ^OpaqueOperandBundle
OpaqueAttributeRef :: struct {}

/**
* Used to represent an attributes.
*
* @see llvm::Attribute
*/
AttributeRef         :: ^OpaqueAttributeRef
OpaqueDiagnosticInfo :: struct {}

/**
* @see llvm::DiagnosticInfo
*/
DiagnosticInfoRef :: ^OpaqueDiagnosticInfo
Comdat            :: struct {}

/**
* @see llvm::Comdat
*/
ComdatRef             :: ^Comdat
OpaqueModuleFlagEntry :: struct {}

/**
* @see llvm::Module::ModuleFlagEntry
*/
ModuleFlagEntry        :: OpaqueModuleFlagEntry
OpaqueJITEventListener :: struct {}

/**
* @see llvm::JITEventListener
*/
JITEventListenerRef :: ^OpaqueJITEventListener
OpaqueBinary        :: struct {}

/**
* @see llvm::object::Binary
*/
BinaryRef       :: ^OpaqueBinary
OpaqueDbgRecord :: struct {}

/**
* @see llvm::DbgRecord
*/
DbgRecordRef :: ^OpaqueDbgRecord

