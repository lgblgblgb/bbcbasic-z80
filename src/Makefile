TARGETS		= bbcbasic.com bbcbasic-cpm.com

ZMAC		= ../3rd_party/zmac/zmac
LD80		= ../3rd_party/ld80/ld80
BINSTRIP	= ../3rd_party/binstrip/binstrip

TOOLS		= $(ZMAC) $(LD80) $(BINSTRIP)

OBJS		= main.rel exec.rel eval.rel fpp.rel sorry.rel cmos.rel
START_MAIN	= 0200
OBJ_ALIGNED	= ram.rel

ALLDEP		= Makefile

all:	$(TARGETS)

$(TOOLS):
	$(MAKE) -C $(dir $@)

%.rel:	%.s $(ZMAC) $(ALLDEP)
	$(ZMAC) --zmac -m --rel7 -z -o $@ -o $(@:.rel=.lst) $<

#%.img:	patch-%.rel $(OBJS) $(OBJ_ALIGNED) $(LD80) $(ALLDEP)
#	@echo "*** Linking $@ from $< $(OBJS) $(OBJ_ALIGNED)"
#	@# First we link without alignment of ram.rel, which is BAD but we can figure out the needed alignment from this (from the sym file)
#	$(LD80) -m -O bin -o $@ -s $(@:.img=.sym) $< -P$(START_MAIN) $(OBJS) $(OBJ_ALIGNED)
#	@rm -f $@
#	@# Figure out the needed alignment ...
#	gawk '$$1 == "ACCS" { a=strtonum("0x"$$2); if (and(a,255)) printf("%04x\n",and(a,65280)+256); else print $$2; }' $(@:.img=.sym) > $(@:.img=.aligned.sym)
#	@rm -f $(@:.img=.sym)
#	@echo "+++ $(OBJ_ALIGNED) alignment is calculated to be 0x`cat $(@:.img=.aligned.sym)`"
#	@# Now, we can do the real linkage, with the calculated alignment. Ehm. Maybe I'm lame and there is a way to tell LD80 to do some alignment at its own?
#	$(LD80) -m -O bin -o $@ -s $(@:.img=.sym) $< -P$(START_MAIN) $(OBJS) -P`cat $(@:.img=.aligned.sym)` $(OBJ_ALIGNED)
#	@rm -f $(@:.img=.aligned.sym)

%.img:	patch-%.rel $(OBJS) $(OBJ_ALIGNED) $(LD80) $(ALLDEP)
	@#echo "*** Linking $@ from $< $(OBJS) $(OBJ_ALIGNED)"
	$(LD80) -m -O bin -o $@ -s $(@:.img=.sym) $< -P$(START_MAIN) $(OBJS) -P%0100 $(OBJ_ALIGNED)

%.com:	%.img $(ALLDEP)
	dd if=$< of=$@ status=none bs=128 skip=2
	@#echo "*** Output $@ is ready from image $<"

strip:	$(TARGETS) $(BINSTRIP) $(ALLDEP)
	@echo "*** WARNING *** Do not use strip unless you are sure the code contains a routine which makes the stripped area zero at least on run-time ***"
	for a in $(TARGETS) ; do $(BINSTRIP) $$a ; done

clean:
	rm -f *.rel *.lst *.com *.sym *.cim *.img *.tmp *.temp

distclean:
	for a in $(dir $(TOOLS)) ; do $(MAKE) -C $$a distclean ; done
	$(MAKE) clean
	rm -f *~ .*~

.SECONDARY:

.PHONY:	all clean distclean strip
