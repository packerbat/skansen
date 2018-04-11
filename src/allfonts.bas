10 hgr
20 cls 0,15,15
30 y=8
40 text @0,y,chr$(33),1,3
50 for i=34 to 63
60 text chr$(i),1,3
70 next
80 y=y+16
90 text @0,y,chr$(65),1,3
100 for i=66 to 95
110 text chr$(i),1,3
120 next
130 y=y+16
140 text @0,y,chr$(161),1,3
150 for i=162 to 191
160 text chr$(i),1,3
170 next
180 y=y+16
190 text @0,y,chr$(193),1,3
200 for i=194 to 223
210 text chr$(i),1,3
220 next
230 pause
240 nrm
