set output "dhrystone-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set ylabel "Dhrystones per second"
set arrow from 12085, 4207 to 12085, 4107
set label "4.1.0" at 12085, 4207
set arrow from 13131, 5025 to 13131, 4925
set label "4.1.0" at 13131, 5025
plot "dhrystone-r3ka-scoretable" using 1:4 title "default", "dhrystone-r3ka-scoretable" using 1:2 title "size", "dhrystone-r3ka-scoretable" using 1:3 title "speed"

