def sum_of_squares(n: int):
    return n * (n + 1) * (2 * n + 1) // 6


def sum_of_squares_fr_to(fr: int, to: int):
    return sum_of_squares(to - 1) - sum_of_squares(fr - 1)


def sum_of_linear_stupid(fr: int, to: int, j: int):
    s: int = 0
    for i in range(fr, to, j):
        s += i
    return s


def sum_of_linear(fr: int, to: int, j: int):
    n = (to - fr) // j
    s = n * fr
    s += n * (n - 1) * j // 2
    return s


def main():
    """
    a = 6
    a2 = a**2
    s= set()
    for n in range(1, 1000):
        m = ((a-1)**n+(a+1)**n)%a2
        s.add(m)
        print(n, m)
    print(s)
    """

    s = 0
    for a in range(3, 1001):
        a2 = a ** 2
        m = 0
        for n in range(1, a):
            m = max(m, 2 * n * a % a2)
        s += m
    print(s)

    # better

    s = 0
    for a in range(3, 1001):
        a2 = a ** 2
        if a % 2 == 0:
            m = a2 - 2 * a
        else:
            m = a2 - a
        s += m
    print(s)

    # we can even do a formula

    s = sum_of_squares_fr_to(fr=3, to=1001) - 2 * sum_of_linear(4, 1002, 2) - sum_of_linear(3, 1001, 2)
    print(s)


if __name__ == '__main__':
    main()
