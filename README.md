# BBC-BASIC for Z80 from R.T.Russell

## Foreword and license

According to David Given (hjalfi), R.T.Russell's implementation of BBC-BASIC
for the Z80 CPU is now open source, with the zlib license, read more here:

http://cowlark.com/2019-06-14-bbcbasic-opensource/index.html

David also provided the source in his "cpmish" repository on github:

https://github.com/davidgiven/cpmish/tree/master/third_party/bbcbasic

And btw, David has nice youtube videos, like a 9 hours long one coding
vi clone for CP/M, quite an adventure/fun to watch, trust me :)

## This repositry

This repository contains my own modifications, initially mostly clean-ups,
usable Makefile, better integration of needed tools, and so on. Later, I plan
other more important changes as well, not only these 'cosmetic' ones.

## Original README from David Given

This has been massaged lightly by me, dtrg, to assemble with zmac. The main
issue is that zmac has different keyword rules to the assembler it was
originally written in, and doesn't allow labels like OR and AND. It also
ignores $ in labels, so PUSH and PUSH$ are considered the same. I've renamed
these. I've also removed the checksum verification code, as I don't have the
tool to generate the checksum and it's not really needed. Very little else
needed work.

The original source provided to me by R.T.Russell is available in the VCS.

David Given
dg@cowlark.com
