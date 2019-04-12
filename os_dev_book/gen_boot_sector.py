def gen_boot_sector():
    zeroes = [int("0", 16) for i in range(512)]
    return zeroes

if __name__ == "__main__":
    # generate boot sector 512 zeroes
    bootSectorBytes = gen_boot_sector()
    print("%d bytes" % len(bootSectorBytes))

    # modify the first 3 bytes
    # x86 inst for endless jump
    bootSectorBytes[0] = int("e9", 16)
    bootSectorBytes[1] = int("fd", 16)
    bootSectorBytes[2] = int("ff", 16)

    # modify the last 2 bytes
    # magic number to tell bios that this is indeed a boot block and not just data
    bootSectorBytes[-1] = int("aa", 16)
    bootSectorBytes[-2] = int("55", 16)

    # dump to binary file
    with open("boot_sector.bin", "wb") as f:
        f.write(bytearray(bootSectorBytes))
