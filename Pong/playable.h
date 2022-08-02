#include <gb/gb.h>

#ifndef uint8
#define uint8 unsigned int
#endif


typedef struct Character
{
    uint8 spriteids[3];
    uint8_t x, y;
    uint8 height, width;

    uint8 score;
    
} Character;