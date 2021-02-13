# part 2
# more slopes
file_handle = open('2020\day3\day3_data.txt', 'r')
forest = file_handle.readlines()
currRow = 0
trees=193

trees1 = 0
nextX1 = 2
nextY1 = 2
moveRight1 = 1
moveDown1 = 1

trees2 = 0
nextX2 = 6
nextY2 = 2
moveRight2 = 5
moveDown2 = 1

trees3 = 0
nextX3 = 8
nextY3 = 2
moveRight3 = 7
moveDown3 = 1

trees4 = 0
nextX4 = 2
nextY4 = 3
moveRight4 = 1
moveDown4 = 2

for row in forest:
    row = row.rstrip()
    currRow += 1
    rowLength = len(row)
    if currRow == nextY1:
        #print("Y", nextY, "X", nextX, row[nextX-1:nextX], row, rowLength)
        if row[nextX1-1:nextX1] == '#':
            trees1 += 1
            #print("match")
        nextX1 += moveRight1
        if nextX1 > rowLength:
            nextX1 -= rowLength
        nextY1 += + moveDown1
    if currRow == nextY2:
        #print("Y", nextY, "X", nextX, row[nextX-1:nextX], row, rowLength)
        if row[nextX2-1:nextX2] == '#':
            trees2 += 1
            #print("match")
        nextX2 += moveRight2
        if nextX2 > rowLength:
            nextX2 -= rowLength
        nextY2 += + moveDown2
    if currRow == nextY3:
        #print("Y", nextY, "X", nextX, row[nextX-1:nextX], row, rowLength)
        if row[nextX3-1:nextX3] == '#':
            trees3 += 1
            #print("match")
        nextX3 += moveRight3
        if nextX3 > rowLength:
            nextX3 -= rowLength
        nextY3 += + moveDown3
    if currRow == nextY4:
        #print("Y", nextY, "X", nextX, row[nextX-1:nextX], row, rowLength)
        if row[nextX4-1:nextX4] == '#':
            trees4 += 1
            #print("match")
        nextX4 += moveRight4
        if nextX4 > rowLength:
            nextX4 -= rowLength
        nextY4 += + moveDown4

print(trees, trees1, trees2, trees3, trees4)
print(trees * trees1 * trees2 * trees3 * trees4)