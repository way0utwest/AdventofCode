# part 1
file_handle = open('2020\day4\day4_data.txt', 'r')
passports = file_handle.readlines()

part1 = 0
currpassport = ""
for row in passports:
    if row not in ['\n','\r\n']:
        currpassport += row.replace('\n',' ')
        #print(currpassport.split(" "))
    else:
        currdict = dict(x.split(":") for x in currpassport.split(" ") if x)
        if len(currdict) == 8:
            part1 += 1
        if ((len(currdict) == 7) and ("cid" not in currdict)):
            part1 += 1
        currpassport = ""

print(part1)