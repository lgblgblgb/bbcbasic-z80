ZMAC = ../../.obj/third_party/zmac/zmac/zmac
LD80 = ../../.obj/third_party/ld80/ld80/ld80

ZMAC = ../3rd_party/zmac/zmac
LD80 = ../3rd_party/ld80/ld80


#$(TARGETOBJPREFIX)%.o: %.c $(DEPALL)
#ifeq ($(ASMOUT), yes)
#        $(CC) $(CFLAGS) -Wa,-adhln -masm=intel -g -c -o /dev/null $< > $(@:.o=.s)
#endif
#        $(CC) $(CFLAGS) -c -o $@ $<

all:	bbcbasic.com bbcbasic-hacked.com

%.rel: %.s
	@test -x $(ZMAC) || $(MAKE) -C $(shell dirname $(ZMAC))
	$(ZMAC) --zmac -m --rel7 -z -o $@ -o $(@:.rel=.lst) $<

#.obj/third_party/ld80/ld80/ld80 -m -O bin -o .obj/third_party/bbcbasic/bbcbasic_img/bbcbasic_img.cim -s .obj/third_party/bbcbasic/bbcbasic_img/bbcbasic_img.cim.sym .obj/third_party/bbcbasic/patch/patch.rel -P0200 .obj/third_party/bbcbasic/main/main.rel .obj/third_party/bbcbasic/exec/exec.rel .obj/third_party/bbcbasic/eval/eval.rel .obj/third_party/bbcbasic/fpp/fpp.rel .obj/third_party/bbcbasic/sorry/sorry.rel .obj/third_party/bbcbasic/cmos/cmos.rel -P3b00 .obj/third_party/bbcbasic/ram/ram.rel 

bbcbasic_img.cim: exec.rel patch.rel fpp.rel main.rel ram.rel sorry.rel eval.rel cmos.rel
	@test -x $(LD80) || $(MAKE) -C $(shell dirname $(LD80))
	$(LD80) -m -O bin -o bbcbasic_img.cim -s bbcbasic_img.cim.sym patch.rel -P0200 main.rel exec.rel eval.rel fpp.rel sorry.rel cmos.rel -P3b00 ram.rel 

bbcbasic.com: bbcbasic_img.cim
	dd if=bbcbasic_img.cim of=bbcbasic.com status=none bs=128 skip=2

bbcbasic-hacked.com: bbcbasic_img.cim
	dd if=bbcbasic_img.cim of=bbcbasic-hacked.com.temp status=none bs=128 skip=4
	cat patch_old.bin bbcbasic-hacked.com.temp > bbcbasic-hacked.com


clean:
	rm -f *.rel *.lst *.com *.sym *.cim *.tmp *.temp

distclean:
	$(MAKE) -C $(shell dirname $(ZMAC)) distclean
	$(MAKE) -C $(shell dirname $(LD80)) distclean
	$(MAKE) clean
	rm -f *~ .*~


alla:
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/exec/exec.rel -o .obj/third_party/bbcbasic/exec/exec.lst  third_party/bbcbasic/exec.z80 
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/patch/patch.rel -o .obj/third_party/bbcbasic/patch/patch.lst  third_party/bbcbasic/patch.z80 
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/fpp/fpp.rel -o .obj/third_party/bbcbasic/fpp/fpp.lst  third_party/bbcbasic/fpp.z80 
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/main/main.rel -o .obj/third_party/bbcbasic/main/main.lst  third_party/bbcbasic/main.z80 
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/ram/ram.rel -o .obj/third_party/bbcbasic/ram/ram.lst  third_party/bbcbasic/ram.z80 
	$(ZMAC) --zmac -m --rel7 -z -o .obj/third_party/bbcbasic/sorry/sorry.rel -o .obj/third_party/bbcbasic/sorry/sorry.lst  third_party/bbcbasic/sorry.z80 

