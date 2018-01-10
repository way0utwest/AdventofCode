import sys
import re

def nice1(mystring):
    return re.subn("a|e|i|o|u", '', mystring)[1]

def nice2(mystring):
    regex = re.compile(r"(.)\1")
    if re.search(regex, mystring):
        return True
    else:
        return False

def nice3(mystring):
    return re.search("ab|cd|pq|xy", mystring)

def checknice(mystring):
    if (nice1(mystring) >= 3) and (nice2(mystring)) and (nice3(mystring) == None):
        return 1
    else:
        return 0

def check_strings(filename):
    counter = 0
    with open(filename) as package_file:
        for line in package_file:
            counter += checknice(line)
    print(str(counter))

if __name__ == '__main__':
    if len(sys.argv) > 1:
        i = sys.argv[1]
        size = check_strings(i)
    else:
        i = "input.txt"
        check_strings(i)
