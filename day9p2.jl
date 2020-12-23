function is2subsetsum(prev::Vector{Int}, this::Int)
    for (i,p)=enumerate(prev[1:end-1])
        #(((this - p) in prev[1:i-1]) || ((this - p) in prev[i+1:end])) && return true
        ((this - p) in prev[i+1:end]) && return true
    end
    return false
end
fname = "day9input.txt"
data = tryparse.(Int, readlines(fname))
target = 138879426
l = 1
h = 2
running_sum = sum(data[l:h])
while (h <= length(data))
    global l, h, running_sum
    if (target - running_sum == 0)
        break
    elseif (target - running_sum < 0)
        running_sum -= data[l]
        l += 1
    elseif (target - running_sum > 0)
        h += 1
        running_sum += data[h]
    end
    if h-l == 1
        h += 1
        running_sum += data[h]
    end
end
println(min(data[l:h]...) + max(data[l:h]...))
