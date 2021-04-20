set output "whetstone-r3ka-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 12085, 13646 to 12085, 13596
set label "4.1.0" at 12085, 13646
plot "whetstone-r3ka-sizetable" using 1:4 title "default", "whetstone-r3ka-sizetable" using 1:2 title "size", "whetstone-r3ka-sizetable" using 1:3 title "speed"

