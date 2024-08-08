NAME=loop
all: $(NAME).o
	ld -o $(NAME) $(NAME).o
	rm *.o

%.o: %.asm
	nasm -g -f elf64 $<
