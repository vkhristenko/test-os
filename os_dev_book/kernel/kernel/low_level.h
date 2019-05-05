#ifndef low_level_h
#define low_level_h

unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short potr, unsigned char data);
unsigned short port_word_in(unsigned short port);
void port_word_out(unsigned short port, unsigned short data);

#endif // low_level_h
