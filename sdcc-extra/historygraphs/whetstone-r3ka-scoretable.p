set output "whetstone-r3ka-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set ylabel "Whetstone KIPS"
set arrow from 12085, 29.764 to 12085, 29.564
set label "4.1.0" at 12085, 29.764
plot "whetstone-r3ka-scoretable" using 1:4 title "default", "whetstone-r3ka-scoretable" using 1:2 title "size", "whetstone-r3ka-scoretable" using 1:3 title "speed"

