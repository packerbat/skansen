TARGETS = wpbasic.bin skansen.d64
OBJS = nrm.o hgr.o wait.o nstop.o nor.o token.o list.o doit.o tev.o tkink.o tkhgr.o tknrm.o tkcolour.o tkpause.o tkcls.o tkbasic.o tksei.o tkcli.o tkvolume.o fnscroll.o

all: $(TARGETS)

skansen.d64: wpbasic.prg
	c1541 -format diskname,id d64 skansen.d64 -attach skansen.d64 -write wpbasic.prg wpbasic

wpbasic.prg: bootloader.o wpbasic.bin
	ld65 -v -Ln bootloader.lbl -C bootloader.cfg -o $@ bootloader.o c64.lib

wpbasic.bin: init.o wpbasic.lib
	ld65 -v -Ln wpbasic.lbl -C skansen.cfg -o $@ init.o wpbasic.lib c64.lib

wpbasic.lib: $(OBJS)
	ar65 r wpbasic.lib $(OBJS)

%.o: %.s
	ca65 -t c64 -v -U -g -o $@ $<

clean:
	rm *.o *.lib *.prg *.lbl *.d64 *.bin