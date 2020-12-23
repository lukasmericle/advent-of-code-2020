fname = "day10input.txt"
data = tryparse.(Int, readlines(fname))
sort!(data, rev=true)
data = vcat([data[1]+3], data, [0])
memo = similar(data)
memo[1] = 1
for n=2:length(data)
    global memo
    this_total = 0
    for m=1:3
        (n - m < 1) && break
        (data[n-m] - data[n] <= 3) && (this_total += memo[n-m])
    end
    memo[n] = this_total
end
println(memo[end])
