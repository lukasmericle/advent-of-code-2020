fname = "day13input.txt"
rows = readlines(fname)
bus_ids = tryparse.(Int, split(rows[2], ","))
bus_idxs = findall(@. !isnothing(bus_ids))
sort_ord = sortperm(bus_ids[bus_idxs])
bus_idxs = bus_idxs[sort_ord]
periods = copy(bus_ids[bus_idxs])
delays = copy(bus_idxs) .- 1
remainders = (periods .- delays) .% periods
function extended_euclidean(a::Int, b::Int)
    rtm1, stm1, ttm1 = a, 1, 0
    rt, st, tt = b, 0, 1
    while rt != 0
        q = trunc(Int, rtm1 / rt)
        rtp1 = rtm1 - q * rt
        while rtp1 < 0
            q -= 1
            rtp1 = rtm1 - q * rt
        end
        while rtp1 >= rt
            q += 1
            rtp1 = rtm1 - q * rt
        end
        stp1 = stm1 - q * st
        ttp1 = ttm1 - q * tt
        rtm1, stm1, ttm1 = rt, st, tt
        rt, st, tt = rtp1, stp1, ttp1
    end
    stm1, ttm1
end
i = 1
t = BigInt(0)
while i <= length(periods)
    global i, t
    N, n = prod(vcat(periods[1:i-1], periods[i+1:end])), periods[i]
    M, m = extended_euclidean(N, n)
    t += remainders[i] * M * N
    i += 1
end
MM = prod(periods)
t %= MM
while t < 0
    global t, MM
    t += MM
end
while t >= MM
    global t, MM
    t -= MM
end
println(t)
