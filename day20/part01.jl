function parsefile(file)
    key = []
    init = Set()
    y = 1
    miny = 1
    minx = 1
    maxy = 1
    maxx = 1
    open(file) do f
        key = readuntil(f, "\n\n") |> collect
        key = replace(key, '.' => 0, '#' => 1)

        for (y, line) in enumerate(readlines(f))
            maxy = max(maxy, y)
            for x in eachindex(line)
                if line[x] == '#'
                    push!(init, (y, x))
                    maxx = max(maxx, x)
                end
            end
        end
    end
    (key, init, miny, minx, maxy, maxx)
end

function day20(file = "day20/input.txt")
    key, init, miny, minx, maxy, maxx = parsefile(file)
    next = init
    border = 0
    for i in 1:50
        next, miny, minx, maxy, maxx, border = step(key, next, miny, minx, maxy, maxx, border)
    end
    length(next)
end

neighbors(y, x) = [(ny, nx) for ny=y-1:y+1 for nx=x-1:x+1]

function step(key, init, miny, minx, maxy, maxx, border)
    next = Set()
    for y=miny-2:maxy+2, x = minx-2:maxx+2
        ns = neighbors(y, x)
        ns = map(ns) do n
            if miny <= n[1] <= maxy && minx <= n[2] <= maxx
                if n in init '1' else '0' end
            else
                border
            end
        end
        k = ns |> join |> b -> parse(Int64, b; base=2)
        if key[k + 1] == 1
            push!(next, (y, x))
        end
    end
    border = if (miny - 2, minx - 2) in next 1 else 0 end
    (next, miny - 2, minx - 2, maxy + 2, maxx + 2, border)
end

function show(init, miny, minx, maxy, maxx)
    for y=miny-1:maxy+1
        for x=minx-1:maxx+1
            print(if (y, x) in init '#' else '.' end)
        end
        println()
    end
    println()
end

