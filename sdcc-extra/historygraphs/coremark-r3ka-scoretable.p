set output "coremark-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set ylabel "Coremark iterations / s"
set arrow from 12085, 2.238 to 12085, 2.138
set label "4.1.0" at 12085, 2.238
plot "coremark-r3ka-scoretable" using 1:4 title "default", "coremark-r3ka-scoretable" using 1:2 title "size", "coremark-r3ka-scoretable" using 1:3 title "speed"

