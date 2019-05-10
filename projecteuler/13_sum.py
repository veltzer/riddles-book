
with open("13.txt", "rt") as f:
    digits = []
    for line in f:
        num = []
        for c in reversed(line):
            if c!='\n':
                num.append(int(c))
        digits.append(num)

result = []
carry = 0
for i in range(50):
    for num in digits:
         carry += num[i]
    result.append(carry % 10)
    carry = carry // 10
i+=1
while carry !=0:
    result.append(carry % 10)
    carry = carry // 10
    i += 1
print(''.join(map(lambda x: str(x), reversed(result[i-10::1]))))
