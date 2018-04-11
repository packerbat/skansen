10 dram$="c18a129a128g17Ge128e129ha128a128Ac18hg17Ge128e129ha128a128Ac18"
40 path 2,"h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8h8d8"
90 gosub 30000:goto 1000
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
225 shape 0,a$
330 a$="607e06f0ff0ff8ff1ffcff3feeff77e7ffe7e7ffe7e7ffe7e7ffe7e7ffe7e7ffe7"
340 a$=a$+"e7ffe7e7ffe7e77ee7e73ce7e7bde7e7ffe7ffffffffffff7ffffe07ffe0"
350 shape 1,a$
360 sprite 0,0,11,0,1
370 voice "00001000,00000000,00000000"
380 return
399 :
400 rem **** czekaj()
420 if peek(709)<>1 then 420
430 scroll "{crsr right}255",1,1,2
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
760 a$(i)="{crsr right}"+right$(b$,len(b$)-1)+a$
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
999:
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
1080 a$="Prezentuja-":gosub 100
1090 y=y+22:text@10,y,"- komputerowy informator",1,1,1
1095 y=y+16:text@162,y,"Agrofilmowej Wiosny",1,1,1
1100 y=y+22:text@10,y,"- Przewodnik po Muzeum Rolnictwa",1,1,1
1110 y=y+16:text@130,y,"im. ks. Krzysztofa Kluka",1,1,1
1120 if play(1) then 1120
1130 pause 5:scroll stop:cls:volume 0


20000 nrm:end
29999 rem ----init music----
30000 a$="a448gc5d524ge548d524ge548cda4g"
30010 a$=a$+"a448gc5d524ge548d524ge548cda4g"
30020 a$=a$+"g448aeg424ad448a424hg448g5ed524cg448"
30030 a$=a$+"g448aeg424ad448a424hg448g5ed524cg448"
30040 a$=a$+".2a448gc5d524ge548d524ge548cda4g496"
30050 music 1,a$
30095 :
30100 a$=".48.........."
30110 a$=a$+"e448deggggaaFd"
30120 a$=a$+".48......g448ggd"
30130 a$=a$+".48......g448ggd"
30140 a$=a$+".2e448deggggaaFd496"
30150 music 2,a$
30195 :
30200 a$=".48.........."
30210 a$=a$+"a348hahhhc4eddh3"
30220 a$=a$+".48......g348c4dg3"
30230 a$=a$+".48......g348c4dg3"
30240 a$=a$+".2a348hahhhc4eddh396"
30250 music 3,a$
30295 :
30300 music 4,"c524ec548"
30310 music 5,"e424ge448"
30320 music 6,"g324cg348"
30395 :
30400 music 7,"c630g629"
30410 music 8,"c71"
30900 return

