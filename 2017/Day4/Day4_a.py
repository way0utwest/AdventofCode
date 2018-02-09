from sets import Set
with open('./Day4_Input.txt') as f:
    sum = 0
    lines = 0
    for line in f:
        lines += 1
        words = line.split()
        unique = Set(words)
        if (len(words) == len(unique)):
            sum += 1

print("lines:" ,lines)
print("unique:",  sum)
