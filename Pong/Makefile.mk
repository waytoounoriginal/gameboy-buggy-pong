CC = lcc
CFLAGS = -Wa-l -Wl-m -Wl-j
LDFLAGS =
EMULATOR = bgb
EMULATOR_FLAGS =
BIN = pong.gb

all: $(BIN)

run: $(BIN)
	$(EMULATOR) $(EMULATOR_FLAGS) $(BIN)

$(BIN):	main.o character.o engine.o tools.o
	$(CC) $(LDFLAGS) -o $(BIN) $^

character.o: character.c
	$(CC) $(CFLAGS) -c -o character.o character.c

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c


engine.o: engine.c
	$(CC) $(CFLAGS) -c -o engine.o engine.c

tools.o: tools.c
	$(CC) $(CFLAGS) -c -o tools.o tools.c

clean:
	rm -f *.o *.map *.gb *.lst *.asm *.sym *.sav *ihx

compile-docker:
	docker run -v $(PWD):/app -w /app caiotava/gameboy-dev make