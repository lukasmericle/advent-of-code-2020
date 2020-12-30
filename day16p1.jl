function parse_rows(rows::Vector{<:AbstractString})
    notes = Dict{String,Vector{UnitRange}}()
    i = 1
    while rows[i] !== ""
        note_name, note_spec = split(rows[i], ":")
        spec_ranges = split(strip(note_spec), " or ")
        note_ranges = UnitRange[]
        for r=spec_ranges
            b, e = tryparse.(Int, split(r, "-"))
            push!(note_ranges, b:e)
        end
        notes[note_name] = note_ranges
        i += 1
    end
    while rows[i] != "your ticket:"
        i += 1
    end
    i += 1
    my_ticket = tryparse.(Int, split(rows[i], ","))
    while rows[i] != "nearby tickets:"
        i += 1
    end
    i += 1
    other_tickets = [tryparse.(Int, split(rows[j], ",")) for j=i:length(rows)]
    notes, my_ticket, other_tickets
end
valid_value(value::Int, range::UnitRange) = value in range
valid_value(value::Int, ranges::Vector{UnitRange}) = any(valid_value.(value, ranges))
function error_rate(ticket::Vector{Int}, notes::Dict{String,Vector{UnitRange}})
    rate = 0
    for value=ticket
        if !any(valid_value(value, ranges) for (note,ranges)=notes)
            rate += value
        end
    end
    rate
end
fname = "day16input.txt"
rows = readlines(fname)
notes, my_ticket, other_tickets = parse_rows(rows)
total_rate = 0
for ticket=other_tickets
    global total_rate
    total_rate += error_rate(ticket, notes)
end
println(total_rate)
