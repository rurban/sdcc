set output "whetstone-r3ka-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 12085, 13646 to 12085, 13596
set label "4.1.0" at 12085, 13646
set arrow from 13131, 12480 to 13131, 12380
set label "4.2.0" at 13131, 12480
set arrow from 14208, 12498 to 14208, 12398
set label "4.3.0" at 14208, 12498
plot "whetstone-r3ka-sizetable" using 1:4 title "default", "whetstone-r3ka-sizetable" using 1:2 title "size", "whetstone-r3ka-sizetable" using 1:3 title "speed"

