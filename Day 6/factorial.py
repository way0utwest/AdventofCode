def factorial_try(n):
    if n == 0:
        return 1
    else:
        print(n)
        return (n * factorial_try(n - 1))

print(__name__)
if __name__ == '__main__':
    x = factorial_try(3)
    print(x)