using SplitApplyCombine

function step(n1, n2)
    if n1 < n2
        1
    elseif n1 == n2
        0
    else
        -1
    end
end

function part02(file = "day05/input.txt")
    points = Dict{Tuple{Int64, Int64}, Int64}()
    for line in eachline(file)
        components = parse.(Int, split(line, r",| -> ", limit=4))
        x1, y1, x2, y2 = components[1], components[2], components[3], components[4]
        xStep = step(x1, x2)
        yStep = step(y1, y2)
        x, y = x1, y1
        while true
            points[x,y] = get(points, (x, y), 0) + 1
            if x == x2 && y == y2
                break
            end
            x += xStep
            y += yStep
        end
    end
    res = count(>(1), values(points))
    println(res)
end
            
# part02("day05/sample.txt")
part02("day05/input.txt")