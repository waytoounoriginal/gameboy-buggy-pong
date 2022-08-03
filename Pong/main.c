#include <gb/gb.h>
#include <gbdk/font.h>
#include <stdio.h>

#include "Sprites/character.c"
#include "playable.h"
#include "defines.h"

#include "utils/tools.c"
#include "utils/Sound/sound.c"

#include "Sprites/ScreenTitle.c"
#include "Sprites/ScreenTitleMap.c"



//  Defining the tiles

const uint8_t top = 0;
const uint8_t mid = 1;
const uint8_t low = 2;
const uint8_t ball = 3;

/////////////////////////////////

UBYTE gamePaused = 1;

////////////////////////////////

Character player, AI;



uint8 xBall = MIDX, yBall = MIDY;

int8_t speed_y, speed_x;

uint8_t AICentre, ballCentre;

UBYTE canAImove = 0;

//////////////////////////////////

uint8_t timer = 0;
UBYTE ball_alive;

/////////////////////////////////

void flashy_start(uint8_t frames)
{
    for(uint8_t i = 0; i < frames; ++i)
    {
        set_bkg_tiles(5, 12, 11, 1, pressStartMap);
        performanceDelay(3);
        set_bkg_tiles(5, 12, 11, 1, clear_map);
        performanceDelay(3);
    }

}

void init_min_font()
{
    font_t min_font;

    

    font_init();
    min_font = font_load(font_min);

    font_set(min_font);

    // make_show_win_map(AI_TILE_LOCATION, 1, 1, "0");

    // make_show_win_map(PLAYER_TILE_LOCATION, 1, 1, "0");

    //  move_win(0, 40);
}




void init_map()
{


    get_bkg_data(0, 14, TileLabel);   //  Ignores the 'air' tile
    set_bkg_data(MAP_START, 14, TileLabel);
    set_bkg_tiles(3, 0, 20, 18, screenTitleMap);

    set_bkg_tiles(5, 12, 11, 1, pressStartMap);

    SHOW_BKG;

    



}


void start_game()
{
    DISPLAY_ON;

    init_min_font();
    sound_init();

    init_map();

    waitpad(J_START);

    flashy_start(5);
    gamePaused = 0;

    HIDE_BKG;
    //  clearBKG(0, 18);

}



///////////////////////////////////

void moveCharacter(Character* charac, uint8 x, uint8 y)
{
    move_sprite(charac->spriteids[0], x, y);
    move_sprite(charac->spriteids[1], x, y + SPRITE_HEIGHT);
    move_sprite(charac->spriteids[2], x, y + 2 * SPRITE_HEIGHT);
}


//  Init functions      ///////////////////////////////////////////////////////////////////////

void init_score()
{
    make_show_win_map(AI_TILE_LOCATION, 1, 1, "0");

    make_show_win_map(PLAYER_TILE_LOCATION, 1, 1, "0");

    SHOW_WIN;
}


void update_score(uint8 score, uint8_t tile)
{
    clear_portion(tile);

    make_show_win_map(tile == PLAYER_TILE_LOCATION
    ? tile - number_count_minimal(score)
    : tile + number_count_minimal(score), 1, 1, toString(score));

}


void init_player()
{
    player.width = 8;
    player.height = 24;

    player.x = 140;
    player.y = MIDY;

    player.score = 0;

    set_sprite_tile(0, 0);
    player.spriteids[0] = 0;
    set_sprite_tile(1, 1);
    player.spriteids[1] = 1;
    set_sprite_tile(2, 2);
    player.spriteids[2] = 2;

    moveCharacter(&player, player.x, player.y);

}

void init_AI()
{
    AI.width = 8;
    AI.height = 24;

    AI.x = 20;
    AI.y = MIDY;

    AI.score = 0;

    set_sprite_tile(3, 0);
    AI.spriteids[0] = 3;
    set_sprite_tile(4, 1);
    AI.spriteids[1] = 4;
    set_sprite_tile(5, 2);
    AI.spriteids[2] = 5;

    AICentre = AI.y + AI.height/2;

    moveCharacter(&AI, AI.x, AI.y);

}

void init_ball()
{
    xBall = MIDX;
    yBall = MIDY + SPRITE_HEIGHT;

    ballCentre = yBall + 4;

    //  The initial Y speed
    speed_y = 3;
    speed_x = 1;

    ball_alive = 1;

    //  Positive values will move the ball downwards, negative will move it upwards.
    //  The sign of the speed will change;

    set_sprite_tile(BALL_SPRITE, ball);
    move_sprite(BALL_SPRITE, xBall, yBall);
}

///////////////////////////////////////////////////////////////////////////////////////////


inline void fix_collision(Character* character)
{
    if(xBall >= character->x + character->width)
    {
        xBall += 1;
    }
    else if(xBall <= character->x)
    {
        xBall -= 1;
    }
    else if(yBall >= character->y + character->height)
    {
        yBall += 1;
    }
    else
    {
        yBall -= 1;
    }
}


inline UBYTE collision(Character* character)
{
    if(
        ((character->x >= xBall && character->x <= xBall + SPRITE_HEIGHT) && (character->y >= yBall && character->y <= yBall + SPRITE_HEIGHT))
        ||
        ((xBall >= character->x && xBall <= character->x + character->width) && (yBall >= character->y && yBall <= character->y + character->height))
        ||
        ((xBall + SPRITE_HEIGHT >= character->x && xBall + SPRITE_HEIGHT <= character->x + character->width) && (yBall + SPRITE_HEIGHT >= character->y && yBall + SPRITE_HEIGHT <= character->y + character->height))

    
    )
    {
        fix_collision(character);


        return 1;
    }

    return 0;

}


void movement()
{
        if(UP)
        {
            player.y -= 4;
            //  AI.y -=4;
        }

        if(DOWN)
        {
            player.y += 4;
            //  AI.y += 4;
        }

        if(player.y <= 20)
            player.y = 20;
        else if(player.y >= SCREENHEIGHT - 20)
            player.y = SCREENHEIGHT - 20;

        moveCharacter(&player, player.x, player.y);
        //  moveCharacter(&AI, AI.x, player.y);
}

void ai_movement(uint8_t offset, uint8_t speed)
{



    if(AICentre + offset < ballCentre)
    {
        AI.y += speed;
    }
    else if(AICentre - offset > ballCentre)
    {
        AI.y -= speed;
    }

        if(AI.y <= 20)
            AI.y = 20;
        else if(AI.y >= SCREENHEIGHT - 20)
            AI.y = SCREENHEIGHT - 20;

    AICentre = AI.y + AI.height/2;

    moveCharacter(&AI, AI.x, AI.y);

}




inline void kill_ball()
{

    timer = FRAMES_TO_WAIT;
    ball_alive = 0;

    set_sprite_tile(BALL_SPRITE, 255);

}


inline void respawn_ball()
{
    xBall = MIDX;
    yBall = MIDY + SPRITE_HEIGHT;

    ballCentre = yBall + 4;

    speed_y = (rand() % 10 - 5);
    speed_x = 1;

    canAImove = 0;

    set_sprite_tile(BALL_SPRITE, ball);

    move_sprite(BALL_SPRITE, xBall, yBall);
}


void ball_movement()
{

    UBYTE collisioned = collision(&player) || collision(&AI);

    if(collisioned)
    {
        
        
        speed_y = (rand() % 10 - 5) * -1;
        if((speed_x > -4 && speed_x < 0) || (speed_x < 4 && speed_x > 0))
        {
            speed_x > 0 ? ++speed_x : --speed_x;        //  Acceleration
        }

        speed_x *= -1;

        canAImove = !canAImove;

    

        play_jumpy_sound();
    }
    
    if(yBall <= 20)
    {
        speed_y *= -1;
    }
    else if(yBall >= SCREENHEIGHT)
    {
        speed_y *= -1;
    }

    

    if((xBall >= player.x + player.width + 2))
    {
        AI.score++;
        update_score(AI.score, AI_TILE_LOCATION);
        play_score();

        kill_ball();


    }
    else if((xBall <= AI.x - 2))
    {
        player.score++;
        update_score(player.score, PLAYER_TILE_LOCATION);
        play_score();

        kill_ball();


    }

    xBall += speed_x;
    yBall += speed_y;
    ballCentre = yBall + 4;

    move_sprite(BALL_SPRITE, xBall, yBall);
    wait_vbl_done();
}


void main()
{

    start_game();
    //  init_min_font();

    init_score();

    set_sprite_data(0, 4, character);

    init_player();
    init_AI();
    init_ball();


    SHOW_SPRITES;
    //  SHOW_WIN;
    SHOW_BKG;

    waitpad(J_START);
    randomSeed();

    while(1)
    {

        if(ball_alive)
        {
            ball_movement();
        }
        else if(!ball_alive && !timer)
        {
            respawn_ball();
            ball_alive = 1;
        }
        else if(!ball_alive && timer)
        {
            --timer;
        }

        movement();

        if(ball_alive && canAImove)
        {
            ai_movement(0, 4);
        }
        
        // if(joy && J_A)
        // {
        //     printf(toString(xBall));
        //     // make_show_win_map(PLAYER_TILE_LOCATION, 1, 1, "3");
        // }
        //  DEBUG


        performanceDelay(1);        //  More fluid but you gotta modify the speeds


    }

}