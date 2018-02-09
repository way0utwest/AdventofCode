# day 6 a


def redistribute(mybank):
    memorybank = mybank
    banklength = len(memorybank)
    maxbank = max(memorybank)
    maxindex = memorybank.index(maxbank)
    memorybank[maxindex] = 0
    currentindex = (maxindex+1)%banklength
    while maxbank > 0:
        banks[currentindex] += 1
        maxbank = maxbank - 1
        currentindex = (currentindex + 1) % banklength
    return memorybank


banks = [14,0,15,12,11,11,3,5,1,6,8,4,9,1,8,4]
print(banks)
bankstate = []
bankstate.append(banks[:])
count = True
n = 1
print(bankstate)
while count:
    banks = redistribute(banks)
    print(banks)
    if banks in bankstate:
        count = False
    else:
        bankstate.append(banks[:])
        n += 1
# print(bankstate)
print("Loops:", n)
