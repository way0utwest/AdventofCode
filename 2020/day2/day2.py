# Day 2
dataFile = "2020\day2\day2_data.txt"

fileHandle = open(dataFile, 'r')
lines = fileHandle.readlines()

valid = 0
valid2 = 0
for line in lines:
    # print(line)
    min, max = line.split(' ')[0].split('-')
    pwd = line.split(' ')[2]
    checkval = line.split(' ')[1][:-1]
    print("pwd ", pwd, " min:", min, " max:", max)
    if int(min) <= pwd.count(checkval) <= int(max):
        valid += 1
    if (pwd[int(min)-1] == checkval) != (pwd[int(max)-1] == checkval):
        valid2 += 1

print("part 1 total:", valid)
print("part 2 total:", valid2)
# 564



