10 dram$="c18a129a128g17Ge128e129ha128a128Ac18hg17Ge128e129ha128a128Ac18"
90 gosub 30000:goto 1000
99 rem ----subroutines----

1000 rem ----czolowka 1----
1010 cls 0,15,15:hgr:s=2:d=2
1020 draw @31,174,dram$
1025 voice "10f620,10f620,10f620"
1026 play 1,1,2,3
1030 pause
1040 nrm

20000 end
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

