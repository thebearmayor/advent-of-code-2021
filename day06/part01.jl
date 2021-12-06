function day06(days, file = "day06/input.txt")
    f = open(file, "r")
    startingFish = parse.(Int, split(readline(f), ","))
    fish = zeros(Int64, 9)
    for f in startingFish
        fish[f+1] += 1
    end
    for _ in 1:days
        zs = popfirst!(fish)
        fish[7] += zs
        push!(fish, zs)
    end
    sum(fish)
end
