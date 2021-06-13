set output "dhrystone-z80-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9256, 11002 to 9256, 10902
set label "3.5.0" at 9256, 11002
set arrow from 9618, 10819 to 9618, 10719
set label "3.6.0" at 9618, 10819
set arrow from 10582, 11111 to 10582, 11011
set label "3.8.0" at 10582, 11111
set arrow from 11214, 11356 to 11214, 11256
set label "3.9.0" at 11214, 11356
set arrow from 11533, 11470 to 11533, 11370
set label "4.0.0" at 11533, 11470
set arrow from 12085, 10894 to 12085, 10794
set label "4.1.0" at 12085, 10894
plot "dhrystone-z80-sizetable" using 1:4 title "default", "dhrystone-z80-sizetable" using 1:2 title "size", "dhrystone-z80-sizetable" using 1:3 title "speed"

