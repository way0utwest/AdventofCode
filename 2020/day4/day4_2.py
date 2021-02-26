# part 2
file_handle = open('2020\day4\day4_data.txt', 'r')
passports = file_handle.readlines()

part2 = 0
currpassport = ""
for row in passports:
    if row not in ['\n','\r\n']:
        currpassport += row.replace('\n',' ')
        #print(currpassport.split(" "))
    else:
        currdict = dict(x.split(":") for x in currpassport.split(" ") if x)
        if len(currdict) == 8 or ((len(currdict) == 7) and ("cid" not in currdict)):
            valid = 1
            if ((int(currdict["iyr"]) < 2010) or (int(currdict["iyr"]) > 2020)):
                valid = 0
            if int(currdict["byr"]) < 1920 or int(currdict["byr"]) > 2002 :
                valid = 0
            if int(currdict["eyr"]) < 2020 or int(currdict["iyr"]) > 2030:
                valid = 0
            if currdict["hgt"][-2:] not in ["in", "cm"]:
                valid = 0
            if currdict["hgt"][-2:]=="cm" and ( int(currdict["hgt"][:-2]) < 150 or int(currdict["hgt"][:-2]) > 193):
                valid = 0
            if currdict["hgt"][-2:]=="in" and ( int(currdict["hgt"][:-2]) < 59 or int(currdict["hgt"][:-2]) > 76):
                valid = 0
            if currdict["ecl"] not in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
                valid = 0
            if currdict["hcl"][0] != "#" or len(currdict["hcl"]) != 7:
                valid = 0
            if len(currdict["pid"]) != 9:
                valid = 0
            if valid == 1:
                part2 += 1
        currpassport = ""

print(part2)