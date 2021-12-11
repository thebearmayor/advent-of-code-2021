using DataStructures

function findneighbors(flashing, octopi)
    i, j = flashing.I
    filter(!=(flashing), CartesianIndices((i-1:i+1, j-1:j+1)))
end


function part01(file, steps)
    octopi = Vector{Int}()
    for line in eachline(file)
        append!(octopi, parse.(Int, split(line, "")))
    end
    octopi = transpose(reshape(octopi, 10, 10))

    flashes = 0
    for step = 1:steps
        flashed = Set{CartesianIndex}()
        toflash = Queue{CartesianIndex}()
        # Increase energy
        octopi .+= 1
        # Queue up flashing octopi
        for octopus in findall(>(9), octopi)
            enqueue!(toflash, octopus)
        end

        # Do all the flashes
        while !isempty(toflash)
            flashing = dequeue!(toflash)

            push!(flashed, flashing)
            flashes += 1
            neighbors = findneighbors(flashing, octopi)
            for neighbor in neighbors
                try
                    octopi[neighbor] += 1
                    if octopi[neighbor] > 9 && !in(neighbor, flashed) && !in(neighbor, toflash)
                        enqueue!(toflash, neighbor)
                    end
                catch
                end
            end
        end

        if length(flashed) == 100
            @info "part02: " step
            break
        end

        # Reset flashed octopi to zero
        for octopus in flashed
            octopi[octopus] = 0
            octopi[octopus]
        end

        if step == 100
            @info "part01: " flashes
        end
    end
end

part01("day11/input.txt", typemax(Int64))
