neighbors(i, j) = filter([(i-1, j), (i+1, j), (i, j-1), (i, j+1)]) do (x, y)
    1 <= x <= 100 && 1 <= y <= 100
end

function part02(file = "day09/input.txt")
    arr = []
    for line in eachline(file)
        append!(arr, parse.(Int, split(line, "")))
    end
    arr = reshape(arr, 100, 100)
    
    basins = []
    for i in 1:100
        for j in 1:100
            point = arr[i, j]
            if point != 9
                queue = []
                push!(queue, (i, j))
                size = 0
                while !isempty(queue)
                    (i, j) = pop!(queue)
                    if arr[i, j] != 9
                        size += 1
                        arr[i, j] = 9
                        append!(queue, neighbors(i, j))
                    end
                end
                push!(basins, size)
            end
        end
    end
    sort!(basins; rev = true)
    reduce(*, basins[1:3])
end

println(part02())
