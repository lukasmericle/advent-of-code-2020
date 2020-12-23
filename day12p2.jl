north = CartesianIndex(0, 1)
east = CartesianIndex(1, 0)
south = CartesianIndex(0, -1)
west = CartesianIndex(-1, 0)
mutable struct Ship
    dir::CartesianIndex
    loc::CartesianIndex
end
Ship() = Ship(east, CartesianIndex(0, 0))
mutable struct Waypoint
    dir::CartesianIndex
end
rotmat = [0 1 ; -1 0]
rotate_left(ij::CartesianIndex) = CartesianIndex(Tuple((-rotmat) * [ij[1], ij[2]]))
rotate_right(ij::CartesianIndex) = CartesianIndex(Tuple(rotmat * [ij[1], ij[2]]))
function rotate!(thing::Union{Ship, Waypoint}, deg::Int)
    if deg == 90
        thing.dir = rotate_right(thing.dir)
    elseif deg == 270
        thing.dir = rotate_left(thing.dir)
    elseif deg == 180
        thing.dir *= -1
    end
end
move!(ship::Ship, dist::Int, dir::CartesianIndex) = ship.loc += dist * dir
move!(waypoint::Waypoint, dist::Int, dir::CartesianIndex) = waypoint.dir += dist * dir
function step!(ship::Ship, waypoint::Waypoint, row::String)
    ins, val = first(row), tryparse(Int, row[2:end])
    if ins == 'F'
        move!(ship, val, waypoint.dir)
    elseif ins == 'L'
        rotate!(waypoint, 360 - val)
    elseif ins == 'R'
        rotate!(waypoint, val)
    elseif ins == 'N'
        move!(waypoint, val, north)
    elseif ins == 'E'
        move!(waypoint, val, east)
    elseif ins == 'S'
        move!(waypoint, val, south)
    elseif ins == 'W'
        move!(waypoint, val, west)
    end
end
fname = "day12input.txt"
rows = readlines(fname)
ship = Ship()
waypoint = Waypoint(CartesianIndex(10, 1))
for row=rows
    global ship, waypoint
    step!(ship, waypoint, row)
end
println(sum(abs, Tuple(ship.loc)))
