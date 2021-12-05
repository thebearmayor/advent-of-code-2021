using SplitApplyCombine

function part01(file = "day05/input.txt")
    points = []
    for line in eachline(file)
        components = parse.(Int, split(line, r",| -> ", limit=4))
        x1, y1, x2, y2 = components[1], components[2], components[3], components[4]
        if x1 == x2
            step = y1 < y2 ? 1 : -1 
            for y in y1:step:y2
                push!(points, (x1, y))
            end
        elseif y1 == y2
            step = x1 < x2 ? 1 : -1
            for x in x1:step:x2
                push!(points, (x, y1))
            end
        end
    end
    res = count(v -> length(v) > 1, values(group(identity, points)))
    println(res)
end
            
# part01("day05/sample.txt")
part01("day05/input.txt")