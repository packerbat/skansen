10 dram$="c18a129a128g17Ge128e129ha128a128Ac18hg17Ge128e129ha128a128Ac18"
12 gram$="c145a129a130g145e130e129ha130a129c145hg144"
14 g1rm$="c145a128a129g145e128e129ha128a129c145hg144C142a24"
16 g1rm$=g1rm$+"d9e148e149h9a14E14D9c20a22A128A129a18g20c20h9g19"
20 wl$="b4c6d4ef4g6h4e5d4c6b4G14e128e129d4c6b4G14e6d4c6b4a130a138"
22 wl$=wl$+"f4e130e138g6a130a138h4"
24 ek$="e128e129c129a128a129g129ac129a6"+wl$+"G143"+wl$+"C19E16"
26 ek$=ek$+"e235ded3cdc107bcb3aba235hah3ghg107fgf3ef"
28 tb$="c179a130a129g179e130e129ha130a129c179hg179e130e129"
30 tab$="c128a200a119a128e200e119a140c128a60g128a60c128a60g112e200e119"
32 bk$="c177a128a129g177e128e129ha128a129c177g4h11g173d11h11e129e128d12Eh13"
34 bk$=bk$+"dded8hheh4a3h5a128a129c177e4a4hg177e129e128ed2ed2ed2ed"
36 ds$="a150a152h12e150e152d12c3a150a152g2c2h12h3D6C3c179d4g179C179e150e144"
38 ds$=ds$+"g176C176"
40 path 2,"h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8"
42 rem ----init music----
44 a$="a448gc5d524ge548d524ge548cda4g"
46 a$=a$+"a448gc5d524ge548d524ge548cda4g"
48 a$=a$+"g448aeg424ad448a424hg448g5ed524cg448"
50 a$=a$+"g448aeg424ad448a424hg448g5ed524cg448"
52 a$=a$+".2a448gc5d524ge548d524ge548cda4g496"
54 music 1,a$
56 :
58 a$=".48.........."
60 a$=a$+"e448deggggaaFd"
62 a$=a$+".48......g448ggd"
64 a$=a$+".48......g448ggd"
66 a$=a$+".2e448deggggaaFd496"
68 music 2,a$
70 :
72 a$=".48.........."
74 a$=a$+"a348hahhhc4eddh3"
76 a$=a$+".48......g348c4dg3"
78 a$=a$+".48......g348c4dg3"
80 a$=a$+".2a348hahhhc4eddh396"
82 music 3,a$
84 :
86 music 4,"c524ec548"
88 music 5,"e424ge448"
90 music 6,"g324cg348"
92 :
94 music 7,"c630g629"
96 music 8,"c71"
98 goto 1000
99 :
100 rem **** pisz(a$,s=szer,d=odst,p=predkosc)
110 x=160-text(a$,s,d)/2
120 text @x,y,a$,s,d,p
130 pause 15
140 return
199 :
200 rem **** stukaj(x,y,a$)
205 shift:shift
210 sy=y+49:plot x,y,0
215 for sx=sx to x+17 step -2
220 sprite 0,@sx,sy:next
225 sx=x+17:sprite 0,0,@sx,sy
230 for i=0 to len(a$)
235 b$=mid$(a$,i,1)
240 if b$<>" " then:sprite 0,1:play 1,8
250 text $b:pause 2
260 sprite 0,0:pause 1
270 sx=sx+text(b$,1,1)
280 pause 1+3*rnd(0):next
290 return
299 :
300 rem **** maszyna()
310 a$="600006f0000ff8001ffc003fee0077e700e7e700e7e700e7e700e7e700e7e700e7"
320 a$=a$+"e700e7e700e7e700e7e700e7e781e7e7c3e7ffffffffffff7ffffe07ffe0"
325 shape 0,a$
330 a$="607e06f0ff0ff8ff1ffcff3feeff77e7ffe7e7ffe7e7ffe7e7ffe7e7ffe7e7ffe7"
340 a$=a$+"e7ffe7e7ffe7e77ee7e73ce7e7bde7e7ffe7ffffffffffff7ffffe07ffe0"
350 shape 1,a$
360 sprite 0,0,11,0,1
370 voice "00001000,00000000,00000000"
380 return
399 :
400 rem **** czekaj()
420 if peek(709)<>1 then 420
430 scroll "{29}255",1,1,2
440 if scroll then 440
450 return
499 :
500 rem **** piszpion(a$,x,y,s=szer)
510 for i=1 to len(a$):b$=mid$(a$,i,1)
520 text @x-text(b$,s,0)/2,y,b$,s
530 y=y+d:next
540 return
599 :
600 rem **** rzutnik(k,x,y,b$,l,a$)
610 gosub 700: fill 0,0,12*16+12,14
620 y=24:for i=1 to k
630 text @x,y,b$(i),1,1,0,2
640 y=y+16:next
645 if l=0 then return
650 y=24:for i=1 to l
655 text @x,y,a$(i),1,1,0,2
660 y=y+16:b$(i)=a$(i):next
670 fill 0,0,0*16+1,14:k=l
680 pause 20*60
685 return
699 :
700 rem **** centrum(data)
710 read l
720 for i=1 to l:read a$
730 if left$(a$,1)="*" then a$=chr$(34)+right$(a$,len(a$)-1)+chr$(34)
750 b$=str$(int(119-text(a$,1,1)/2))
760 a$(i)="{29}"+right$(b$,len(b$)-1)+a$
770 next
780 return
799 :
900 rem **** scrollup()
910 a$="*0180*03**03**03**0388*07f8010ff0011f*033e*037c*07f8*07f0*0fe0*"
915 a$=a$+"0ffe*1ff8*1fe0*3f80*3e**78**60**80**"
920 shape 2,a$:sprite 0,2,0,0,1
930 a$="":shape 4,a$
940 sprite 1,3,11,0,1
950 path 1,"*3!30*4!30"
960 return
999 :
1000 rem ----czolowka 1----
1010 cls 0,15,15:hgr:s=2:d=2
1020 draw @31,174,dram$
1025 voice "10f620,10f620,10f620"
1026 rem play 1,1,2,3
1030 scroll cont "Wildex  &  Wildesoft           ",2,2
1040 p=1:y=8:d=3:a$="WILDEX":gosub 100
1050 y=y+18:a$="&":gosub 100
1060 y=y+18:a$="WILDESOFT":gosub 100
1070 s=1:d=4:y=y+18
1080 a$="Prezentuja{29}2:":gosub 100
1090 y=y+22:text@10,y,"- komputerowy informator",1,1,1
1095 y=y+16:text@162,y,"Agrofilmowej Wiosny",1,1,1
1100 y=y+22:text@10,y,"- Przewodnik po Muzeum Rolnictwa",1,1,1
1110 y=y+16:text@130,y,"im. ks. Krzysztofa Kluka",1,1,1
1120 if play(1) then 1120
1130 pause 5:scroll stop:cls:volume 0
1200 rem .... strona 2 ....
1210 draw @31,174,dram$
1220 scroll cont "Informator Agrofilmowej Wiosny{29}80"
1230 y=0:text@15,y,"Agrifilmowa Wiosna",2,1:text"{29}7gosci"
1240 y=y+16:text@0,y,"w{29}14Ciechanowcu{29}14juz{29}14poraz{29}10 13{29}2.{29}17Pierwsza"
1250 y=y+16:text@0,y,"impreza{29}9tego{29}9typu{29}9odbyla{29}10sie{29}10w{29}10roku 1974"
19999 :
20000 pause:nrm

