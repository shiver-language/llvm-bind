/*===-- llvm-c/blake3.h - BLAKE3 C Interface ----------------------*- C -*-===*\
|*                                                                            *|
|* Released into the public domain with CC0 1.0                               *|
|* See 'llvm/lib/Support/BLAKE3/LICENSE' for info.                            *|
|* SPDX-License-Identifier: CC0-1.0                                           *|
|*                                                                            *|
|*===----------------------------------------------------------------------===*|
|*                                                                            *|
|* This header declares the C interface to LLVM's BLAKE3 implementation.      *|
|* Original BLAKE3 C API: https://github.com/BLAKE3-team/BLAKE3/tree/1.3.1/c  *|
|*                                                                            *|
|* Symbols are prefixed with 'llvm' to avoid a potential conflict with        *|
|* another BLAKE3 version within the same program.                            *|
|*                                                                            *|
\*===----------------------------------------------------------------------===*/
package llvm

import "core:c"

foreign import lib "llvm-install/lib/LLVM-C.lib"


LLVM_BLAKE3_VERSION_STRING :: "1.8.2"
LLVM_BLAKE3_KEY_LEN        :: 32
LLVM_BLAKE3_OUT_LEN        :: 32
LLVM_BLAKE3_BLOCK_LEN      :: 64
LLVM_BLAKE3_CHUNK_LEN      :: 1024
LLVM_BLAKE3_MAX_DEPTH      :: 54

// This struct is a private implementation detail. It has to be here because
// it's part of llvm_blake3_hasher below.
llvm_blake3_chunk_state :: struct {
	cv:                [8]u32,
	chunk_counter:     u64,
	buf:               [64]u8,
	buf_len:           u8,
	blocks_compressed: u8,
	flags:             u8,
}

llvm_blake3_hasher :: struct {
	key:          [8]u32,
	chunk:        llvm_blake3_chunk_state,
	cv_stack_len: u8,

	// The stack size is MAX_DEPTH + 1 because we do lazy merging. For example,
	// with 7 chunks, we have 3 entries in the stack. Adding an 8th chunk
	// requires a 4th entry, rather than merging everything down to 1, because we
	// don't know whether more input is coming. This is different from how the
	// reference implementation does things.
	cv_stack: [1760]u8,
}

@(default_calling_convention="c", link_prefix="LLVM")
foreign lib {
	llvm_blake3_version                    :: proc() -> cstring ---
	llvm_blake3_hasher_init                :: proc(self: ^llvm_blake3_hasher) ---
	llvm_blake3_hasher_init_keyed          :: proc(self: ^llvm_blake3_hasher, key: ^[32]u8) ---
	llvm_blake3_hasher_init_derive_key     :: proc(self: ^llvm_blake3_hasher, _context: cstring) ---
	llvm_blake3_hasher_init_derive_key_raw :: proc(self: ^llvm_blake3_hasher, _context: rawptr, context_len: c.size_t) ---
	llvm_blake3_hasher_update              :: proc(self: ^llvm_blake3_hasher, input: rawptr, input_len: c.size_t) ---
	llvm_blake3_hasher_finalize            :: proc(self: ^llvm_blake3_hasher, out: ^u8, out_len: c.size_t) ---
	llvm_blake3_hasher_finalize_seek       :: proc(self: ^llvm_blake3_hasher, seek: u64, out: ^u8, out_len: c.size_t) ---
	llvm_blake3_hasher_reset               :: proc(self: ^llvm_blake3_hasher) ---
}

