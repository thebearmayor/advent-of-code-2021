f = open("input.txt", "r")


z = (0, 0)
(x, y) = foldl(readlines(f); init=z) do (x, y), line
    dir, size = split(line)
    size = parse(Int64, size)
    if dir == "up"
        (x, y - size)
    elseif dir == "down"
        (x, y + size)
    elseif dir == "forward"
        (x + size, y)
    else
        throw(Exception)
    end
end

println(x)
println(y)
println(x * y)