import sys


def initialize_lights(grid):
    x = 0
    y = 0
    while x < 1000:
        while y < 1000:
            grid[(x,y)] = 0
            y += 1
        y = 0
        x +=1

def lights_on(startx, starty, endx, endy, grid):
    while startx <= endx:
        while starty <= endy:
            grid[(startx,starty)] = 1
            starty += 1
        startx += 1

def lights_off(startx, starty, endx, endy, grid):
    pass

def lights_switch(startx, starty, endx, endy, grid, toggle):
    y = starty
    while startx <= endx:
        while starty <= endy:
            if toggle == 2:
                if grid[(startx,starty)] == 1:
                    grid[(startx,starty)] = 0
                else:
                    grid[(startx,starty)] = 1
            else:
                grid[(startx,starty)] = toggle
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
        lights_switch(int(startx), int(starty), int(endx), int(endy), grid, 0)
    if instruction.startswith("toggle"):
        startx, starty = tokens[1].split(",")
        endx, endy = tokens[3].split(",")
        lights_switch(int(startx), int(starty), int(endx), int(endy), grid, 2)


def count_lights(grid):
    total = 0
    x = 0
    y = 0
    while x < 999:
        while y < 999:
#            print("X:" + str(x) + " Y:" + str(y) + " val:" + str(grid[(x,y)]))
            if grid[(x,y)] == 1:
                total += 1
            y += 1
        y = 0
        x += 1
    return total



filename = "input.txt"
grid = {}
initialize_lights(grid)
with open(filename) as package_file:
    for line in package_file:
        print(line)
        switch_lights(grid, line)
print("count: " + str(count_lights(grid)))
