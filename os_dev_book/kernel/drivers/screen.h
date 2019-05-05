#ifndef screen_h
#define screen_h

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// attribute byte four our default colour scheme
#define WHITE_ON_BLACK 0x0f

// screen device I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void print(char* msg);
void clear_screen();

#endif // screen_h
