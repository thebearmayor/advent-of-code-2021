using IterTools

function part01(file = "day07/input.txt")
    f = open(file, "r")
    crabs = [parse(Int64, s) for s in split(readline(f), ",")]
    candidates = map(min(crabs...):max(crabs...)) do candidate
        costs = sum([abs(crab - candidate) for crab in crabs])
    end
    min(candidates...)
end

part01()

