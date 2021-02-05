# Part 1
file_handle = open('2020\day1\day1_data.txt', 'r')
expensereports = file_handle.readlines()
file_handle.close
#expensereports = (1721,979,366,299,675,1456)
print("Part 1")
print("=============")
stop = 0
for i in expensereports:
    for j in expensereports:
        sumoftwo = int(i) + int(j)
        #print(i, " + ", j, " = ", sumoftwo)
        if sumoftwo == 2020:
            print("The two numbers are: ", i, " and ", j)
            print("product:",int(i)*int(j))
            stop = 1
            break
    if stop == 1:
        break

stop = 0
print("Part 2")
print("=============")
for i in expensereports:
    if stop == 1:
        break
    for j in expensereports:
        if stop == 1:
            break
        for k in expensereports:
            sumofthree = int(i) + int(j) + int(k)
            if sumofthree == 2020:
                productofthree = int(i) * int(j) * int(k)
                print("The three numbers are: ", i, " and ", j, " and ", k)
                print(productofthree)
                stop = 1
                break
