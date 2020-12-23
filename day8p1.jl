function parse_row(row::String)
    ins, value = split(row)
    trf = (x -> x + eval(Meta.parse(value)))
    return ins, trf
end
function op(ins::AbstractString, trf::Function, lineno::Int, acc::Int=0)
    if ins == "acc"
        return lineno+1, trf(acc)
    elseif ins == "jmp"
        return trf(lineno), acc
    end
    return lineno+1, acc
end
fname = "day8input.txt"
rows = readlines(fname)
lineno = 1
acc = 0
p = [lineno]
while 1 <= lineno <= length(rows)
    global lineno, acc
    ins, trf = parse_row(rows[lineno])
    new_lineno, new_acc = op(ins, trf, lineno, acc)
    (new_lineno in p) && break
    push!(p, new_lineno)
    lineno = new_lineno
    acc = new_acc
end
println(acc)
