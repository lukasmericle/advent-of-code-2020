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
valid_value(value::Int, ranges::Vector{UnitRange}) = any(valid_value(value, range) for range=ranges)
function valid_ticket(ticket::Vector{Int}, notes::Dict{String,Vector{UnitRange}})
    r = Vector{Bool}(undef, length(ticket))
    for (i,value)=enumerate(ticket)
        rr = Vector{Bool}(undef, length(notes))
        for (j,(name,ranges))=enumerate(notes)
            rr[j] = valid_value(value, ranges)
        end
        r[i] = any(rr)
    end
    all(r)
end
fname = "day16input.txt"
rows = readlines(fname)
notes, my_ticket, other_tickets = parse_rows(rows)
valid_tickets = Vector{Int}[]
for ticket=other_tickets
    valid_ticket(ticket, notes) && push!(valid_tickets, ticket)
end
result = Dict{String,Set{Int}}()
for (i,(name,ranges))=enumerate(notes)
    this_result = zeros(Bool, length(notes))
    for j=1:length(notes)
        this_result[j] = all(valid_value(ticket[j], ranges) for ticket=valid_tickets)
    end
    result[name] = Set(findall(this_result))
end
this_name = ""
this_cand = 0
assigned = Set(Int[])
assignments = Vector{String}(undef, length(notes))
for i=1:length(notes)
    global this_name, this_cand, result, assignments
    for (name,cands)=result
        new_cands = setdiff(cands, assigned)
        if length(new_cands) === 1
            this_name = name
            this_cand = rand(new_cands)
            push!(assigned, this_cand)
            break
        end
    end
    assignments[this_cand] = this_name
end
println(prod(my_ticket[findall(x -> occursin("departure", x), assignments)]))
