# Steps to reproduce this issue

**Ensure GCC cross toolchain is installed (arm-linux-gnueabi-gcc)**

Build it

```
make
```

Use following command to run
```
qemu-system-arm \
	-nographic \
	-cpu cortex-a7 \
	-M virt,virtualization=on \
	-m 1G \
	-kernel el2.elf
```
