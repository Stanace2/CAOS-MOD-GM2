function scr_wmp_freefall() //gml_Script_scr_wmp_freefall  
{  
    landAnim = 1  
    vsp++  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_bodyslamstart)  
        sprite_index = spr_bodyslamfall  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_shotgunjump1)  
        sprite_index = spr_shotgunjump3  
    move = key_left + key_right  
    if (!grounded)  
    {  
        if (sprite_index != spr_rockethitwall)  
            hsp = move * movespeed  
        else  
            hsp = 0  
        if (move != xscale && movespeed != 0)  
            movespeed -= 0.5  
        if ((move == 0 && momemtum == 0) || scr_solid((x + hsp), y))  
        {  
            movespeed = 0  
            mach2 = 0  
        }  
        if (move != 0 && movespeed < 7)  
            movespeed += 0.5  
        if ((scr_solid((x + 1), y) && move == 1) || (scr_solid((x - 1), y) && move == -1))  
            movespeed = 0  
    }  
    var blockofpizza = scr_solid(x, (y - 1))  
    while blockofpizza  
    {  
        y++  
        if (!(scr_solid(x, y)))  
            break  
        else  
            continue  
    }  
    if (grounded && (!blockofpizza) && vsp > 0 && (freefallsmash < 10 || (!(place_meeting(x, (y + vsp), obj_metalblock)))) && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + vsp + 6), obj_destructibles))))  
    {  
        if scr_slope()  
        {  
            with (instance_place(x, (y + 1), obj_slope))  
            {  
                other.xscale = (-sign(image_xscale))  
                with (instance_create(other.x, other.y, obj_jumpdust))  
                    image_xscale = (-sign(other.image_xscale))  
                with (other)  
                    scr_wm_doroll(true)  
            }  
        }  
        else  
        {  
            if (move != xscale && move != 0)  
            {  
                movespeed = 0  
                hsp = 0  
                clingexitspeed = 0  
            }  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            if (sprite_index == spr_player_poundcancel1)  
                sprite_index = spr_player_poundcancel2  
            else if (shotgunAnim == 0)  
                sprite_index = spr_bodyslamland  
            else  
                sprite_index = spr_shotgunjump2  
            image_index = 0  
            state = states.freefallland
            jumpAnim = 1  
            jumpstop = 0  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            if (freefallsmash >= 10)  
            {  
                with (obj_baddie)  
                {  
                    if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                    {  
                        state = states.stun
                        if (stunned < 60)  
                            stunned = 60  
                        vsp = -11  
                        image_xscale *= -1  
                        hsp = 0  
                        momentum = 0  
                    }  
                }  
                with (obj_camera)  
                {  
                    shake_mag = 10  
                    shake_mag_acc = 30 / room_speed  
                }  
                combo = 0  
                bounce = 0  
            }  
            create_particle(x, (y + 3), particletypes.groundpoundeffect, 0)  
            freefallstart = 0  
        }  
    }  
    image_speed = 0.35  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
}