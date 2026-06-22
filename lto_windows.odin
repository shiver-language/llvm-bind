/*===-- llvm-c/lto.h - LTO Public C Interface ---------------------*- C -*-===*\
|*                                                                            *|
|* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
|* Exceptions.                                                                *|
|* See https://llvm.org/LICENSE.txt for license information.                  *|
|* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header provides public interface to an abstract link time optimization*|
|* library.  LLVM provides an implementation of this interface for use with   *|
|* llvm bitcode files.                                                        *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "llvm-install/lib/LLVM-C.lib"


/* MSVC in particular does not have anything like _Bool or bool in C, but we can
at least make sure the type is the same size.  The implementation side will
use C++ bool. */
lto_bool_t :: u8

posix_off_t :: distinct i64

/**
* @defgroup LLVMCLTO LTO
* @ingroup LLVMC
*
* @{
*/
LTO_API_VERSION :: 30

/**
* \since prior to LTO_API_VERSION=3
*/
lto_symbol_attributes :: enum i32 {
	ALIGNMENT_MASK              = 31, /* log2 of alignment */
	PERMISSIONS_MASK            = 224,
	PERMISSIONS_CODE            = 160,
	PERMISSIONS_DATA            = 192,
	PERMISSIONS_RODATA          = 128,
	DEFINITION_MASK             = 1792,
	DEFINITION_REGULAR          = 256,
	DEFINITION_TENTATIVE        = 512,
	DEFINITION_WEAK             = 768,
	DEFINITION_UNDEFINED        = 1024,
	DEFINITION_WEAKUNDEF        = 1280,
	SCOPE_MASK                  = 14336,
	SCOPE_INTERNAL              = 2048,
	SCOPE_HIDDEN                = 4096,
	SCOPE_PROTECTED             = 8192,
	SCOPE_DEFAULT               = 6144,
	SCOPE_DEFAULT_CAN_BE_HIDDEN = 10240,
	COMDAT                      = 16384,
	ALIAS                       = 32768,
}

/**
* \since prior to LTO_API_VERSION=3
*/
lto_debug_model :: enum i32 {
	NONE  = 0,
	DWARF = 1,
}

/**
* \since prior to LTO_API_VERSION=3
*/
lto_codegen_model :: enum i32 {
	STATIC         = 0,
	DYNAMIC        = 1,
	DYNAMIC_NO_PIC = 2,
	DEFAULT        = 3,
}

OpaqueLTOModule :: struct {}

/** opaque reference to a loaded object module */
lto_module_t           :: ^OpaqueLTOModule
OpaqueLTOCodeGenerator :: struct {}

/** opaque reference to a code generator */
lto_code_gen_t             :: ^OpaqueLTOCodeGenerator
OpaqueThinLTOCodeGenerator :: struct {}

/** opaque reference to a thin code generator */
thinlto_code_gen_t :: ^OpaqueThinLTOCodeGenerator

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Returns a printable string.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_get_version :: proc() -> cstring ---

	/**
	* Returns the last error string or NULL if last operation was successful.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_get_error_message :: proc() -> cstring ---

	/**
	* Checks if a file is a loadable object file.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_is_object_file :: proc(path: cstring) -> lto_bool_t ---

	/**
	* Checks if a file is a loadable object compiled for requested target.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_is_object_file_for_target :: proc(path: cstring, target_triple_prefix: cstring) -> lto_bool_t ---

	/**
	* Return true if \p Buffer contains a bitcode file with ObjC code (category
	* or class) in it.
	*
	* \since LTO_API_VERSION=20
	*/
	lto_module_has_objc_category :: proc(mem: rawptr, length: c.size_t) -> lto_bool_t ---

	/**
	* Checks if a buffer is a loadable object file.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_is_object_file_in_memory :: proc(mem: rawptr, length: c.size_t) -> lto_bool_t ---

	/**
	* Checks if a buffer is a loadable object compiled for requested target.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_is_object_file_in_memory_for_target :: proc(mem: rawptr, length: c.size_t, target_triple_prefix: cstring) -> lto_bool_t ---

	/**
	* Loads an object file from disk.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_create :: proc(path: cstring) -> lto_module_t ---

	/**
	* Loads an object file from memory.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_create_from_memory :: proc(mem: rawptr, length: c.size_t) -> lto_module_t ---

	/**
	* Loads an object file from memory with an extra path argument.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=9
	*/
	lto_module_create_from_memory_with_path :: proc(mem: rawptr, length: c.size_t, path: cstring) -> lto_module_t ---

	/**
	* Loads an object file in its own context.
	*
	* Loads an object file in its own LLVMContext.  This function call is
	* thread-safe.  However, modules created this way should not be merged into an
	* lto_code_gen_t using \a lto_codegen_add_module().
	*
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=11
	*/
	lto_module_create_in_local_context :: proc(mem: rawptr, length: c.size_t, path: cstring) -> lto_module_t ---

	/**
	* Loads an object file in the codegen context.
	*
	* Loads an object file into the same context as \c cg.  The module is safe to
	* add using \a lto_codegen_add_module().
	*
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=11
	*/
	lto_module_create_in_codegen_context :: proc(mem: rawptr, length: c.size_t, path: cstring, cg: lto_code_gen_t) -> lto_module_t ---

	/**
	* Loads an object file from disk. The seek point of fd is not preserved.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=5
	*/
	lto_module_create_from_fd :: proc(fd: i32, path: cstring, file_size: c.size_t) -> lto_module_t ---

	/**
	* Loads an object file from disk. The seek point of fd is not preserved.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=5
	*/
	lto_module_create_from_fd_at_offset :: proc(fd: i32, path: cstring, file_size: c.size_t, map_size: c.size_t, offset: posix_off_t) -> lto_module_t ---

	/**
	* Frees all memory internally allocated by the module.
	* Upon return the lto_module_t is no longer valid.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_dispose :: proc(mod: lto_module_t) ---

	/**
	* Returns triple string which the object module was compiled under.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_get_target_triple :: proc(mod: lto_module_t) -> cstring ---

	/**
	* Sets triple string with which the object will be codegened.
	*
	* \since LTO_API_VERSION=4
	*/
	lto_module_set_target_triple :: proc(mod: lto_module_t, triple: cstring) ---

	/**
	* Returns the number of symbols in the object module.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_get_num_symbols :: proc(mod: lto_module_t) -> u32 ---

	/**
	* Returns the name of the ith symbol in the object module.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_get_symbol_name :: proc(mod: lto_module_t, index: u32) -> cstring ---

	/**
	* Returns the attributes of the ith symbol in the object module.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_module_get_symbol_attribute :: proc(mod: lto_module_t, index: u32) -> lto_symbol_attributes ---

	/**
	* Returns the number of asm undefined symbols in the object module.
	*
	* \since prior to LTO_API_VERSION=30
	*/
	lto_module_get_num_asm_undef_symbols :: proc(mod: lto_module_t) -> u32 ---

	/**
	* Returns the name of the ith asm undefined symbol in the object module.
	*
	* \since prior to LTO_API_VERSION=30
	*/
	lto_module_get_asm_undef_symbol_name :: proc(mod: lto_module_t, index: u32) -> cstring ---

	/**
	* Returns the module's linker options.
	*
	* The linker options may consist of multiple flags. It is the linker's
	* responsibility to split the flags using a platform-specific mechanism.
	*
	* \since LTO_API_VERSION=16
	*/
	lto_module_get_linkeropts :: proc(mod: lto_module_t) -> cstring ---

	/**
	* If targeting mach-o on darwin, this function gets the CPU type and subtype
	* that will end up being encoded in the mach-o header. These are the values
	* that can be found in mach/machine.h.
	*
	* \p out_cputype and \p out_cpusubtype must be non-NULL.
	*
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=27
	*/
	lto_module_get_macho_cputype :: proc(mod: lto_module_t, out_cputype: ^u32, out_cpusubtype: ^u32) -> lto_bool_t ---

	/**
	* This function can be used by the linker to check if a given module has
	* any constructor or destructor functions.
	*
	* Returns true if the module has either the @llvm.global_ctors or the
	* @llvm.global_dtors symbol. Otherwise returns false.
	*
	* \since LTO_API_VERSION=29
	*/
	lto_module_has_ctor_dtor :: proc(mod: lto_module_t) -> lto_bool_t ---
}

/**
* Diagnostic severity.
*
* \since LTO_API_VERSION=7
*/
lto_codegen_diagnostic_severity_t :: enum i32 {
	ERROR   = 0,
	WARNING = 1,
	REMARK  = 3, // Added in LTO_API_VERSION=10.
	NOTE    = 2,
}

/**
* Diagnostic handler type.
* \p severity defines the severity.
* \p diag is the actual diagnostic.
* The diagnostic is not prefixed by any of severity keyword, e.g., 'error: '.
* \p ctxt is used to pass the context set with the diagnostic handler.
*
* \since LTO_API_VERSION=7
*/
lto_diagnostic_handler_t :: proc "c" (severity: lto_codegen_diagnostic_severity_t, diag: cstring, ctxt: rawptr)

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Set a diagnostic handler and the related context (void *).
	* This is more general than lto_get_error_message, as the diagnostic handler
	* can be called at anytime within lto.
	*
	* \since LTO_API_VERSION=7
	*/
	lto_codegen_set_diagnostic_handler :: proc(lto_code_gen_t, lto_diagnostic_handler_t, rawptr) ---

	/**
	* Instantiates a code generator.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	* All modules added using \a lto_codegen_add_module() must have been created
	* in the same context as the codegen.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_create :: proc() -> lto_code_gen_t ---

	/**
	* Instantiate a code generator in its own context.
	*
	* Instantiates a code generator in its own context.  Modules added via \a
	* lto_codegen_add_module() must have all been created in the same context,
	* using \a lto_module_create_in_codegen_context().
	*
	* \since LTO_API_VERSION=11
	*/
	lto_codegen_create_in_local_context :: proc() -> lto_code_gen_t ---

	/**
	* Frees all code generator and all memory it internally allocated.
	* Upon return the lto_code_gen_t is no longer valid.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_dispose :: proc(lto_code_gen_t) ---

	/**
	* Add an object module to the set of modules for which code will be generated.
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \c cg and \c mod must both be in the same context.  See \a
	* lto_codegen_create_in_local_context() and \a
	* lto_module_create_in_codegen_context().
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_add_module :: proc(cg: lto_code_gen_t, mod: lto_module_t) -> lto_bool_t ---

	/**
	* Sets the object module for code generation. This will transfer the ownership
	* of the module to the code generator.
	*
	* \c cg and \c mod must both be in the same context.
	*
	* \since LTO_API_VERSION=13
	*/
	lto_codegen_set_module :: proc(cg: lto_code_gen_t, mod: lto_module_t) ---

	/**
	* Sets if debug info should be generated.
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_set_debug_model :: proc(cg: lto_code_gen_t, _: lto_debug_model) -> lto_bool_t ---

	/**
	* Sets which PIC code model to generated.
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_set_pic_model :: proc(cg: lto_code_gen_t, _: lto_codegen_model) -> lto_bool_t ---

	/**
	* Sets the cpu to generate code for.
	*
	* \since LTO_API_VERSION=4
	*/
	lto_codegen_set_cpu :: proc(cg: lto_code_gen_t, cpu: cstring) ---

	/**
	* Sets the location of the assembler tool to run. If not set, libLTO
	* will use gcc to invoke the assembler.
	*
	* \since LTO_API_VERSION=3
	*/
	lto_codegen_set_assembler_path :: proc(cg: lto_code_gen_t, path: cstring) ---

	/**
	* Sets extra arguments that libLTO should pass to the assembler.
	*
	* \since LTO_API_VERSION=4
	*/
	lto_codegen_set_assembler_args :: proc(cg: lto_code_gen_t, args: ^cstring, nargs: i32) ---

	/**
	* Adds to a list of all global symbols that must exist in the final generated
	* code. If a function is not listed there, it might be inlined into every usage
	* and optimized away.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_add_must_preserve_symbol :: proc(cg: lto_code_gen_t, symbol: cstring) ---

	/**
	* Writes a new object file at the specified path that contains the
	* merged contents of all modules added so far.
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=5
	*/
	lto_codegen_write_merged_modules :: proc(cg: lto_code_gen_t, path: cstring) -> lto_bool_t ---

	/**
	* Generates code for all added modules into one native object file.
	* This calls lto_codegen_optimize then lto_codegen_compile_optimized.
	*
	* On success returns a pointer to a generated mach-o/ELF buffer and
	* length set to the buffer size.  The buffer is owned by the
	* lto_code_gen_t and will be freed when lto_codegen_dispose()
	* is called, or lto_codegen_compile() is called again.
	* On failure, returns NULL (check lto_get_error_message() for details).
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_compile :: proc(cg: lto_code_gen_t, length: ^c.size_t) -> rawptr ---

	/**
	* Generates code for all added modules into one native object file.
	* This calls lto_codegen_optimize then lto_codegen_compile_optimized (instead
	* of returning a generated mach-o/ELF buffer, it writes to a file).
	*
	* The name of the file is written to name. Returns true on error.
	*
	* \since LTO_API_VERSION=5
	*/
	lto_codegen_compile_to_file :: proc(cg: lto_code_gen_t, name: ^cstring) -> lto_bool_t ---

	/**
	* Runs optimization for the merged module. Returns true on error.
	*
	* \since LTO_API_VERSION=12
	*/
	lto_codegen_optimize :: proc(cg: lto_code_gen_t) -> lto_bool_t ---

	/**
	* Generates code for the optimized merged module into one native object file.
	* It will not run any IR optimizations on the merged module.
	*
	* On success returns a pointer to a generated mach-o/ELF buffer and length set
	* to the buffer size.  The buffer is owned by the lto_code_gen_t and will be
	* freed when lto_codegen_dispose() is called, or
	* lto_codegen_compile_optimized() is called again. On failure, returns NULL
	* (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=12
	*/
	lto_codegen_compile_optimized :: proc(cg: lto_code_gen_t, length: ^c.size_t) -> rawptr ---

	/**
	* Returns the runtime API version.
	*
	* \since LTO_API_VERSION=12
	*/
	lto_api_version :: proc() -> u32 ---

	/**
	* Parses options immediately, making them available as early as possible. For
	* example during executing codegen::InitTargetOptionsFromCodeGenFlags. Since
	* parsing shud only happen once, only one of lto_codegen_debug_options or
	* lto_set_debug_options should be called.
	*
	* This function takes one or more options separated by spaces.
	* Warning: passing file paths through this function may confuse the argument
	* parser if the paths contain spaces.
	*
	* \since LTO_API_VERSION=28
	*/
	lto_set_debug_options :: proc(options: ^cstring, number: i32) ---

	/**
	* Sets options to help debug codegen bugs. Since parsing shud only happen once,
	* only one of lto_codegen_debug_options or lto_set_debug_options
	* should be called.
	*
	* This function takes one or more options separated by spaces.
	* Warning: passing file paths through this function may confuse the argument
	* parser if the paths contain spaces.
	*
	* \since prior to LTO_API_VERSION=3
	*/
	lto_codegen_debug_options :: proc(cg: lto_code_gen_t, _: cstring) ---

	/**
	* Same as the previous function, but takes every option separately through an
	* array.
	*
	* \since prior to LTO_API_VERSION=26
	*/
	lto_codegen_debug_options_array :: proc(cg: lto_code_gen_t, _: ^cstring, number: i32) ---

	/**
	* Initializes LLVM disassemblers.
	* FIXME: This doesn't really belong here.
	*
	* \since LTO_API_VERSION=5
	*/
	lto_initialize_disassembler :: proc() ---

	/**
	* Sets if we should run internalize pass during optimization and code
	* generation.
	*
	* \since LTO_API_VERSION=14
	*/
	lto_codegen_set_should_internalize :: proc(cg: lto_code_gen_t, ShouldInternalize: lto_bool_t) ---

	/**
	* Set whether to embed uselists in bitcode.
	*
	* Sets whether \a lto_codegen_write_merged_modules() should embed uselists in
	* output bitcode.  This should be turned on for all -save-temps output.
	*
	* \since LTO_API_VERSION=15
	*/
	lto_codegen_set_should_embed_uselists :: proc(cg: lto_code_gen_t, ShouldEmbedUselists: lto_bool_t) ---
}

OpaqueLTOInput :: struct {}

/** Opaque reference to an LTO input file */
lto_input_t :: ^OpaqueLTOInput

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Creates an LTO input file from a buffer. The path
	* argument is used for diagnotics as this function
	* otherwise does not know which file the given buffer
	* is associated with.
	*
	* \since LTO_API_VERSION=24
	*/
	lto_input_create :: proc(buffer: rawptr, buffer_size: c.size_t, path: cstring) -> lto_input_t ---

	/**
	* Frees all memory internally allocated by the LTO input file.
	* Upon return the lto_module_t is no longer valid.
	*
	* \since LTO_API_VERSION=24
	*/
	lto_input_dispose :: proc(input: lto_input_t) ---

	/**
	* Returns the number of dependent library specifiers
	* for the given LTO input file.
	*
	* \since LTO_API_VERSION=24
	*/
	lto_input_get_num_dependent_libraries :: proc(input: lto_input_t) -> u32 ---

	/**
	* Returns the ith dependent library specifier
	* for the given LTO input file. The returned
	* string is not null-terminated.
	*
	* \since LTO_API_VERSION=24
	*/
	lto_input_get_dependent_library :: proc(input: lto_input_t, index: c.size_t, size: ^c.size_t) -> cstring ---

	/**
	* Returns the list of libcall symbols that can be generated by LTO
	* that might not be visible from the symbol table of bitcode files.
	*
	* \since prior to LTO_API_VERSION=25
	*/
	lto_runtime_lib_symbols_list :: proc(size: ^c.size_t) -> ^cstring ---
}

/**
* Type to wrap a single object returned by ThinLTO.
*
* \since LTO_API_VERSION=18
*/
LTOObjectBuffer :: struct {
	Buffer: cstring,
	Size:   c.size_t,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	/**
	* Instantiates a ThinLTO code generator.
	* Returns NULL on error (check lto_get_error_message() for details).
	*
	*
	* The ThinLTOCodeGenerator is not intended to be reuse for multiple
	* compilation: the model is that the client adds modules to the generator and
	* ask to perform the ThinLTO optimizations / codegen, and finally destroys the
	* codegenerator.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_create_codegen :: proc() -> thinlto_code_gen_t ---

	/**
	* Frees the generator and all memory it internally allocated.
	* Upon return the thinlto_code_gen_t is no longer valid.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_dispose :: proc(cg: thinlto_code_gen_t) ---

	/**
	* Add a module to a ThinLTO code generator. Identifier has to be unique among
	* all the modules in a code generator. The data buffer stays owned by the
	* client, and is expected to be available for the entire lifetime of the
	* thinlto_code_gen_t it is added to.
	*
	* On failure, returns NULL (check lto_get_error_message() for details).
	*
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_add_module :: proc(cg: thinlto_code_gen_t, identifier: cstring, data: cstring, length: i32) ---

	/**
	* Optimize and codegen all the modules added to the codegenerator using
	* ThinLTO. Resulting objects are accessible using thinlto_module_get_object().
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_process :: proc(cg: thinlto_code_gen_t) ---

	/**
	* Returns the number of object files produced by the ThinLTO CodeGenerator.
	*
	* It usually matches the number of input files, but this is not a guarantee of
	* the API and may change in future implementation, so the client should not
	* assume it.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_module_get_num_objects :: proc(cg: thinlto_code_gen_t) -> u32 ---

	/**
	* Returns a reference to the ith object file produced by the ThinLTO
	* CodeGenerator.
	*
	* Client should use \p thinlto_module_get_num_objects() to get the number of
	* available objects.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_module_get_object :: proc(cg: thinlto_code_gen_t, index: u32) -> LTOObjectBuffer ---

	/**
	* Returns the number of object files produced by the ThinLTO CodeGenerator.
	*
	* It usually matches the number of input files, but this is not a guarantee of
	* the API and may change in future implementation, so the client should not
	* assume it.
	*
	* \since LTO_API_VERSION=21
	*/
	thinlto_module_get_num_object_files :: proc(cg: thinlto_code_gen_t) -> u32 ---

	/**
	* Returns the path to the ith object file produced by the ThinLTO
	* CodeGenerator.
	*
	* Client should use \p thinlto_module_get_num_object_files() to get the number
	* of available objects.
	*
	* \since LTO_API_VERSION=21
	*/
	thinlto_module_get_object_file :: proc(cg: thinlto_code_gen_t, index: u32) -> cstring ---

	/**
	* Sets which PIC code model to generate.
	* Returns true on error (check lto_get_error_message() for details).
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_pic_model :: proc(cg: thinlto_code_gen_t, _: lto_codegen_model) -> lto_bool_t ---

	/**
	* Sets the path to a directory to use as a storage for temporary bitcode files.
	* The intention is to make the bitcode files available for debugging at various
	* stage of the pipeline.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_savetemps_dir :: proc(cg: thinlto_code_gen_t, save_temps_dir: cstring) ---

	/**
	* Set the path to a directory where to save generated object files. This
	* path can be used by a linker to request on-disk files instead of in-memory
	* buffers. When set, results are available through
	* thinlto_module_get_object_file() instead of thinlto_module_get_object().
	*
	* \since LTO_API_VERSION=21
	*/
	thinlto_set_generated_objects_dir :: proc(cg: thinlto_code_gen_t, save_temps_dir: cstring) ---

	/**
	* Sets the cpu to generate code for.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_cpu :: proc(cg: thinlto_code_gen_t, cpu: cstring) ---

	/**
	* Disable CodeGen, only run the stages till codegen and stop. The output will
	* be bitcode.
	*
	* \since LTO_API_VERSION=19
	*/
	thinlto_codegen_disable_codegen :: proc(cg: thinlto_code_gen_t, disable: lto_bool_t) ---

	/**
	* Perform CodeGen only: disable all other stages.
	*
	* \since LTO_API_VERSION=19
	*/
	thinlto_codegen_set_codegen_only :: proc(cg: thinlto_code_gen_t, codegen_only: lto_bool_t) ---

	/**
	* Parse -mllvm style debug options.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_debug_options :: proc(options: ^cstring, number: i32) ---

	/**
	* Test if a module has support for ThinLTO linking.
	*
	* \since LTO_API_VERSION=18
	*/
	lto_module_is_thinlto :: proc(mod: lto_module_t) -> lto_bool_t ---

	/**
	* Adds a symbol to the list of global symbols that must exist in the final
	* generated code. If a function is not listed there, it might be inlined into
	* every usage and optimized away. For every single module, the functions
	* referenced from code outside of the ThinLTO modules need to be added here.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_add_must_preserve_symbol :: proc(cg: thinlto_code_gen_t, name: cstring, length: i32) ---

	/**
	* Adds a symbol to the list of global symbols that are cross-referenced between
	* ThinLTO files. If the ThinLTO CodeGenerator can ensure that every
	* references from a ThinLTO module to this symbol is optimized away, then
	* the symbol can be discarded.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_add_cross_referenced_symbol :: proc(cg: thinlto_code_gen_t, name: cstring, length: i32) ---

	/**
	* Sets the path to a directory to use as a cache storage for incremental build.
	* Setting this activates caching.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_cache_dir :: proc(cg: thinlto_code_gen_t, cache_dir: cstring) ---

	/**
	* Sets the cache pruning interval (in seconds). A negative value disables the
	* pruning. An unspecified default value will be applied, and a value of 0 will
	* force prunning to occur.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_cache_pruning_interval :: proc(cg: thinlto_code_gen_t, interval: i32) ---

	/**
	* Sets the maximum cache size that can be persistent across build, in terms of
	* percentage of the available space on the disk. Set to 100 to indicate
	* no limit, 50 to indicate that the cache size will not be left over half the
	* available space. A value over 100 will be reduced to 100, a value of 0 will
	* be ignored. An unspecified default value will be applied.
	*
	* The formula looks like:
	*  AvailableSpace = FreeSpace + ExistingCacheSize
	*  NewCacheSize = AvailableSpace * P/100
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_final_cache_size_relative_to_available_space :: proc(cg: thinlto_code_gen_t, percentage: u32) ---

	/**
	* Sets the expiration (in seconds) for an entry in the cache. An unspecified
	* default value will be applied. A value of 0 will be ignored.
	*
	* \since LTO_API_VERSION=18
	*/
	thinlto_codegen_set_cache_entry_expiration :: proc(cg: thinlto_code_gen_t, expiration: u32) ---

	/**
	* Sets the maximum size of the cache directory (in bytes). A value over the
	* amount of available space on the disk will be reduced to the amount of
	* available space. An unspecified default value will be applied. A value of 0
	* will be ignored.
	*
	* \since LTO_API_VERSION=22
	*/
	thinlto_codegen_set_cache_size_bytes :: proc(cg: thinlto_code_gen_t, max_size_bytes: u32) ---

	/**
	* Same as thinlto_codegen_set_cache_size_bytes, except the maximum size is in
	* megabytes (2^20 bytes).
	*
	* \since LTO_API_VERSION=23
	*/
	thinlto_codegen_set_cache_size_megabytes :: proc(cg: thinlto_code_gen_t, max_size_megabytes: u32) ---

	/**
	* Sets the maximum number of files in the cache directory. An unspecified
	* default value will be applied. A value of 0 will be ignored.
	*
	* \since LTO_API_VERSION=22
	*/
	thinlto_codegen_set_cache_size_files :: proc(cg: thinlto_code_gen_t, max_size_files: u32) ---
}

