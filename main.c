#define PL011_BASE 0x9000000
#define PL011_REG_DR	(PL011_BASE + 0x0)
#define PL011_REG_FR	(PL011_BASE + 0x18)
#define PL011_FR_BUSY_MSK	0x8

void serial_out(char ch) {
	while ((*(volatile int *)(PL011_REG_FR) & PL011_FR_BUSY_MSK) != 0);

	*(volatile int *)(PL011_REG_DR) = ch;
}

void string_out(char *s) {
	while (*s != '\0') {
		serial_out(*s++);
	}
}

void undefined_handler_el2(void) {
	string_out("EL2 undefined sync triggered\n");
}

void undefined_handler_el1(void) {
	string_out("EL1 undefined sync triggered\n");
}

void hyp_entry(void) {
	string_out("EL2 trap triggered\n");
}

extern int test(void);
int main(void) {
	string_out("EL2 Booted\n");

	test();

	while(1);
}
