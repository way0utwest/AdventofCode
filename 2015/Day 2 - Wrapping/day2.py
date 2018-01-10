import sys

def calculate_sqft(length, width, height):
    return ((2 * length * width) + (2 * length * height) + (2 * height * width))

def calculate_wrapping_sqft(package_size):
    a, b, c = map( int, package_size.split('x'))
    perfect = calculate_sqft(a, b, c)
    #print("Sides: " + str(a) + " - " + str(b) + " - " + str(c))
    slack = min(a*b, a*c, b*c)
    #print("area:" + str(perfect) + " slack:" + str(slack))
    return (perfect + slack)

def load_and_calculate_packages(filename):
    total_sqft = 0
    current_size = 0
    with open(filename) as package_file:
        for line in package_file:
            #print("Package:" + line)
            current_size = calculate_wrapping_sqft(line)
            total_sqft = total_sqft + current_size
            #print("Curr:" + str(current_size) + "  Total:" + str(total_sqft))
        return total_sqft

if __name__ == '__main__':
    if len(sys.argv) > 1:
        i = sys.argv[1]
        size = load_and_calculate_packages(i)
    else:
#        i = '1x1x10'
#        size = calculate_wrapping_sqft(i)
        i = "input.txt"
        size = load_and_calculate_packages(i)
        print("total:" + str(size))


# 1589441
# 1594696
# 1588649
