set output "stdcbench-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set ylabel "stdcbench score"
set arrow from 12085, 125 to 12085, 124
set label "4.1.0" at 12085, 125
set arrow from 13131, 127 to 13131, 126
set label "4.2.0" at 13131, 127
plot "stdcbench-r3ka-scoretable" using 1:4 title "default", "stdcbench-r3ka-scoretable" using 1:2 title "size", "stdcbench-r3ka-scoretable" using 1:3 title "speed"

