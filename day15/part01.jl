using DataStructures

function day15(file)
    graph = []
    for line in eachline(file)
        append!(graph, parse.(Int8, split(line, "")))
    end
    graph = transpose(reshape(graph, 100, 100))
    hgraph = copy(graph)
    for _ in 2:5
        map!(x -> x % 9 + 1, graph, graph)
        hgraph = hcat(hgraph, graph)
    end
    fullgraph = copy(hgraph)
    for _ in 2:5
        map!(x -> x % 9 + 1, hgraph, hgraph)
        fullgraph = vcat(fullgraph, hgraph)
    end
    @show size(fullgraph)


    dist = dijkstra(fullgraph)
    @show dist[end, end]
end

neighbors((y,x)) = [(y-1,x), (y+1,x), (y,x-1), (y,x+1)]

function dijkstra(graph)
    dist = fill(100000, 500, 500)
    queue = PriorityQueue()

    dist[(1,1)...] = 0
    for y in 1:500
        for x in 1:500
            queue[(y, x)] = dist[(y, x)...]
        end
    end

    while !isempty(queue)
        node, d = dequeue_pair!(queue)

        for neighbor in neighbors(node)
            try
                candidate = dist[node...] + graph[neighbor...]
                dist[neighbor...] = min(dist[neighbor...], candidate)
                if haskey(queue, neighbor)
                    queue[neighbor] = dist[neighbor...]
                end
            catch
            end
        end
    end
    dist
end

day15("day15/input.txt")