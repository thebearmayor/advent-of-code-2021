f = open("day03/input.txt", "r")
lines = readlines(f)

gamma = 0
epsilon = 0

for pos in 1:12
    zeroes = 0
    ones = 0
    for line in lines
        if line[pos] == '0'
            zeroes += 1
        else
            ones += 1
        end
    end
    if zeroes > ones
        global gamma = gamma * 2
        global epsilon = epsilon * 2 + 1
    else
        global gamma = gamma * 2 + 1
        global epsilon = epsilon * 2
    end
end

println(gamma * epsilon)
