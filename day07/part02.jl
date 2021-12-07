using IterTools

triangle(n) = (n * (n - 1)) ÷ 2

function part02(file = "day07/input.txt")
    f = open(file, "r")
    crabs = [parse(Int64, s) for s in split(readline(f), ",")]
    candidates = map(min(crabs...):max(crabs...)) do candidate
        costs = sum([triangle(abs(crab - candidate) + 1) for crab in crabs])
    end
    min(candidates...)
end

part02()
