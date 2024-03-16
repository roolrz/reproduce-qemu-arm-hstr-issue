CC = arm-linux-gnueabi-gcc
LD = arm-linux-gnueabi-gcc
OBJCOPY = arm-linux-gnueabi-objdump

C_OBJS = $(patsubst %.c, %.o, $(wildcard *.c))
ASM_OBJS = $(patsubst %.S, %.o, $(wildcard *.S))
OBJS = $(ASM_OBJS)
OBJS += $(C_OBJS)

LDFALGS = -mcpu=cortex-a15 -nostdlib -static -Tlink.lds -g
CFLAGS = -mcpu=cortex-a15 -nostdlib -fno-stack-protector -no-pie -g -O0
TARGET = el2.elf

all : $(TARGET) FORCE

$(TARGET) : $(OBJS)
	$(CC) -o $@ $(LDFALGS) $^

%.o : %.S
	$(CC) -o $@ -mcpu=cortex-a15 -c $<

%.o : %.c
	$(CC) -o $@ $(CFLAGS) -c $<

FORCE: ;

clean:
	@rm -f $(OBJS) $(TARGET)
