#include "kernel/low_level.h"

#include "drivers/screen.h"

int get_screen_offset(int col, int row);
int get_cursor();
void set_cursor(int);
int handle_scrolling(int cursor_offset);

// print a char on the screen at col, row or at cursor position
void print_char(char character, int col, int row, char attribute_byte) {
    // create a byte (char) pointer to the start of video memory
    unsigned char *vidmem = (unsigned char*)VIDEO_ADDRESS;

    // if attribute byte is zero, assume default style
    if (!attribute_byte)
        attribute_byte = WHITE_ON_BLACK;

    // get the video memory offset for the screen location
    int offset;
    // if col and row are non-negative, use them for offset
    if (col>=0 && row>=0)
        offset = get_screen_offset(col, row);
    else 
        offset = get_cursor();

    // if we see a newline character, set offset to the end of 
    // current row, so it will be advanced to the first col of the next row
    if (character == '\n') {
        int rows = offset / (2*MAX_COLS);
        offset = get_screen_offset(79, rows);
        // othewrise, write the character and its attribute byte to
        // video memory at our calculated offset
    } else {
        vidmem[offset] = character;
        vidmem[offset+1] = attribute_byte;
    }

    // update the offset to the next character cell, which is 2 bytes, 
    // ahead of the current cell
    offset += 2;

    // make scrolling adjustment, for when we reach the bottom of the screen
//    offset = handle_scrolling(offset);

    // update hte cursor position on the screen device
    set_cursor(offset);
}

int get_screen_offset(int col, int row) {
    return 2 * (row * MAX_COLS + col);
}

int get_cursor() {
    // the device uses its control register as an index to select
    // its itnernal registers, of which we are interested in 
    //   reg 14: which is the high byte of the cursor's offset
    //   reg 15: which is the low byte of the cursor's offset
    // once the internal register has been selected, we may read or 
    // write a byte ont he data register
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);

    // since the cursor offset reported by the VGA hardware is the number of 
    // cells, we multiply by two to convert it to a character offset
    return offset * 2;
}

void set_cursor(int offset) {
    offset /= 2; // convert from char offset to cell offset

    // this is similar to get_cursor, only now we write 
    // bytes to those internal device registers
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0x000000ff));
}

void print_at(char* msg, int col, int row) {
    // update the cursor if col and row not negative
    if (col>=0 && row>=0)
        set_cursor(get_screen_offset(col, row));

    // loop through each char of the message and print it
    int i = 0;
    while (msg[i] != 0)
        print_char(msg[i++], col, row, WHITE_ON_BLACK);
}

void print(char* message) {
    print_at(message, -1, -1);
}

void clear_screen() {
    int row=0, col=0;

    // loop through video memory and write blank characters
    for (row=0; row<MAX_ROWS; row++)
        for (col=0; col<MAX_COLS; col++)
            print_char(' ', col, row, WHITE_ON_BLACK);

    // move the cursor back to the top left
    set_cursor(get_screen_offset(0, 0));
}

// advance the text cursor, scrolling the video buffer if necessary
int handle_scrolling(int cursor_offset) {
    // if the cursor is within the screen, return it unmodified
    if (cursor_offset < MAX_ROWS*MAX_COLS*2)
        return cursor_offset;

    // shuffle rows back one
    int i = 1;
    for (; i<MAX_ROWS; i++)
        memory_copy(get_screen_offset(0, i) + VIDEO_ADDRESS,
                    get_screen_offset(0, i-1) + VIDEO_ADDRESS,
                    MAX_COLS*2);

    // blank the last line by setting all bytes to 0
    char* last_line = (char*)(get_screen_offset(0, MAX_ROWS-1) + VIDEO_ADDRESS);
    for (i=0; i<MAX_COLS*2; i++)
        last_line[i] = 0;

    // move the offset back one row, such that it is now on the last 
    // row, rather than off the edge of the screen
    cursor_offset -= 2*MAX_COLS;

    // return updated cursor position
    return cursor_offset;
}
