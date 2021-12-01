using IterTools

f = open("input.txt", "r")

measurements = map(line -> parse(Int64, line), readlines(f))
sums = map(sum, partition(measurements, 3, 1))
diffs = map(x -> x[2] - x[1], partition(sums, 2, 1))
c = count(x -> x > 0, diffs)
println(c)