
with open("13.txt", "rt") as f:
    sum = 0
    for line in f:
        sum += int(line)
str_sum=str(sum)
print(str_sum[:10])
