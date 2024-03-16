.section .text
.global _start
_start:
	/* Loading EL2 exception table */
	adrl	r0, _vector_start_el2
	mcr	15, 4, r0, c12, c0, 0
	/* Loading EL1 exception table */
	adrl	r0, _vector_start_el1
	mcr	15, 0, r0, c12, c0, 0
	/* Initialize Stacks */
	adrl	r0, __initial_stack_bottom
	mov	sp, r0
	bl	main
	b	.

.global _undefined_handler_el2
.global undefined_handler_el2
_undefined_handler_el2:
	b	undefined_handler_el2
	b	.

.global hyp_entry
.global _hyp_entry
_hyp_entry:
	b	hyp_entry
	b	.

.align 8
.global _vector_start_el2
_vector_start_el2:
	b	_start
	b	_undefined_handler_el2
	b	.
	b	.
	b	.
	b	_hyp_entry	/* hyp mode entry from lower EL */
	b	.
	b	.

.global _undefined_handler_el1
.global undefined_handler_el1
_undefined_handler_el1:
	b	undefined_handler_el1
	b	.

.align 8
.global _vector_start_el1
_vector_start_el1:
	b	.
	b	_undefined_handler_el1	/* EL1 undefined handler */
	b	.
	b	.
	b	.
	b	.
	b	.
	b	.

.global jumping_to_el1
jumping_to_el1:
	mov	r0, #0x13
	msr	spsr_hyp, r0
	msr	elr_hyp, lr
	mov	r0, sp
	msr	sp_svc, r0
	msr	sp_und, r0
	isb
	eret

.align 12
.global __initial_stack
__initial_stack_top:
	.skip 0x1000
__initial_stack_bottom: