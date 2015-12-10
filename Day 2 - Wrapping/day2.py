import sys


def calculate_sqft(length, width, height):
    return ((2 * length * width) + (2 * length * height) + (2 * height * width))

def calculate_wrapping_sqft(package_size):
    dimensions = package_size.split('x')
    return calculate_sqft(int(dimensions[0]), int(dimensions[1]), int(dimensions[2]))


if __name__ == '__main__':
    if len(sys.argv) > 1:
        i = sys.argv[1]
    else:
        i = '3x11x24'
    size = calculate_wrapping_sqft(i)
    print(size)

