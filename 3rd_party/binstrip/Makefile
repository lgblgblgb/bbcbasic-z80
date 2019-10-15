CC	= gcc
CCFLAGS	= -Wall

all:	binstrip

binstrip: binstrip.c Makefile
	$(CC) $(CCFLAGS) -o $@ $<

clean:
	rm -f *.o binstrip

distclean:
	$(MAKE) clean
	rm -f *~ .*~

.PHONY:	all clean distclean
