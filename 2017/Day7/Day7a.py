
def buildtower(inputfile):
    debug = []
    programs = []
    badprogs = set()
    with open(inputfile) as f:
        for line in f:
            programs.append(line.split()[0])
            weight = int(line.split()[1].strip('()'))
            if 1 in debug:
                print(line)

            if 2 in debug:
                print("Program:{0} and weight:{1}".format(program, weight))

            if '->' in line:
                children = [item.strip() for item in line.split('->')[1].split(',')]
                if 3 in debug:
                    print(children)
                for child in children:
                    badprogs.add(child)

    for item in programs:
        if item not in badprogs:
            print(item)

    f.close()

if __name__ == "__main__":
    print("Running the program")
    buildtower('puzzleinput.txt')
