function part01(file = "day08/input.txt")
    map(readlines(file)) do line
        output = split(line, " | ")[2]
        values = split(output)
        count(x -> length(x) in (2, 3, 4, 7), values)
    end |> sum
end

part01()