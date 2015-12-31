import sys
import re

def decode_quote(string):
    return  re.sub("\"", " ", string)

def decode_backslash(string):
    return  re.sub("\"", " ", string)

def decode_hex(wholestring):
    wholestring = re.sub('\"', '', wholestring)
    wholestring = re.sub('\\"', '1', wholestring)
    wholestring = re.sub('\\\\', '1', wholestring)
    pattern = r'(\\x[0-9a-fA-F]{2})'
    count = 0
    t = re.split(pattern, wholestring)
    for c in t:
        if c == ' ':
            count = count
        elif c == '"':
            count = count
        elif c[:2] == '\\x':
            count += 1
        else:
            count += len(c)
    return count

def count_char(string):
    return len(string) - 1

def count_string(string):
    pass

filename = "input.txt"
literals = 0
characters = 0
with open(filename) as string_list:
    for line in string_list:
        literals += count_char(line)
        hold_string = decode_quote(line)
        hold_string = decode_backslash(hold_string)
        characters = decode_hex(hold_string)

print(literals)