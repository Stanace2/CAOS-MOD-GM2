function scr_wmp_crouch()
{  
    if scr_wm_lastbreath()  
        return;  
    move = key_left + key_right  
    if (wcrouchbuffer > 0)  
    {  
        wcrouchbuffer--  
        if (move != 0 || key_attack)  
        {  
            sprite_index = spr_wm_roll  
            image_index = 0  
            wcrouchbuffer = 0  
        }  
    }  
    if (sprite_index == spr_wm_roll)  
    {  
        if (wrollbuffer > 0)  
            wrollbuffer--  
        hsp = xscale * movespeed + railmovespeed * raildir  
        image_speed = 0.35  
        if (movespeed < 11)  
            movespeed = Approach(movespeed, 11, 3)  
        if (wrollbuffer == 0 && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
        {  
            if key_jump2  
            {  
                image_index = 3  
                state = states.mach2
                vsp = -11  
                jumpAnim = 1  
                hsp = movespeed * xscale  
                fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
                sprite_index = spr_w_lonjump  
                return;  
            }  
            scr_wm_dokatana()  
        }  
        if (place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + xscale), y, obj_destructibles))))  
        {  
            if ((!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
            {  
                if place_meeting((x + xscale), y, obj_solid)  
                {  
                    if (place_meeting((x + sign(hsp)), y, obj_metalblock) && movespeed >= 12)  
                    {  
                        state = states.mach3
                        if (movespeed < 12)  
                            movespeed = 12  
                    }  
                    else if place_meeting(x, (y + 1), obj_slope)  
                    {  
                        clingexitspeed = movespeed  
                        scr_wm_dowallcling()  
                        vsp = -18.4  
                        wallclimbbuffer = 20  
                    }  
                    else  
                    {  
                        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                        state = states.bump 
                        image_index = 0  
                        sprite_index = spr_wallsplat  
                    }  
                }  
                else  
                {  
                    state = states.mach3
                    if (movespeed < 12)  
                        movespeed = 12  
                }  
            }  
            else  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                state = states.bump 
                image_index = 0  
                sprite_index = spr_wallsplat  
            }  
            return;  
        }  
        if (floor(image_index) == (image_number - 1))  
        {  
            if ((!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
            {  
                if key_down  
                {  
                    state = states.tumble
                    image_index = 0  
                    sprite_index = spr_backslideland  
                }  
                else if key_attack  
                {  
                    if (move == xscale || move == 0)  
                    {  
                        state = states.mach3 
                        if (movespeed < 12)  
                            movespeed = 12  
                    }  
                    else  
                    {  
                        movespeed = 8  
                        state = states.normal 
                    }  
                }  
                else  
                {  
                    movespeed = 8  
                    state = states.normal
                }  
            }  
            else  
            {  
                state = states.tumble  
                image_index = 0  
                sprite_index = spr_backslideland  
            }  
        }  
        if (!grounded)  
        {  
            state = states.tumble
            sprite_index = spr_dive  
        }  
        return;  
    }  
    if (!(place_meeting(x, (y + 1), obj_railparent)))  
        hsp = move * movespeed  
    else  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        hsp = move * movespeed + _railinst.movespeed * _railinst.dir  
    }  
    movespeed = 4  
    mask_index = spr_crouchmask  
    turning = 0  
    if ((!grounded) && (!key_jump))  
    {  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = states.freefall
        hsp = 0  
        pistolanim = -4  
        return;  
    }  
    if (grounded && (!key_down) && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && (!key_jump))  
    {  
        state = states.normal
        movespeed = 0  
        crouchAnim = 1  
        jumpAnim = 1  
        image_index = 0  
        mask_index = spr_player_mask  
    }  
    if (crouchAnim == 0)  
    {  
        if (move == 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_crouch  
            else  
                sprite_index = spr_shotgunduck  
        }  
        if (move != 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_crawl  
            else  
                sprite_index = spr_shotguncrawl  
        }  
    }  
    if (crouchAnim == 1)  
    {  
        if (move == 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_couchstart  
            else  
                sprite_index = spr_shotgungoduck  
            if (floor(image_index) == (image_number - 1))  
                crouchAnim = 0  
        }  
    }  
    if (move != 0)  
    {  
        xscale = move  
        crouchAnim = 0  
    }  
    image_speed = 0.45  
}