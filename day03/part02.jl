f = open("day03/input.txt", "r")
lines = readlines(f)

diags = map(b -> parse(Int, b, base=2), lines)





function oxygen(diags, start = 11)
    bit = start
    while length(diags) > 1
        common_bit = mcb(diags, bit, 1)
        diags = filter(x -> (x & 1<<bit)>>bit == common_bit, diags)
        bit -= 1
    end
    diags[1]
end

function co2(diags, start = 11)
    bit = start
    while length(diags) > 1
        common_bit = lcb(diags, bit, 0)
        diags = filter(x -> (x & 1<<bit)>>bit == common_bit, diags)
        bit -= 1
    end
    diags[1]
end

function mcb(diags, bit, default)
    ones = count(x -> x & 1<<bit > 0, diags)
    if ones == length(diags) / 2
        default
    elseif ones > length(diags) / 2
        1
    else
        0
    end
end

function lcb(diags, bit, default)
    ones = count(x -> x & 1<<bit > 0, diags)
    if ones == length(diags) / 2
        default
    elseif ones > length(diags) / 2
        0
    else
        1
    end
end

println(oxygen(diags) * co2(diags))