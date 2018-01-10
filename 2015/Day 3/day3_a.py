import sys

def house_count(directions):
    deliveries = {(0,0):1}
    x = 0
    y = 0
    for direction in directions:
        if direction == '>':
            x += 1
        if direction == '<':
            x -= 1
        if direction == '^':
            y += 1
        if direction == 'v':
            y -= 1
        if (x,y) in deliveries:
            current = deliveries[(x,y)]
            deliveries[(x,y)] = current + 1
        else:
            deliveries[(x,y)] = 1
    print(str(len(deliveries)))

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
