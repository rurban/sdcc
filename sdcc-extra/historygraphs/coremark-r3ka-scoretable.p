set output "coremark-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 11533, 6.451 to 11533, 6.151
set label "4.0.0" at 11533, 6.451
plot "coremark-r3ka-scoretable" using 1:4 title "default", "coremark-r3ka-scoretable" using 1:2 title "size", "coremark-r3ka-scoretable" using 1:3 title "speed"

