using Test, AutoHashEquals

### part 1

abstract type AbstractPacket end

@auto_hash_equals struct Literal <: AbstractPacket
    version::Int
    type::Int
    value::Int
end

@auto_hash_equals struct Operator <: AbstractPacket
    version::Int
    type::Int
    packets::Array{AbstractPacket}
end

function hextobin(hex)
    mapping = Dict(
        '0' => "0000",
        '1' => "0001",
        '2' => "0010",
        '3' => "0011",
        '4' => "0100",
        '5' => "0101",
        '6' => "0110",
        '7' => "0111",
        '8' => "1000",
        '9' => "1001",
        'A' => "1010",
        'B' => "1011",
        'C' => "1100",
        'D' => "1101",
        'E' => "1110",
        'F' => "1111",
    )
    map(c -> get(mapping, c, "ZZZZ"), collect(hex)) |> join
end

parseroot(bin) = parsepacket(bin, 0)[1]

parseint(bin, ptr) = (parse(Int, bin[ptr+1:ptr+3]; base=2), ptr+3)

function parsepacket(bin, ptr)
    version, ptr = parseint(bin, ptr)
    type, ptr = parseint(bin, ptr)

    if type == 4
        value, ptr = parseliteral(bin, ptr)
        (Literal(version, type, value), ptr)
    else
        packets, ptr = parseoperator(bin, ptr)
        (Operator(version, type, packets), ptr)
    end
end

function parseliteral(bin, ptr)
    lit = ""
    while true
        last = bin[ptr+1]
        ptr += 1
        lit *= bin[ptr+1:ptr+4]
        ptr += 4
        if last == '0'
            break
        end
    end
    
    (parse(Int, lit; base=2), ptr)
end

function parseoperator(bin, ptr)
    lengthbit = bin[ptr+1]
    ptr += 1
    packets = []
    if lengthbit == '0'
        length = parse(Int, bin[ptr+1:ptr+15]; base=2)
        ptr += 15
        stop = ptr + length
        while ptr < stop
            packet, ptr = parsepacket(bin, ptr)
            push!(packets, packet)
        end
    else
        numpackets = parse(Int, bin[ptr+1:ptr+11]; base=2)
        ptr += 11
        for _ in 1:numpackets
            packet, ptr = parsepacket(bin, ptr)
            push!(packets, packet)
        end
    end
    (packets, ptr)
end

function sumversions(hex::String)
    bin = hextobin(hex)
    root = parseroot(bin)
    sumversions(root)
end

function sumversions(root::AbstractPacket)
    try
        +(root.version, sumversions.(root.packets)...)
    catch
        root.version
    end
end

@testset "parseliteral" begin
    @test parseliteral("101111111000101000", 0)[1] == 2021
    @test parseroot("110100101111111000101000") == Literal(6, 4, 2021)
end

@testset "parseoperator" begin
    @test parseroot("00111000000000000110111101000101001010010001001000000000") ==
        Operator(1, 6, [Literal(6, 4, 10), Literal(2, 4, 20)])
    @test parseroot("11101110000000001101010000001100100000100011000001100000") ==
        Operator(7, 3, [Literal(2, 4, 1), Literal(4, 4, 2), Literal(1, 4, 3)])
end


@testset "sumversions examples" begin
    @test sumversions("8A004A801A8002F478") == 16
    @test sumversions("620080001611562C8802118E34") == 12
    @test sumversions("C0015000016115A2E0802F182340") == 23
    @test sumversions("A0016C880162017C3686B18A3D4780") == 31
end

@show readline("day16/input.txt") |> sumversions


### part 2

function evaluate(hex::String)
    bin = hextobin(hex)
    root = parseroot(bin)
    evaluate(root)
end

function evaluate(packet::AbstractPacket)
    if packet.type == 4
        packet.value
    elseif packet.type == 0
        +(evaluate.(packet.packets)...)
    elseif packet.type == 1
        *(evaluate.(packet.packets)...)
    elseif packet.type == 2
        min(evaluate.(packet.packets)...)
    elseif packet.type == 3
        max(evaluate.(packet.packets)...)
    elseif packet.type == 5
        if evaluate(packet.packets[1]) > evaluate(packet.packets[2]) 1 else 0 end
    elseif packet.type == 6
        if evaluate(packet.packets[1]) < evaluate(packet.packets[2]) 1 else 0 end
    elseif packet.type == 7
        if evaluate(packet.packets[1]) == evaluate(packet.packets[2]) 1 else 0 end
    end
end

@testset "evaluate" begin
    @test evaluate("C200B40A82") == 3
    @test evaluate("04005AC33890") == 54
    @test evaluate("880086C3E88112") == 7
    @test evaluate("CE00C43D881120") == 9
    @test evaluate("D8005AC2A8F0") == 1
    @test evaluate("F600BC2D8F") == 0
    @test evaluate("9C005AC2F8F0") == 0
    @test evaluate("9C0141080250320F1802104A08") == 1
end

@show readline("day16/input.txt") |> evaluate