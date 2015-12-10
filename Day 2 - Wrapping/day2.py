import sys

def calculate_sqft(length, width, height):
    return ((2 * length * width) + (2 * length * height) + (2 * height * width))

def calculate_wrapping_sqft(package_size):
    dimensions = package_size.split('x')
    return calculate_sqft(int(dimensions[0]), int(dimensions[1]), int(dimensions[2]))

def load_and_calculate_packages(filename):
    total_sqft = 0
    current_size = 0
    with open(filename) as package_file:
        for line in package_file:
            current_size = calculate_wrapping_sqft(line)
            total_sqft += current_size
            print("Total Sq ft = " + str(total_sqft) + "  Current: " + str(current_size))
        return total_sqft

if __name__ == '__main__':
    if len(sys.argv) > 1:
        i = sys.argv[1]
    else:
        i = 'input.txt'
    size = load_and_calculate_packages(i)
    print(size)