/*===------- llvm-c/Error.h - llvm::Error class C Interface -------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This file defines the C interface to LLVM's Error class.                   *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

foreign import lib "llvm-install/lib/LLVM-C.lib"


/**
* @defgroup LLVMCError Error Handling
* @ingroup LLVMC
*
* @{
*/
LLVMErrorSuccess :: 0

OpaqueError :: struct {}

/**
* Opaque reference to an error instance. Null serves as the 'success' value.
*/
ErrorRef :: ^OpaqueError

/**
* Error type identifier.
*/
ErrorTypeId :: rawptr

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Returns the type id for the given error instance, which must be a failure
	* value (i.e. non-null).
	*/
	GetErrorTypeId :: proc(Err: ErrorRef) -> ErrorTypeId ---

	/**
	* Dispose of the given error without handling it. This operation consumes the
	* error, and the given LLVMErrorRef value is not usable once this call returns.
	* Note: This method *only* needs to be called if the error is not being passed
	* to some other consuming operation, e.g. LLVMGetErrorMessage.
	*/
	ConsumeError :: proc(Err: ErrorRef) ---

	/**
	* Report a fatal error if Err is a failure value.
	*
	* This function can be used to wrap calls to fallible functions ONLY when it is
	* known that the Error will always be a success value.
	*/
	CantFail :: proc(Err: ErrorRef) ---

	/**
	* Returns the given string's error message. This operation consumes the error,
	* and the given LLVMErrorRef value is not usable once this call returns.
	* The caller is responsible for disposing of the string by calling
	* LLVMDisposeErrorMessage.
	*/
	GetErrorMessage :: proc(Err: ErrorRef) -> cstring ---

	/**
	* Dispose of the given error message.
	*/
	DisposeErrorMessage :: proc(ErrMsg: cstring) ---

	/**
	* Returns the type id for llvm StringError.
	*/
	GetStringErrorTypeId :: proc() -> ErrorTypeId ---

	/**
	* Create a StringError.
	*/
	CreateStringError :: proc(ErrMsg: cstring) -> ErrorRef ---
}

