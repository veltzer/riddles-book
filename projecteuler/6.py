s1 = 0
s2 = 0
for i in range(101):
    s1 += i**2
    s2 += i
s2 *= s2
print(s2-s1)
