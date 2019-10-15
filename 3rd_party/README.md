In this directory you can find third party tools needed to build BBCBASIC-Z80.
To avoid author and/or license problems / misinterpretations, I try to collect
the information here about the tools, their purpose, the author and the license.

You should read the README/COPYING/etc files of the corresponding source packs
though in the sub-directories instead!

## LD80

ld80 is a replacement of the good old M$ L80 linker for CP/M and other 8 bit
operating systems on Z80/i8080 processor. ld80 incorporates almost all
capabilities of almost L80 and has extra features. It is intended as part of
your Z80 cross development toolbox. ld80 accepts object (.REL) files produced
with M80 or compatible assembler (such as zmac) as well as library (.LIB)
files made by LIB80.

Author: Gábor Kiss <kissg@sztaki.hu>

License: "This software is in the public domain."

## ZMAC

Macro cross-assembler for the Zilog Z80 microprocessor. This assembler is
modeled after the Intel 8080 macro cross-assembler for the Intel 8080 by Ken
Borgendale.

Author: Bruce Norskog 4/78

License: "This is a difficult area, partly because I'm not a lawyer. :-) None
of them seemed to explicitly give away their copyright, but equally, none
of them asserted it either. If you really want to be sure that it's all
entirely public domain ..."

## BINSTRIP

This very little and very stupid tool was written by myself. There are two
goals here:

* To avoid using the "dd" trick to "extract" the binary from the "memory
image" LD80 produces.

* Ability to "strip" the resulting binaries from trailing zeroes to decrease
the size of the result. NOTE, that it can be a problem, if that memory area
is not cleared to zero, so you should want to do that in code. Yes, it needs
some code, but certainly less space needed for that code than having the
long sequence of zero bytes in your binary.

Author: LGB (Gábor Lénárt) <lgblgblgb@gmail.com> (hey, that's me!)

License: zlib license
