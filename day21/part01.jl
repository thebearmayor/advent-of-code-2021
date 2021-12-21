function day21(file = "day21/input.txt")
    pos1, pos2 = parse.(Int, last.(readlines(file)))
    score1 = score2 = 0
    die = 0
    while true
        pos1 = (pos1 + (3 * die) + 6) % 10
        die += 3
        score1 += if pos1 == 0 10 else pos1 end
        println("player1 score: $score1")
        if score1 >= 1000
            println("player1 wins with score $score1")
            break
        end

        pos2 = (pos2 + (3 * die) + 6) % 10
        die += 3
        score2 += if pos2 == 0 10 else pos2 end
        if score2 >= 1000
            println("player2 wins with score $score2")
            break
        end
    end
    min(score1, score2) * die
end
