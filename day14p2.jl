function apply(mask::AbstractString, ptr::Int)
    bptr = bitstring(ptr)[end-35:end]
    prod([mask[i] === '0' ? bptr[i] : mask[i] for i=1:length(mask)])
end
function write!(mem::Dict{Int,Int}, addr::AbstractString, value::Int)
    idx = findfirst(isequal('X'), addr)
    if isnothing(idx)
        mem[parse(Int, addr; base=2)] = value
        return
    end
    for c=['0', '1']
        new_addr = addr[1:idx-1] * c * addr[idx+1:end]
        write!(mem, new_addr, value)
    end
end
write!(mem::Dict{Int,Int}, mask::AbstractString, ptr::Int, value::Int) = write!(mem, apply(mask, ptr), value)
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
        write!(mem, mask, i, val)
    end
end
println(sum(big.(values(mem))))
