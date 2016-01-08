

def calculate_sum_quick(numbers):
    return sum(numbers)

def calculate_sum_for(numbers):
    totalsum = 0
    for x in numbers:
        totalsum += x
    return(totalsum)


def calculate_sum_while(numbers):
    i = 0
    totalsum = 0
    while i < len(numbers):
        totalsum += numbers[i]
        i += 1
    return(totalsum)


def calculate_sum_recurse(numbers):
    if len(numbers) == 1:
        return numbers[0]
    else:
        return( numbers[0] + calculate_sum_recurse(numbers[1:]))

def calculate_sum(numberlist):
    return calculate_sum_recurse(numberlist)


list = [1, 2, 3, 4, 5, 6, 7, 8]
total = calculate_sum(list)
print(total)

list = [2, 3, 5]
total = calculate_sum(list)
print(total)
