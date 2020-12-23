REQUIRED_FIELDS = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
function isvalid(passport::String)
    fields = Set(split(entry, ":")[1] for entry=split(passport, " "))
    length(setdiff(REQUIRED_FIELDS, fields)) == 0
end
isvalid(passport::Vector{String}) = isvalid(join(passport, " "))
fname = "day4input.txt"
rows = readlines(fname)
passport = String[]
n = 0
for row=rows
    global passport, n
    if (row == "")
        isvalid(passport) && (n += 1)
        passport = String[]
    else
        push!(passport, row)
    end
end
((length(passport) > 0) && isvalid(passport)) && (n += 1)
println(n)
