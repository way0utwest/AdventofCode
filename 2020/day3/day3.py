# day 3


#part 1

trees = 0
moveDown = 1
moveRight = 3
currRow = 0
nextX = 1 + moveRight
nextY = 1 + moveDown

# setup
file_handle = open('2020\day3\day3_data.txt', 'r')

forest = file_handle.readlines()
for row in forest:
    row = row.rstrip()
    currRow += 1
    rowLength = len(row)
    if currRow == nextY:
        #print("Y", nextY, "X", nextX, row[nextX-1:nextX], row, rowLength)
        if row[nextX-1:nextX] == '#':
            trees += 1
            #print("match")
        nextX += moveRight
        if nextX > rowLength:
            nextX -= rowLength
        nextY += + moveDown

print("Trees", str(trees))

file_handle.close()

