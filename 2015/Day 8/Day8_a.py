filename = "input.txt"
charcount = sum(len(s[:-1]) - len(eval(s)) for s in open(filename))

print(charcount)
