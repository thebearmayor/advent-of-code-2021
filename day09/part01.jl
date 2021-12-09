function part01(file = "day09/input.txt")
    arr = []
    for line in eachline(file)
        append!(arr, parse.(Int, split(line, "")))
    end
    arr = reshape(arr, 100, 100)
    result = 0
    for i in 1:100
        for j in 1:100
            point = arr[i, j]
            neighbors = filter([(i-1, j), (i+1, j), (i, j-1), (i, j+1)]) do (x, y)
                1 <= x <= 100 && 1 <= y <= 100
            end
            if all(((x, y),) -> arr[x, y] > point, neighbors)
                result += point + 1
            end
        end
    end
    result      
end

part01()
