fname = "day1input.txt"
dataset = BitSet(tryparse.(Int, readlines(fname)))
target = 2020
for d=dataset
    ((target - d) in dataset) && (println(d * (target - d)); break)
end
