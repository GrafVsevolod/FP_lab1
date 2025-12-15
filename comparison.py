def euler6(n=100):
    s = sum(range(1, n + 1))
    return s * s - sum(i * i for i in range(1, n + 1))

def euler25(digits=1000):
    a, b, idx = 1, 1, 2  # F1=1, F2=1
    while len(str(b)) < digits:
        a, b = b, a + b
        idx += 1
    return idx

if __name__ == "__main__":
    print("Euler 6:", euler6())     # 25164150
    print("Euler 25:", euler25())   # 4782
