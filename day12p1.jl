north = CartesianIndex(0, 1)
east = CartesianIndex(1, 0)
south = CartesianIndex(0, -1)
west = CartesianIndex(-1, 0)
mutable struct Ship
    dir::CartesianIndex
    loc::CartesianIndex
end
Ship() = Ship(east, CartesianIndex(0, 0))
rotmat = [0 1 ; -1 0]
rotate_left(ij::CartesianIndex) = CartesianIndex(Tuple((-rotmat) * [ij[1], ij[2]]))
rotate_right(ij::CartesianIndex) = CartesianIndex(Tuple(rotmat * [ij[1], ij[2]]))
function rotate!(ship::Ship, deg::Int)
    if deg == 90
        ship.dir = rotate_right(ship.dir)
    elseif deg == 270
        ship.dir = rotate_left(ship.dir)
    elseif deg == 180
        ship.dir *= -1
    end
end
move!(ship::Ship, dist::Int, dir::CartesianIndex) = ship.loc += dist * dir
function step!(ship::Ship, row::String)
    ins, val = first(row), tryparse(Int, row[2:end])
    if ins == 'F'
        move!(ship, val, ship.dir)
    elseif ins == 'L'
        rotate!(ship, 360 - val)
    elseif ins == 'R'
        rotate!(ship, val)
    elseif ins == 'N'
        move!(ship, val, north)
    elseif ins == 'E'
        move!(ship, val, east)
    elseif ins == 'S'
        move!(ship, val, south)
    elseif ins == 'W'
        move!(ship, val, west)
    end
end
fname = "day12input.txt"
rows = readlines(fname)
ship = Ship()
for row=rows
    global ship
    step!(ship, row)
end
println(sum(abs, Tuple(ship.loc)))
