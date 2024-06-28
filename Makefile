C=main.c
ASM=telemetry.s
ASM2=compare.s
ASM3=atoi.s
ASM4=stampa_low.s
ASM5=stampa_medium.s
ASM6=stampa_high.s
ASM7=itoa.s
EXE=telemetry
OGGETTOC=ctelemetry.o
OGGETTOA=atelemtry.o
OGGETTOB=btelemetry.o
OGGETTOD=dtelemetry.o
OGGETTOE=etelemetry.o
OGGETTOF=ftelemetry.o
OGGETTOG=gtelemetry.o
OGGETTOH=htelemetry.o
all: bin/$(EXE)


obj/$(OGGETTOC):src/$(C)
	gcc -m32 -g -c src/$(C) -o obj/$(OGGETTOC)
obj/$(OGGETTOA):src/$(ASM)
	gcc -m32 -g -c src/$(ASM) -o obj/$(OGGETTOA)
obj/$(OGGETTOB):src/$(ASM2)
		gcc -m32 -g -c src/$(ASM2) -o obj/$(OGGETTOB)
obj/$(OGGETTOD):src/$(ASM3)
		gcc -m32 -g -c src/$(ASM3) -o obj/$(OGGETTOD)
obj/$(OGGETTOE):src/$(ASM4)
		gcc -m32 -g -c src/$(ASM4) -o obj/$(OGGETTOE)
obj/$(OGGETTOF):src/$(ASM5)
		gcc -m32 -g -c src/$(ASM5) -o obj/$(OGGETTOF)
obj/$(OGGETTOG):src/$(ASM6)
		gcc -m32 -g -c src/$(ASM6) -o obj/$(OGGETTOG)
obj/$(OGGETTOH):src/$(ASM7)
		gcc -m32 -g -c src/$(ASM7) -o obj/$(OGGETTOH)
bin/$(EXE):obj/$(OGGETTOC) obj/$(OGGETTOA) obj/$(OGGETTOB) obj/$(OGGETTOD) obj/$(OGGETTOE) obj/$(OGGETTOF) obj/$(OGGETTOG) obj/$(OGGETTOH)
	gcc -m32  -g obj/$(OGGETTOA) obj/$(OGGETTOC) obj/$(OGGETTOB) obj/$(OGGETTOD) obj/$(OGGETTOE) obj/$(OGGETTOF) obj/$(OGGETTOG) obj/$(OGGETTOH) -o bin/$(EXE)
clean:
	rm -f obj/* bin/*
