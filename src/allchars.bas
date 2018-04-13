10 print chr$(147)
20 for i=33 to 63
30 print chr$(i);
40 next
50 print
60 for i=65 to 95
70 print chr$(i);
80 next
90 print
100 for i=161 to 191
110 print chr$(i);
120 next
130 print
140 for i=193 to 223
150 print chr$(i);
160 next
190 print
200 for j=0 to 7
210 for i=0 to 3
220 n=160+j*4+i
230 print n;:print" ";:print chr$(n);
240 next
250 print
260 next
