import sys


def initialize_lights(grid):
    for x in range(0,1000):
        for y in range(0,1000):
            grid[(x,y)] = 0

def lights_switch(startx, starty, endx, endy, grid, toggle):
    y = starty
    while startx <= endx:
        while starty <= endy:
            grid[(startx,starty)] += toggle
            if grid[(startx,starty)] < 0:
                grid[(startx,starty)] = 0
            starty += 1
        starty = y
        startx += 1

def switch_lights(grid, instruction):
    tokens = instruction.split()
    if instruction.startswith("turn on"):
        startx, starty = tokens[2].split(",")
        endx, endy = tokens[4].split(",")
        lights_switch(int(startx), int(starty), int(endx), int(endy), grid, 1)
    if instruction.startswith(("turn off")):
        startx, starty = tokens[2].split(",")
        endx, endy = tokens[4].split(",")
        lights_switch(int(startx), int(starty), int(endx), int(endy), grid, -1)
    if instruction.startswith("toggle"):
        startx, starty = tokens[1].split(",")
        endx, endy = tokens[3].split(",")
        lights_switch(int(startx), int(starty), int(endx), int(endy), grid, 2)


def count_lights(grid):
    total = 0
    for x in range(0,1000):
        for y in range(0,1000):
            total += grid[(x,y)]
    return total



filename = "input.txt"
grid = {}
initialize_lights(grid)
with open(filename) as package_file:
    for line in package_file:
        switch_lights(grid, line)
print("count: " + str(count_lights(grid)))

# 14191263
# 14687245
# 14687245 - correct