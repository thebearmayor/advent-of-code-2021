using SplitApplyCombine

function parseoutput(output, mappings)
    norm = Set(map(x -> mappings[x], output))
    numbers = Dict(
        Set("abcefg") => 0,
        Set("cf") => 1,
        Set("acdeg") => 2,
        Set("acdfg") => 3,
        Set("bcdf") => 4,
        Set("abdfg") => 5,
        Set("abdefg") => 6,
        Set("acf") => 7,
        Set("abcdefg") => 8,
        Set("abcdfg") => 9
    )
    numbers[norm]
end


function part02(file = "day08/input.txt")
    total = 0
    for line in eachline(file)
        input = split(line, " | ")[1]
        inputs = group(length, split(input))
        one = only(inputs[2])
        four = only(inputs[4])
        seven = only(inputs[3])
        a = only(setdiff(seven, one))
        six = only(filter(s -> !isempty(setdiff(seven, s)), inputs[6]))
        c = only(setdiff(seven, six))
        f = only(setdiff(seven, [a, c]))
        nine = only(filter(s -> isempty(setdiff(four, s)), inputs[6]))
        zero = only(setdiff(inputs[6], [six, nine]))
        eight = only(inputs[7])
        d = only(setdiff(eight, zero))
        b = only(setdiff(four, [c, d, f]))
        g = only(setdiff(nine, [a, b, c, d, f]))
        e = only(setdiff(eight, [a, b, c, d, f, g]))
        mappings = Dict(a => 'a', b => 'b', c => 'c', d => 'd', e => 'e', f => 'f', g => 'g')

        outputs = split(split(line, " | ")[2])
        value = foldl(outputs; init = 0) do v, output
            10 * v + parseoutput(output, mappings)
        end
        total += value
        
    end
    total
end

part02()