set output "dhrystone-r3ka-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 12085, 9880 to 12085, 9860
set label "4.1.0" at 12085, 9880
set arrow from 13131, 8827 to 13131, 8807
set label "4.2.0" at 13131, 8827
plot "dhrystone-r3ka-sizetable" using 1:4 title "default", "dhrystone-r3ka-sizetable" using 1:2 title "size", "dhrystone-r3ka-sizetable" using 1:3 title "speed"

