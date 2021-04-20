set output "dhrystone-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 12085, 4207 to 12085, 4107
set label "4.1.0" at 12085, 4207
plot "dhrystone-r3ka-scoretable" using 1:4 title "default", "dhrystone-r3ka-scoretable" using 1:2 title "size", "dhrystone-r3ka-scoretable" using 1:3 title "speed"

