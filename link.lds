OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	. = 0x50000000;
	.text : AT(0x50000000){
		*(.text)
	}

	.data : {
		*(.data)
		*(.bss)
		*(.rodata)
	}

	/DISCARD/ : {
		*(.note.*)
		*(.ARM.*)
		*(.comment)
		*(.symtab)
		*(.startab)
		*(.shstrtab)
	}
}