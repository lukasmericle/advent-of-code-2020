DECIMAL = "0123456789"
HEXADECIMAL = "abcdef" * DECIMAL
ALLOWED_ECLS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
REQUIRED_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
isvalid_byr(byr::String) = 1920 <= tryparse(Int, byr) <= 2002
isvalid_iyr(iyr::String) = 2010 <= tryparse(Int, iyr) <= 2020
isvalid_eyr(eyr::String) = 2020 <= tryparse(Int, eyr) <= 2030
function isvalid_hgt(hgt::String)
    let idx = length(hgt)-1
        unit = hgt[idx:end]
        hgt = tryparse(Int, hgt[1:idx-1])
        return unit == "cm" ? 150 <= hgt <= 193 : 59 <= hgt <= 76
    end
end
isvalid_hcl(hcl::String) = (first(hcl) == '#') && (length(hcl) == 7) && all(occursin.([c for c=hcl[2:end]], HEXADECIMAL))
isvalid_ecl(ecl::String) = ecl in ALLOWED_ECLS
isvalid_pid(pid::String) = (length(pid) == 9) && all(occursin.([c for c=pid], DECIMAL))
isvalid_functions = [isvalid_byr, isvalid_iyr, isvalid_eyr, isvalid_hgt, isvalid_hcl, isvalid_ecl, isvalid_pid]
function isvalid(passport::String)
    fields = Dict{String,String}()
    for entry=split(passport, " ")
        let (k,v) = split(entry, ":")
            fields[k] = v
        end
    end
    for (field,fn)=zip(REQUIRED_FIELDS, isvalid_functions)
        try
            !fn(fields[field]) && return false
        catch e
            return false
        end
    end
    true
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
