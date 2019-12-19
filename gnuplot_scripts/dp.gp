# gnu plot
set key autotitle columnhead
set ylabel "Time in milliseconds"

stats '../output/dp' using 1:2
set title 'TSP DP N vs Time (ms)'
set xlabel "N"
n = STATS_max_x
t = STATS_max_y
a = t / (2**n)
f(x) = a*(2**x)
set yrange [0:t]
set xrange [0:n]
plot '../output/dp' using 1:2 lw 3 , f(x) lw 3