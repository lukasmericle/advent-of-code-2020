fname = "day1input.txt"
dataset = BitSet(tryparse.(Int, readlines(fname)))
target = 2020
for d1=dataset
    for d2=setdiff(dataset, BitSet([d1]))
        let d3 = target - d1 - d2
            (d3 in dataset) && (println(d1 * d2 * d3); break)
        end
    end
end
