function apply(mask::AbstractString, value::Int)
    bval = bitstring(value)[end-35:end]
    out = [mask[i] === 'X' ? bval[i] : mask[i] for i=1:length(mask)]
    parse(Int, prod(out); base=2)
end
fname = "day14input.txt"
rows = readlines(fname)
mem = Dict{Int,Int}()
mask = ""
for row=rows
    global mask, mem
    if row[1:7] == "mask = "
        mask = row[8:end]
    else
        regex_match = match(r"^mem\[(\d+)\] = (\d+)", row)
        i = parse(Int, regex_match[1])
        val = parse(Int, regex_match[2])
        mem[i] = apply(mask, val)
    end
end
println(sum(big.(values(mem))))
