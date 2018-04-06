TARGETS = wpbasic.bin plfontslg.prg skansen.d64
OBJS = nrm.o hgr.o wait.o nstop.o nor.o token.o list.o doit.o tev.o \
       tknew.o tkink.o tkhgr.o tknrm.o tkcolour.o tkpause.o tkcls.o tkbasic.o tksei.o tkcli.o tkvolume.o \
       fnscroll.o getl.o num.o fnd.o gett.o lett.o geta.o cxy.o xyc.o pot.o czek.o tktext.o \
       tkplot.o getk.o getpk.o tkline.o \
       getd.o orot.o dod.o tkdraw.o tkfill.o \
       cod.o fntext.o fnplay.o \
       nuta.o hex.o getn.o tkmusic.o \
       tkplay.o tkvoice.o mirq.o irq.o

all: $(TARGETS)

skansen.d64: wpbasic.prg plfontslg.prg
	rm -f skansen.d65
	c1541 -format diskname,id d64 skansen.d64 -attach skansen.d64 -write wpbasic.prg wpbasic -write plfontslg.prg plfontslg

plfontslg.prg: plfontslg.o
	ld65 -v -Ln plfontslg.lbl -C plfontslg.cfg -o $@ plfontslg.o c64.lib

wpbasic.prg: bootloader.o wpbasic.bin
	ld65 -v -Ln bootloader.lbl -C bootloader.cfg -o $@ bootloader.o c64.lib

wpbasic.bin: init.o wpbasic.lib
	ld65 -v -Ln wpbasic.lbl -C skansen.cfg -o $@ init.o wpbasic.lib c64.lib

wpbasic.lib: $(OBJS)
	rm -f wpbasic.lib
	ar65 r wpbasic.lib $(OBJS)

%.o: %.s
	ca65 -t c64 -v -g -o $@ $<

clean:
	rm -f *.o *.lib *.prg *.lbl *.d64 *.bin
