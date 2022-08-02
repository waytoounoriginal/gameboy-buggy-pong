


#ifndef __DEFINES_HEADER__
#define __DEFINES_HEADER__
#define uint8 unsigned int

#define MIDX SCREENWIDTH/2
#define MIDY SCREENHEIGHT/2

#define SPRITE_HEIGHT 8

#define BALL_SPRITE 6

#define FRAMES_TO_WAIT 10           //  Time to wait for the ball to respawn


#define joy joypad()
#define UP (joy & J_UP)
#define DOWN (joy & J_DOWN)
// #define LEFT (joy & J_LEFT)
// #define RIGHT (joy & J_RIGHT)



#define PLAYER_TILE_LOCATION 17
#define AI_TILE_LOCATION 1

#define CONSTANT_HEIGHT 1


#endif

