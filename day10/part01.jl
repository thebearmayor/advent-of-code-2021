using DataStructures

function part01(file = "day10/sample.txt")
    points = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
    score = 0
    for line in eachline(file)
        stack = Stack{Char}()
        for char in line
            if char in ['(', '[', '{', '<']
                push!(stack, char)
            else
                match = pop!(stack)
                pair = "$match$char"
                if pair == "()" || pair == "[]" || pair == "{}" || pair == "<>"
                    continue
                else
                    score += points[char]
                    println("$char found on line $line. score: $score")
                end
            end
        end
    end
    score
end

println(part01())
println(part01("day10/input.txt"))
