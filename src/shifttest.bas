10 hgr 1,0
20 cls
30 line 0,0,320,200:line 0,200,320,0
40 ex=32:ey=16:ew=256:eh=144
50 line ex-1,ey-1,ex+ew,ey-1:line to ex+ew,ey+eh
60 line to ex-1,ey+eh:line to ex-1,ey-1
70 for i=1 to 20
80 pause 60
90 shift
100 next
110 pause
120 nrm
