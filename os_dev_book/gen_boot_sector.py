sector_as_str = "e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00" +\
         "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" +\
         "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" +\
         "00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa"
sector_as_list = [int(x, 16) for x in sector_as_str.split(" ")]

if __name__ == "__main__":
    print(sector_as_list)
    print(bytes(sector_as_list))
    with open("boot_sector.bin", "wb") as f:
        f.write(bytes(sector_as_list))
