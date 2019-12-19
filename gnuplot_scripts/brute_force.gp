# gnu plot
set key autotitle columnhead
set ylabel "Time in milliseconds"

stats '../output/brute_force' using 1:2
set title 'TSP Brute Force N vs Time (ms)'
set xlabel "N"
n = STATS_max_x
t = STATS_max_y
a = t / (gamma(n))
f(x) = a*(gamma(x))
set yrange [0:t]
set xrange [0:n]
plot '../output/brute_force' using 1:2 lw 3, f(x) lw 3