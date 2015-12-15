import sys

def house_count(directions):
    santadeliveries = {(0,0):1}
    x = 0
    y = 0
    sx = 0
    sy = 0
    rx = 0
    ry = 0
    who = 's'
    for direction in directions:
        if direction == '>':
            if who == 's':
                sx += 1
            else:
                rx += 1
        if direction == '<':
            if who == 's':
                sx -= 1
            else:
                rx -= 1
        if direction == '^':
            if who == 's':
                sy += 1
            else:
                ry += 1
        if direction == 'v':
            if who == 's':
                sy -= 1
            else:
                ry -= 1
        if who == 's':
            x, y = sx, sy
            who = 'r'
        else:
            who = 's'
            x, y = rx, ry

        if (x,y) in santadeliveries:
            current = santadeliveries[(x,y)]
            santadeliveries[(x,y)] = current + 1
        else:
            santadeliveries[(x,y)] = 1

    print(str(len(santadeliveries)))

    return

if __name__ == '__main__':
    filename = "input.txt"
    with open(filename) as package_file:
        for line in package_file:
            houses = house_count(line)
else:
    filename = "input.txt"
    with open(filename) as package_file:
        for line in package_file:
            houses = house_count(line)
