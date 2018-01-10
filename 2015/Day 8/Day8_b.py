filename = "input.txt"
charcount = sum(s.count('\\')+s.count('"')+2 for s in open(filename))

print(charcount)
