extern int jumping_to_el1(void);
extern void string_out(char *s);

int test_prepare(void) {
	/* Setting HSTR for c12, to trap all c12 access */
	unsigned long hstr_val = 0x1 << 12;
	asm volatile("mcr 15, 4, %0, c1, c1, 3" : "=r"(hstr_val) :: "memory");
	/* Disable Stage 2 MMU */
	unsigned long hcr_val = 0x0;
	asm volatile("mcr 15, 4, %0, c1, c1, 0" : "=r"(hcr_val) :: "memory");
	/* Setting SCTLR_EL1 */
	unsigned long sctlr_val = 0x0;
	asm volatile("mcr 15, 0, %0, c1, c0, 0" : "=r"(hcr_val) :: "memory");
}

int test(void) {
	test_prepare();

	string_out("Jumping to el1\n");
	jumping_to_el1();
	string_out("el1 reached, triggering trap\n");

	/* Attempting to read VBAR_EL1 in EL1, should trigger trap to EL2 */
	asm volatile("mrc 15, 0, r0, c12, c0, 0" ::: "memory");
}