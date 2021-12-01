f = open("input", "r")

prev = typemax(Int)
count = 0
while ! eof(f)
    curr = parse(Int64, readline(f))
    # println(curr)
    if curr > prev
        global count += 1
    end
    global prev = curr
end

println(count)