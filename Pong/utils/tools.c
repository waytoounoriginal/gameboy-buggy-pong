/**
 * @file tools.c
 * @author Mihai4544
 * @brief  A toolset for making my life easier, as well as experiment with C.
 * @date 2022-07-31
 * 
 * @copyright Copyright (c) 2022
 * 
 */



#include "lettermapping.h"
#include <stdlib.h>
#include <rand.h>
#include <stdint.h>
#include <string.h>
#include <gb/gb.h>
#include <gbdk/font.h>



#ifndef uint8
#define uint8 uint8_t
#endif


static const unsigned char clear_map[] = 
{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

inline void clearBKG(uint8_t x, uint8_t y)
{
    set_bkg_tiles(x, y, 20, 18, clearBKGTiles);
}


// Clears a portion of the score in case it gets bugged.

inline void clear_portion(uint8_t x)
{
    set_win_tiles(x, 1, 8, 1, clear_map);    
}


/**  A more performant delay?
 *  @param loops is not reffering to the seconds it takes.
 * 
 */
inline void performanceDelay(uint8 loops)
{
    uint8 i;
    for(i = 0; i < loops; i++){
        wait_vbl_done();
    }
}

inline uint8_t number_count_minimal(uint8 score)
{

    if(score < 10)
    {
        return 0;
    }
    else if(score < 100)
    {
        return 1;
    }
    else if(score < 1000)
    {
        return 2;
    }
    else return 3;
}


/** Converts an integer num to string.
 * 
 * Mostly for debug reasons
 * 
 */
char* toString(uint8 num)
{
    //char a[9];  //  Supports 9 digits
    //memset(a, 0, 9);
    static const char digits[11] = "0123456789";
    uint8_t size = number_count_minimal(num);

    char *a = malloc((size + 1) * sizeof(char));

    // UBYTE ok = num % 10;     //  Checks if the number ends with a 0
    // uint8_t count = 0;

    uint8_t i = size + 1;
    a[i --] = '\0';

    while(num)
    {
        a[i --] = digits[num%10];
        num /=10;
    }

    return a;
   
}


inline char transform_text(char text)
{
    switch(text)
    {
        case 'A':
	        return A;
        case 'B':
            return B;
        case 'C':
            return C;
        case 'D':
            return D;
        case 'E':
            return E;
        case 'F':
            return F;
        case 'G':
            return G;
        case 'H':
            return H;
        case 'I':
            return I;
        case 'J':
            return J;
        case 'K':
            return K;
        case 'L':
            return L;
        case 'M':
            return M;
        case 'N':
            return N;
        case 'O':
            return O;
        case 'P':
            return P;
        case 'Q':
            return Q;
        case 'R':
            return R;
        case 'S':
            return S;
        case 'T':
            return T;
        case 'U':
            return U;
        case 'V':
            return V;
        case 'W':
            return W;
        case 'X':
            return X;
        case 'Y':
            return Y;
        case 'Z':
            return Z;
        case '0':
            return ZERO;
        case '1':
            return ONE;
        case '2':
            return TWO;
        case '3':
            return THREE;
        case '4':
            return FOUR;
        case '5':
            return FIVE;
        case '6':
            return SIX;
        case '7':
            return SEVEN;
        case '8':
            return EIGHT;
        case '9':
            return NINE;
        default:
            return 0x00;


    }

}

/**
 * @brief A function to make and display text
 * 
 * 
 *
 * @param x represents the tiles on the X axis 
 * 
 * @param y represents the tiles on the Y axis
 * 
 * @param w represents the width
 * 
 * @param h represents the height
 * 
 * @param text[] represents a string literal
 */
void make_show_win_map(int x, int y, int h, char text[])
{

    int w = strlen(text);

    unsigned char* win_map = malloc(sizeof(unsigned char) * w * h);

    for(int i = 0; i < w * h; ++i)
    {
        win_map[i] = transform_text(text[i]);
    }

    set_win_tiles(x, y, w, h, win_map);

    free(win_map);

}

/**Random seed generator I found on StackOverFlow
 * 
 * 
 * By basxto
 * 
 * 
 */
inline void randomSeed() 
{
    uint16_t seed = LY_REG;
    seed |= (uint16_t)DIV_REG << 8;
    initrand(seed);
}




void initGame() {
    
    // font_t min_font;

    // font_init();
    // min_font = font_load(font_min);


    DISPLAY_ON;

    printf("\n\n\n\n\n\n\n      PRESS START!\n");
    waitpad(J_START);
    randomSeed();
    printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
}