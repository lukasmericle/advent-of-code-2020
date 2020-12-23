import Base: count
Base.count(c::Char, s::S) where S <: AbstractString = Base.count([si == c for si in s])
function f(line::AbstractString)
    desc, pwd = strip.(split(line, ':'))
    nums, char = split(desc)
    num1, num2 = tryparse.(Int, split(nums, '-'))
    num1 <= count(first(char), pwd) <= num2
end
fname = "day2input.txt"
println(count(f.(readlines(fname))))
