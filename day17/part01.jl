function step(x, y, dx, dy)
    x += dx
    y += dy
    dx = if dx > 0 dx - 1 elseif dx < 0 dx + 1 else 0 end
    dy -= 1
    (x, y, dx, dy)
end

targetx = 56:76
targety = -134:-1:-162
miny = -162

inbounds(x, y) = x in targetx && y in targety

function fire(dx, dy)
    x = y = 0
    maxh = 0
    while x <= 76 && y >= miny
        x, y, dx, dy = step(x, y, dx, dy)
        maxh = max(maxh, y)
        if inbounds(x, y)
            return maxh
        end
    end
    return -1
end

##
count = 0
for dx=11:76, dy=-500:500

    height = fire(dx, dy)
    
    if height >= 0
        println("dx: $dx, dy: $dy, height: $height")
        global count += 1
    end
    
end

@show count
