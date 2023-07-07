set output "coremark-r3ka-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 12085, 16040 to 12085, 15940
set label "4.1.0" at 12085, 16040
set arrow from 13131, 14968 to 13131, 14868
set label "4.2.0" at 13131, 14968
set arrow from 14208, 14159 to 14208, 14059
set label "4.3.0" at 14208, 14159
plot "coremark-r3ka-sizetable" using 1:4 title "default", "coremark-r3ka-sizetable" using 1:2 title "size", "coremark-r3ka-sizetable" using 1:3 title "speed"

