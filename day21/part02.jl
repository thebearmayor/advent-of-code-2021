using Memoization, SplitApplyCombine

function day21(file = "day21/input.txt")
    pos1, pos2 = parse.(Int, last.(readlines(file)))
    
    play(pos1, 0, pos2, 0, 1)
end

rolls = [i + j + k for i=1:3 for j=1:3 for k=1:3] |> group .|> length

@memoize function play(pos1, score1, pos2, score2, next)
    if score1 >= 21
        [1, 0]
    elseif score2 >= 21
        [0, 1]
    else
        wins = [0, 0]
        for (roll, freq) in pairs(rolls)
            if next == 1
                p1 = (pos1 + roll) % 10
                s1 = score1 + (if p1 == 0 10 else p1 end)
                p2 = pos2
                s2 = score2
            else
                p1 = pos1
                s1 = score1
                p2 = (pos2 + roll) % 10
                s2 = score2 + (if p2 == 0 10 else p2 end)
            end
            wins += freq * play(p1, s1, p2, s2, if next == 1 2 else 1 end)
        end
        wins
    end
end