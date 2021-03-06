/* Definitions of target machine for GCC, for SPARC running Solaris 2
   using the GNU assembler.
   Copyright (C) 2004, 2005, 2010 Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 3, or (at your option) any later
version.

GCC is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

Under Section 7 of GPL version 3, you are granted additional
permissions described in the GCC Runtime Library Exception, version
3.1, as published by the Free Software Foundation.

You should have received a copy of the GNU General Public License and
a copy of the GCC Runtime Library Exception along with this program;
see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
<http://www.gnu.org/licenses/>.  */

/* Undefine this as the filler pattern doesn't work with GNU as.  */
#undef ASM_OUTPUT_ALIGN_WITH_NOP

/* Undefine this so that BNSYM/ENSYM pairs are emitted by STABS+.  */
#undef NO_DBX_BNSYM_ENSYM

/* Use GNU extensions to TLS support.  */
#ifdef HAVE_AS_TLS
#undef TARGET_SUN_TLS
#undef TARGET_GNU_TLS
#define TARGET_SUN_TLS 0
#define TARGET_GNU_TLS 1
#endif

/* Use default ELF section syntax.  */
#undef TARGET_ASM_NAMED_SECTION
#define TARGET_ASM_NAMED_SECTION default_elf_asm_named_section

/* And standard pushsection syntax.  While GNU as supports the non-standard
   variant too, we prefer the former.  */
#undef PUSHSECTION_FORMAT
#define PUSHSECTION_FORMAT "\t.pushsection\t%s\n"
