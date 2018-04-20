# day 6 b


def redistribute(mybank):
    memorybank = mybank
    banklength = len(memorybank)
    maxbank = max(memorybank)
    maxindex = memorybank.index(maxbank)
    memorybank[maxindex] = 0
    currentindex = (maxindex+1)%banklength
    while maxbank > 0:
        mybank[currentindex] += 1
        maxbank = maxbank - 1
        currentindex = (currentindex + 1) % banklength
    return memorybank

if __name__ == "__main__":
    banks = [14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4]
    #banks = [0, 2, 7, 0]
    bankstate = []
    bankstate.append(banks)
    count = True
    n = 1
    print(banks)
    while count:
        # print(bankstate)
        banks = redistribute(list(banks))
        print("n is {0}, the list is {1}".format(n, banks))
        if banks in bankstate:
            count = False
        else:
            bankstate.append(banks)
            n += 1
    print("Total Loops:{0} and the index{1}".format(n, bankstate.index(banks)))
    print("Loops required {0}".format(n-bankstate.index(banks)))
