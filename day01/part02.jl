f = open("input", "r")

measurements = map(readlines(f)) do line
    parse(Int64, line)
end

left = 1

prev = measurements[left] + measurements[left + 1] + measurements[left + 2]
left += 1
count = 0
while left + 2 <= length(measurements)
    curr = measurements[left] + measurements[left + 1] + measurements[left + 2]
    if curr > prev
        global count += 1
    end
    global left += 1
    global prev = curr
end
println(count)