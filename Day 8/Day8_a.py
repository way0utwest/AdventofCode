import sys

def count_char(string):
    return len(string) - 1

filename = "input.txt"
literals = 0
with open(filename) as string_list:
    for line in string_list:
        literals += count_char(line)

print(literals)