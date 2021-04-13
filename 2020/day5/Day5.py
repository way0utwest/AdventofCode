# part 1
file_handle = open('day5_data.txt', 'r')
seatcodes = file_handle.readlines()

part1 = 0
seatval = []
for code in seatcodes:
    seatval.append(int(code.replace('B','1').replace('F','0').replace('L','0').replace('R','1'), 2))

part1 = max(seatval)
print("Part 1:", part1)


part2 = 0
j = [i for i in range(min(seatval), max(seatval)) if i not in seatval]
print(j)
