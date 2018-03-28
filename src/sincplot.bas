10 hgr 1,0
20 cls
30 line 160,0,160,200
40 line 0,100,320,100
50 ink 3
60 x=0.1*(0-160)+1e-6
70 plot 0,100-100*sin(x)/x,1
80 for i=1 to 319
90 x=0.1*(i-160)+1e-6
100 line to i,100-100*sin(x)/x
110 next
120 pause
130 nrm
