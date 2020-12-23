function get_dag_edges(regex_results::Vector{T}) where T <: Union{Nothing, RegexMatch}
    edges = Tuple{String, Int}[]
    for result=regex_results
        isnothing(result) && continue
        push!(edges, (result[:color], tryparse(Int, result[:n])))
    end
    edges
end
function make_adj(rows::Vector{String})
    adjrows = Dict{String, Vector{Tuple{String,Int}}}()
    for row=rows
        parent, children = split(row, " bags contain ")
        children = strip.(split(children, ","))
        results = match.(r"(?<n>\d+) (?<color>[a-z]+\s[a-z]+) bag", children)
        adjrows[parent] = get_dag_edges(results)
    end
    all_colors = sort([k for k=keys(adjrows)])
    adj = zeros(Int, length(all_colors), length(all_colors))
    for (i,color)=enumerate(all_colors)
        for (child,n)=adjrows[color]
            j = findfirst(all_colors .== child)
            adj[i,j] = n
        end
    end
    adj, all_colors
end
function find_num_children(adj::Matrix{Int}, i::Int; memo::Dict{Int,Int}=Dict{Int,Int}())
    n = 0
    for j=findall(adj[i,:] .> 0)
        if !haskey(memo, j)
            memo[j] = find_num_children(adj, j, memo=memo)
        end
        n += adj[i,j] * (memo[j] + 1)
    end
    n
end
fname = "day7input.txt"
rows = readlines(fname)
adj, all_colors = make_adj(rows)
init_color = "shiny gold"
println(find_num_children(adj, findfirst(all_colors .== init_color)))
