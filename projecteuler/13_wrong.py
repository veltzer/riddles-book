"""
This is wrong!
"""

with open("13_wrong.txt", "rt") as f:
    sum = 0
    for line in f:
        sum += int(line[:12])
str_sum=str(sum)
print("result with only first 12 digits")
print(str_sum[:10])

# and now for the right solution
with open("13_wrong.txt", "rt") as f:
    sum = 0
    for line in f:
        sum += int(line)
str_sum=str(sum)
print("result with all digits")
print(str_sum[:10])
