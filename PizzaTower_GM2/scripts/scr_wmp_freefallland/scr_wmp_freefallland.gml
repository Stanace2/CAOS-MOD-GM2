function scr_wmp_freefallland() //gml_Script_scr_wmp_freefallland  
{  
    mach2 = 0  
    jumpAnim = 1  
    dashAnim = 1  
    landAnim = 0  
    moveAnim = 1  
    stopAnim = 1  
    crouchslideAnim = 1  
    crouchAnim = 0  
    machhitAnim = 0  
    facehurt = 1  
    start_running = 1  
    alarm[4] = 14  
    vsp = 0  
    move = key_left + key_right  
    var window = 5  
    if (sprite_index != spr_wm_bombdive_land)  
    {  
        if (move != 0)  
            hsp = movespeed * move  
        else  
            movespeed = Approach(movespeed, 0, 1)  
        if (floor(image_index) == (image_number - 1))  
        {  
            facehurt = 1  
            sprite_index = spr_idle  
            image_index = 0  
            state = states.normal
            jumpstop = 1  
        }  
        if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        {  
            input_buffer_down = 0  
            image_index = 3  
            state = states.mach2 
            vsp = -14  
            jumpAnim = 1  
            if (movespeed < 12)  
                movespeed = 12  
            if (move != 0)  
                hsp = movespeed * move  
            else  
                hsp = movespeed * xscale  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
            sprite_index = spr_walljumpstart  
            return;  
        }  
        scr_wm_dokatana()  
        scr_wm_doroll()  
    }  
    else  
    {  
        if (floor(image_index) < window)  
        {  
            if (key_down && key_jump2 && floor(image_index) > 2)  
            {  
                if scr_wm_dobombdive(true)  
                    return;  
            }  
            if (input_buffer_down < 30 && input_buffer_down != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_down = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                scr_wm_doroll(true)  
                return;  
            }  
            if (input_buffer_chaos < 30 && input_buffer_chaos != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                if key_down  
                {  
                    movespeed = 12  
                    if scr_wm_dobombdive(true)  
                        return;  
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                    instance_create(x, y, obj_highjumpcloud2)  
                    movespeed = clingexitspeed  
                    if (movespeed < 12)  
                        movespeed = 12  
                    if (move != 0)  
                    {  
                        hsp = movespeed * move  
                        xscale = move  
                    }  
                    else  
                        hsp = movespeed * xscale  
                    clingexitspeed = 0  
                    scr_wm_dokatana(true)  
                    return;  
                }  
            }  
            if (input_buffer_slap < 30 && input_buffer_slap != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_slap = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                clingexitspeed = 0  
                scr_wm_dokatana(false, true)  
                return;  
            }  
            if (input_buffer_jump < 30 && input_buffer_jump != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_jump = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                sprite_index = spr_wm_airspin  
                image_index = 0  
                image_speed = 0.35  
                hoverspin = 15  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                clingexitspeed = 0  
                vsp = -11  
                state = states.mach2
                return;  
            }  
        }  
        if (floor(image_index) >= window)  
        {  
            clingexitspeed = 0  
            if key_jump2  
            {  
                input_buffer_jump = 0  
                scr_fmod_soundeffect(jumpsnd, x, y)  
                if (sprite_index != spr_shotgunshoot)  
                {  
                    sprite_index = spr_jump  
                    if shotgunAnim  
                        sprite_index = spr_shotgunjump  
                    else if (global.pistol && ispeppino)  
                        sprite_index = spr_player_pistoljump1  
                    image_index = 0  
                }  
                particle_set_scale(particletypes.highjumpcloud2, xscale, 1)  
                create_particle(x, y, particletypes.highjumpcloud2, 0)  
                vsp = -11  
                state = states.jump
                jumpAnim = 1  
                jumpstop = 0  
                if place_meeting(x, (y + 1), obj_railparent)  
                    railmomentum = 1  
                freefallstart = 0  
            }  
            scr_wm_dokatana()  
            scr_wm_doroll()  
            if (floor(image_index) == (image_number - 1))  
            {  
                facehurt = 1  
                sprite_index = spr_idle  
                image_index = 0  
                state = states.normal 
                jumpstop = 1  
            }  
        }  
    }  
    if (sprite_index == spr_wm_bombdive_land && floor(image_index) >= window && key_up)  
        image_speed = 0.65  
    else  
        image_speed = 0.35  
}