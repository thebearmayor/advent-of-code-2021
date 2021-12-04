using LinearAlgebra

parseInt(s) = parse(Int, s)

function parseBoard(line)
    lines = split(strip(line), "\n")
    strings = lines .|> split |> l -> hcat(l...) |> permutedims
    strings .|> parseInt .|> n -> (value = n, marked = false)
end

function markBoard(board, value)
    map(board) do square
        if square.value == value
            (; square..., marked=true)
        else
            square
        end
    end
end

function isWinner(board)
    marked = map(x -> x.marked, board)
    # d1 = diag(marked)
    # d2 = diag(reverse(marked, dims = 1))
    mapslices(all, marked, dims = [1]) |> any ||
    mapslices(all, marked, dims = [2]) |> any
    # all(d1) ||
    # all(d2)
end

function scoreBoard(board, mult)
    score = mult * sum(filter(x -> !x.marked, board) .|> x -> x.value)
end

function part02()
    f = open("day04/input.txt", "r")
    line = readuntil(f, "\n\n")
    numbers = split(line, ",") .|> parseInt

    boards = []
    while (!eof(f))
        line = readuntil(f, "\n\n")
        board = parseBoard(line)
        push!(boards, board)
    end

    for number in numbers
        toDelete = []
        for i in 1:length(boards)
            board = markBoard(boards[i], number)
            boards[i] = board
            if isWinner(board)
                if length(boards) == 1
                    return scoreBoard(board, number)
                else
                    push!(toDelete, i)
                end
            end
        end
        for i in reverse(toDelete)
            deleteat!(boards, i)
        end
    end
end


