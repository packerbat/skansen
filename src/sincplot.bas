10 hgr 0,1
20 cls
30 line 160,0,160,200
40 line 0,100,320,100
50 x=0.1*(0-160)+1e-6
60 plot 0,100-100*sin(x)/x,1
70 for i=1 to 319
80 x=0.1*(i-160)+1e-6
90 line to i,100-100*sin(x)/x
100 next
110 pause
120 nrm
