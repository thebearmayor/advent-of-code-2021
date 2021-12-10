using DataStructures

function part02(file = "day10/sample.txt")
    openers = Dict('(' => 1, '[' => 2, '{' => 3, '<' => 4)

    scores = map(eachline(file)) do line

        stack = Stack{Char}()
        for char in line
            if char in keys(openers)
                push!(stack, char)
            else
                match = pop!(stack)
                pair = "$match$char"
                if !(pair == "()" || pair == "[]" || pair == "{}" || pair == "<>")
                    # corrupt
                    empty!(stack)
                    break
                end
            end
        end

        score = 0
        while !isempty(stack)
            char = pop!(stack)
            score = score * 5 + openers[char]
        end
        score
    end
    filter!(>(0), scores)
    sort!(scores)
    scores[length(scores) ÷ 2 + 1]

end

println(part02())
println(part02("day10/input.txt"))
