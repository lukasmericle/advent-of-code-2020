fname = "day15input.txt"
ns = tryparse.(Int, split(readline(fname), ","))
cache = Dict{Int,Int}()
for (t,n)=enumerate(ns[1:end-1])
    cache[n] = t
end
t, n = length(ns), ns[end]
while t < 30000000
    global t, n
    if n in keys(cache)
        new_n = t - cache[n]
    else
        new_n = 0
    end
    cache[n] = t
    t += 1
    n = new_n
end
println(n)
