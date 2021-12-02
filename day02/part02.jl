f = open("input.txt", "r")


z = (0, 0, 0)
(x, y, aim) = foldl(readlines(f); init=z) do (x, y, aim), line
    dir, size = split(line)
    size = parse(Int64, size)
    if dir == "up"
        (x, y, aim - size)
    elseif dir == "down"
        (x, y, aim + size)
    elseif dir == "forward"
        (x + size, y + aim * size, aim)
    else
        throw(Exception)
    end
end

println(x)
println(y)
println(x * y)