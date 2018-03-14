largest = 2
num = 600851475143

loops = 0
while num != 1:
    loops += 1
    quo, rem = divmod(num, largest)
    if rem == 0:
        num = quo
    else:
        largest += 1
print(largest, loops)
