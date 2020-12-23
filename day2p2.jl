import Base: count
Base.count(c::Char, s::S) where S <: AbstractString = Base.count([si == c for si in s])
function f(line::AbstractString)
    desc, pwd = strip.(split(line, ':'))
    nums, char = split(desc)
    locs = tryparse.(Int, split(nums, '-'))
    count(first(char), pwd[locs]) == 1
end
fname = "day2input.txt"
println(count(f.(readlines(fname))))
