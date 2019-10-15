                                                                                                                     NAME

   ld80 - L80 replacement linker

                                                                                                                   SYNOPSYS

   ld80 -o outfile [-O oformat] [-W warns] [-s symfile] [-S symsize] [-cmV] [-U name] [-l] [-P address] [-D address] [-E address or symbol] [-C name,address] objectfile ...

== DESCRIPTION

ld80 is a replacement of the good old M$ L80 linker for CP/M and other 8 bit
operating systems on Z80/i8080 processor. ld80 incorporates almost all
capabilities of almost L80 and has extra features. It is intended as part of
your Z80 cross development toolbox.

ld80 accepts object (.REL) files produced with M80 or compatible assembler
(such as zmac) as well as library (.LIB) files made by LIB80.

== OPTIONS

Addresses below are within the 0000-FFFF range and are expressed in hexadecimal
notation. Addresses prefixed by percent (%) character as %NNNN are not absolute
but the linker is instructed to place following segments on NNNN-boundary. E.g.
-D%10 causes the following data segments to be located on paragraph (16 byte)
boundary.

   -o outfile
          Name of the output file. Output format will be set as if the file's
	  suffix were passed to the -O option.

   -P address
          address is the address where code segment of the following object
	  files will be placed. If an object file specification is not preceded
	  by -P option, code segment will be appended to the previous one. If
	  no -P option specified before the first object file, its code segment
	  will be placed to 0000.

   -D address
          address is the address where data segment of the following object files will be placed. If an object file specification is not preceded by -D option, data segment will be appended to the previous one. If no -D option
          specified before the first object file, its data segment will be appended the last code segment.

   -E address or symbol
          Set the entry point of the output to the hexadecimal address or the symbol named name. Hexadecimal addresses starting with A .. F must have 0 put in front.

   -C name,address
          address is the address where common block name will be placed. If block name name is empty string or it begins with space it will be treated as blank common block. However no extra whitespace character around of comma (,)
          allowed. name is case insensitive. Common blocks of unspecified location will be appended to the last data segment.

   -U name
          Common block named name will be "uncommon". (This sounds funny, doesn't it? :-) Normally common blocks of the same name are to be located on the same address. However blocks marked as uncommon will be concatenated like code
          or data segments. This way you can spread your code/data over several region of physical memory easy. name is case insensitive.

   -l
          The following object file is a library. ld80 will scan the file and loads modules only that satisfies unresolved external references. If a new reference to a modules passed earlier found the referenced module will not be
          loaded. However you can specify the same library more than one time in order to resolve backward references.

   -c
          Suppress data segments. The output file will contain the the code (and absolute) segments only.

   -O oformat
          Output format specification. Possible values of oformat are:

          ihex or hex: Intel hex. This is the default format.

          bin: Raw binary, gaps filled with X'00'.

          binff: Raw binary, gaps filled with X'ff'.

          cmd: TRS-80 /CMD file format.

   -W warns
          Request for warning messages. Possible value of warns is:

          extchain: Warn if ambigous external reference found. See "WARNINGS".

   -s symfile
          Name of symbol file. `-' stands for the standard output.

   -m
          Generate map. List of segment mapping will be placed into symbol file if it is specified. Otherwise the segment list will printed on standard output.

   -S symsize
          Symbol table size. Use this option if the linker has to process more than 32768 symbols.

   -V
          Print version number and exit.

                                                                                                                   WARNINGS

   The object file format used by L80 is ambigous. References to the same external symbol are chained. The last element of the chain is absolute 0000. M80 pruduces the same object file from the following assembly sources:
        ;program A                      ;program B
        EXTRN   foobar                  EXTRN   foobar
        ASEG                            ASEG
        ORG     0                       ORG     0
        DW      foobar                  DW      0
        END                             END

   L80 and ld80 cannot figure out what was your intention therefore always assumes the B version. However ld80 can warn you if this ambiguity found. Use -W extchain option to achieve this.

   Placing external reference to location absolute 0000 is possible but a bit tricky:
        ;program C
        EXTRN   foobar
        ASEG
        ORG     0
        DW      foobar/1        ; forced arithmetic fixup
        END

   In this case M80 places a newer (and more complicated) item into the object that can be handle unambigously.

                                                                                                                 RESTRICTIONS

   ld80 does not process special link item 13 (request library search). If the linker finds such an item, it prints a warning message and continues the work.

   Special link item 12 (chan address) is also unimplemented. This is because the author has never seen this kind of item. :-) ld80 will abort if it finds one.

   Extension link item X'35' (COBOL overlay segment sentinel) is also unimplemented due to the same reason. However other extension link items (known as arithmetic fixups) are fully implemented.

                                                                                                                    PORTING

   ld80 is written for and developed on Intel-Linux platform. It requires some functions of glibc2. It probably could run on big endian machines without any change, but this was never tested.

                                                                                                                     BUGS

   This manual is written in Tarzan-English.

                                                                                                                   SEE ALSO

   M$ Utility Software Manual. It can be found on the net as file m80l80.txt.

                                                                                                                    AUTHOR

   Gábor Kiss <kissg@sztaki.hu>

                                                                                                                   COPYRIGHT

   This software is copylefted.

                                                                                                                  DISCLAIMER

 This software is in the public domain.
 This software is distributed with no warranty whatever.
 The author takes no responsibility for the consequences of its use.
