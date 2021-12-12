using DataStructures

function day12(file = "day12/input.txt")
    graph = parsefile(file)
    paths = Set{Vector{String}}()
    dfs(graph, "start", paths)
    @show length(paths)
end

function dfs(graph, node, paths = Set{Vector{String}}(), path = Vector{String}(), visited = DefaultDict(0))

    if islowercase(node[1])
        visited[node] += 1
    end

    push!(path, node)
    
    # @show path, node
    if node == "end"
        push!(paths, copy(path))
    else
        for neighbor in graph[node]
            if (neighbor in ("start", "end") && visited[neighbor] >= 1) ||
                (islowercase(neighbor[1]) && (visited[neighbor] >= 1 && max(values(visited)...) > 1))
                continue
            else
                dfs(graph, neighbor, paths, path, visited)
            end
        end
    end

    pop!(path)
    visited[node] -= 1
end


function parsefile(file)
    graph = DefaultDict{String,Set{String}}(Set{String})
    for line in eachline(file)
        left, right = split(line, "-")
        push!(graph[left], right)
        push!(graph[right], left)
    end
    graph
end

day12("day12/sample-0.txt")
# day12("day12/sample-1.txt")
# day12("day12/sample-2.txt")
day12("day12/input.txt")

