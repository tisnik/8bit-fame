for i in range(0, 200):
    print(f"{i*320},", end="")
    if i % 16 == 0:
        print()
        print("        dw ", end="")
