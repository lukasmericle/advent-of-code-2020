fname = "day6input.txt"
rows = readlines(fname)
form = String[]
n = 0
for row=rows
    global form, n
    if (row == "")
        n += length(union(Set.(form)...))
        form = String[]
    else
        push!(form, row)
    end
end
(length(form) > 0) && (n += length(union(Set.(form)...)))
println(n)
