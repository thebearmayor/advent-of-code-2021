using SplitApplyCombine
using Memoization
using DataStructures
using Test

function day14(iterations = 10, file = "day14/input.txt")
    f = open(file, "r")
    template = readline(f)
    readline(f)
    rules = Dict{String, String}()
    for line in eachline(f)
        left, right = split(line, " -> ")
        rules[left] = right
    end

    counters = map(template, template[2:end]) do a, b
        recur(a, b, rules, iterations)
    end

    counts = merge(counters..., counter(template)) |> values |> collect
    max(counts...) - min(counts...)
end

@memoize function recur(a, b, rules, depth)
    if depth == 0
        counter(Char)
    else
        x = rules[a*b]
        merge!(counter(x), recur(a, x, rules, depth - 1), recur(x, b, rules, depth -1))
    end
end

@test day14(10, "day14/sample.txt") == 1588

# day14(10)
# day14(40)