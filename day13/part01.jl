function day13(file = "day13/input.txt")
    f = open(file, "r")
    paper = zeros(Bool, 895, 1311)

    lines = split(readuntil(f, "\n\n"), "\n")
    for line in lines
        x, y = parse.(Int, split(line, ","))
        paper[y + 1, x + 1] = true
    end

    lines = readlines(f)
    for line in lines
        @show line, size(paper)
        axis, val = split(split(line)[3], "=")
        val = parse(Int, val)
        if axis == "x"
            last = size(paper, 2)
            paper = paper[:, 1:val] + reverse(paper[:, (val + 2):last]; dims = 2)
        else
            last = size(paper, 1)
            paper = paper[1:val, :] + reverse(paper[(val + 2):last, :]; dims = 1)
        end
    end

    printpaper(paper)
end

function printpaper(paper)
    height, width = size(paper)
    for j in 1:height
        for i in 1:width
            print(if paper[j, i] > 0 "#" else " " end)
        end
        println()
    end
end

day13()

