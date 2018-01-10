import sys

def calc_ribbon(package):
    l, w, h = map(int, package.split('x'))
    return (l * w * h) + min(2*l+2*w, 2*l+2*h, 2*w+2*h )

def load_and_calculate_packages(filename):
    total_ribbon = 0
    current_size = 0
    with open(filename) as package_file:
        for line in package_file:
            #print("Package:" + line)
            current_size = calc_ribbon(line)
            total_ribbon += current_size
            #print("Curr:" + str(current_size) + "  Total:" + str(total_sqft))
        return total_ribbon


if __name__ == '__main__':
    if len(sys.argv) > 1:
        i = sys.argv[1]
        size = load_and_calculate_packages(i)
    else:
        i = "input.txt"
        size = load_and_calculate_packages(i)
        print("total:" + str(size))
# 3783758
# 3783758
