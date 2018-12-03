
def buildtower(inputfile):
    debug = [2]
    programs = {}
    badprogs = set()
    with open(inputfile) as f:
        for line in f:
            programs[line.split()[0]] = int(line.split()[1].strip('()'))
            if 1 in debug:
                print(line)

    if 2 in debug:
        print(programs)

    f.close()

if __name__ == "__main__":
    print("Running the program")
    buildtower('testinput.txt')
