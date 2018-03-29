10 hgr 1,0
20 cls
30 dram$="a10A10b10B10c10C10d10D10e10E10f10F10g10G10h10H10"
40 for i=0 to 7
50 draw @160,100,dram$,i,0,2
60 pause 30
70 draw @160,100,dram$,i,0,2
80 next
100 nrm
