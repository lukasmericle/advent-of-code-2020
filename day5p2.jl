seat_id(row, col) = row * 8 + col
function find_row(part::AbstractString; level::Int=0)
    (part == "") && return 0
    2^level * convert(Int, last(part) == 'B') + find_row(part[1:end-1], level=level+1)
end
function find_col(part::AbstractString; level::Int=0)
    (part == "") && return 0
    2^level * convert(Int, last(part) == 'R') + find_col(part[1:end-1], level=level+1)
end
find_seat(part::String) = find_row(part[1:7]), find_col(part[8:end])
fname = "day5input.txt"
rows = readlines(fname)
ids = sort(map(row -> seat_id(find_seat(row)...), rows))
println(ids[findfirst((ids[2:end] .- ids[1:end-1]) .> 1)] + 1)
