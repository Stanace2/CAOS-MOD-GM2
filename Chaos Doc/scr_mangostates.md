Script to handle sprite and looks for mango companion
~~~js
function scr_mangostates() //gml_Script_scr_mangostates  
{  
    switch substate  
    {  
	    // Normal
        case (0 << 0):  
            var ispr = spr_lonemango_idle  
            var wspr = spr_lonemango_walk  
            if (global.panic || global.combo >= 50)  
            {  
                ispr = spr_mango_idle_distressed  
                wspr = spr_mango_walk_distressed  
            }  
            if (playerid.sprite_index == playerid.spr_mach)  
                wspr = spr_lonemango_mach1  
            if moving  
                sprite_index = wspr  
            else  
                sprite_index = ispr  
            if (!grounded)  
            {  
                sprite_index = spr_lonemango_jump  
                image_index = 0  
                substate = (92 << 0)  
            }  
            if (relativestate == (2 << 0))  
                substate = (2 << 0)  
            if (relativestate == (105 << 0))  
                substate = (105 << 0)  
            if (relativestate == (121 << 0))  
                substate = (121 << 0)  
            if (relativestate == (100 << 0))  
                substate = (100 << 0)  
            break  
        // Katana
        case (2 << 0): 
            sprite_index = spr_lonemango_pose  
            if (relativestate == (104 << 0))  
            {  
                substate = (104 << 0)  
                slashbuffer = 0  
            }  
            if (relativestate == (2 << 0))  
                slashbuffer = 10  
            else if (slashbuffer > 0)  
                slashbuffer--  
            if (slashbuffer == 0)  
                substate = relativestate  
            break  
        // Tumble
        case (5 << 0):  
            sprite_index = spr_lonemango_tumble  
            if (playerid.sprite_index == playerid.spr_dive && (!grounded))  
                sprite_index = spr_lonemango_dive  
            if (relativestate == (0 << 0))  
                substate = (0 << 0)  
            if (relativestate == (37 << 0))  
                substate = (37 << 0)  
            if (relativestate == (92 << 0))  
                substate = (92 << 0)  
            if (relativestate == (104 << 0))  
            {  
                substate = (104 << 0)  
                sprite_index = spr_lonemango_longjump  
                image_index = 0  
            }  
            if (relativestate == (121 << 0))  
            {  
                flash = 1  
                substate = (121 << 0)  
            }  
            if (relativestate == (106 << 0))  
            {  
                substate = (106 << 0)  
                image_index = 0  
            }  
            break  
        // Wallclimb
        case (37 << 0):  
            sprite_index = spr_lonemango_cling  
            if (playerid.state == (0 << 0))  
                substate = (0 << 0)  
            if (playerid.state == (2 << 0))  
                substate = (2 << 0)  
            if (playerid.state == (100 << 0))  
                substate = (100 << 0)  
            if (playerid.state == (121 << 0))  
            {  
                flash = 1  
                substate = (121 << 0)  
            }  
            if (playerid.state == (104 << 0))  
            {  
                substate = (104 << 0)  
                sprite_index = spr_lonemango_longjump  
                image_index = 0  
            }  
            if (playerid.state == (92 << 0) && substate != (121 << 0) && substate != (104 << 0))  
            {  
                substate = (92 << 0)  
                sprite_index = spr_lonemango_fall  
            }  
            if (playerid.state == (108 << 0))  
            {  
                substate = (108 << 0)  
                sprite_index = spr_lonemango_groundpound_start  
                image_index = 0  
            }  
            if (playerid.state != (37 << 0))  
            {  
                substate = playerid.state  
                relativestate = playerid.state  
            }  
            break  
        // Jaws and ballmode
        case (80 << 0):  
        case (198 << 0):  
            sprite_index = spr_lonemango_pose  
            substate = (2 << 0)  
            break  
        // Jump
        case (92 << 0):  
            if (sprite_index == spr_lonemango_cling)  
                sprite_index = spr_lonemango_fall  
            if (sprite_index == spr_player_ratmountidle)  
                sprite_index = spr_lonemango_fall  
            if (floor(image_index) == (image_number - 1))  
            {  
                if (sprite_index == spr_lonemango_jump)  
                    sprite_index = spr_lonemango_fall  
            }  
            if grounded  
                substate = (0 << 0)  
            if (relativestate == (2 << 0))  
                substate = (2 << 0)  
            if (relativestate == (37 << 0))  
                substate = (37 << 0)  
            if (relativestate == (108 << 0))  
            {  
                substate = (108 << 0)  
                sprite_index = spr_lonemango_groundpound_start  
                image_index = 0  
            }  
            break  
        // Ladder
        case (93 << 0):  
            sprite_index = spr_lonemango_ladder  
            if (playerid.vsp == 0.5)  
                image_index = 0  
            if (relativestate != (93 << 0))  
                substate = (0 << 0)  
            break  
        // crouch and roll
        case (100 << 0):  
        case (101 << 0):  
            if (playerid.sprite_index == spr_wethamroll && sprite_index != spr_lonemango_roll)  
            {  
                sprite_index = spr_lonemango_roll  
                image_index = 0  
            }  
            if (floor(image_index) == (image_number - 1))  
            {  
                if (sprite_index == spr_lonemango_roll)  
                {  
                    if (relativestate == (5 << 0))  
                    {  
                        sprite_index = spr_lonemango_tumble  
                        substate = (5 << 0)  
                    }  
                    else  
                    {  
                        flash = 1  
                        substate = (0 << 0)  
                    }  
                }  
            }  
            if (sprite_index != spr_lonemango_roll && substate != (5 << 0))  
            {  
                if moving  
                    sprite_index = spr_lonemango_crawl  
                else  
                    sprite_index = spr_lonebrick_wait4  
                if (relativestate == (0 << 0))  
                    substate = (0 << 0)  
                if (relativestate == (5 << 0))  
                {  
                    sprite_index = spr_lonemango_tumble  
                    substate = (5 << 0)  
                }  
                if (relativestate == (92 << 0))  
                    substate = (92 << 0)  
                if (relativestate == (104 << 0))  
                {  
                    substate = (104 << 0)  
                    sprite_index = spr_lonemango_longjump  
                    image_index = 0  
                }  
                if (relativestate == (121 << 0))  
                    substate = (121 << 0)  
                if (relativestate == (106 << 0))  
                {  
                    substate = (106 << 0)  
                    image_index = 0  
                }  
            }  
            if (sprite_index == spr_lonemango_roll)  
            {  
                if (playerid.sprite_index == playerid.spr_dive && (!grounded))  
                {  
                    substate = (5 << 0)  
                    sprite_index = spr_lonemango_dive  
                }  
                if (relativestate == (106 << 0))  
                {  
                    substate = (106 << 0)  
                    image_index = 0  
                }  
                if (relativestate == (104 << 0))  
                {  
                    substate = (104 << 0)  
                    sprite_index = spr_lonemango_longjump  
                    image_index = 0  
                }  
                if (relativestate == (37 << 0))  
                    substate = (37 << 0)  
            }  
            break  
        // Mach2
        case (104 << 0):  
            if (floor(image_index) == (image_number - 1))  
            {  
                if (sprite_index == spr_lonemango_longjump)  
                    sprite_index = spr_lonemango_longjump_end  
            }  
            if (sprite_index != spr_lonemango_longjump)  
                sprite_index = spr_lonemango_longjump_end  
            if (relativestate == (0 << 0))  
                substate = (0 << 0)  
            if (relativestate == (2 << 0))  
                substate = (2 << 0)  
            if (relativestate == (105 << 0))  
                substate = (105 << 0)  
            if (relativestate == (121 << 0))  
                substate = (121 << 0)  
            if (relativestate == (37 << 0))  
                substate = (37 << 0)  
            if (relativestate == (108 << 0))  
            {  
                substate = (108 << 0)  
                sprite_index = spr_lonemango_groundpound_start  
                image_index = 0  
            }  
            break  
        // Machslide
        case (105 << 0):  
            sprite_index = spr_mango_skid  
            if (relativestate != (105 << 0))  
                substate = (0 << 0)  
            break  
        // Crash
        case (106 << 0):  
            sprite_index = spr_lonemango_wallsplat  
            if (floor(image_index) == (image_number - 1))  
                image_index = image_number - 1  
            if (relativestate != (106 << 0))  
                substate = (0 << 0)  
            break  
        // Hurt
        case (107 << 0):  
            sprite_index = spr_mango_cries  
            if (relativestate != (107 << 0))  
                substate = (0 << 0)  
            break  
        // Bodyslam
        case (111 << 0):  
        case (108 << 0):  
            if (string_copy(sprite_get_name(sprite_index), 1, 25) != "spr_lonemango_groundpound")  
                sprite_index = spr_lonemango_groundpound_start  
            if (floor(image_index) == (image_number - 1))  
            {  
                if (sprite_index == spr_lonemango_groundpound_start)  
                    sprite_index = spr_lonemango_groundpound  
                if (sprite_index == spr_lonemango_groundpound_land)  
                    substate = (0 << 0)  
            }  
            if grounded  
                sprite_index = spr_lonemango_groundpound_land  
            if (relativestate == (0 << 0))  
                substate = (0 << 0)  
            if (relativestate == (104 << 0))  
            {  
                substate = (104 << 0)  
                sprite_index = spr_lonemango_longjump  
                image_index = 0  
            }  
            if (relativestate == (100 << 0))  
                substate = (100 << 0)  
            break  
        // Mach3
        case (121 << 0):  
            if grounded  
                sprite_index = spr_lonemango_mach2  
            else  
                sprite_index = spr_lonemango_mach2_jump  
            if (relativestate == (0 << 0))  
                substate = (0 << 0)  
            if (relativestate == (2 << 0))  
                substate = (2 << 0)  
            if (relativestate == (5 << 0))  
                substate = (5 << 0)  
            if (relativestate == (37 << 0))  
                substate = (37 << 0)  
            if (relativestate == (92 << 0))  
                substate = (92 << 0)  
            if (relativestate == (100 << 0))  
                substate = (100 << 0)  
            if (relativestate == (104 << 0))  
            {  
                substate = (104 << 0)  
                sprite_index = spr_lonemango_longjump  
                image_index = 0  
            }  
            if (relativestate == (105 << 0))  
                substate = (105 << 0)  
            if (relativestate == (106 << 0))  
            {  
                substate = (106 << 0)  
                image_index = 0  
            }  
            break  
        // Level exit
        case (290 << 0):  
            if (sprite_index != spr_mango_slip_fallland)  
                sprite_index = spr_mango_slip_bump  
            if (grounded && playerid.sprite_index == playerid.spr_slipbanan2)  
                sprite_index = spr_mango_slip_fallland  
            if (grounded && sprite_index == spr_mango_slip_bump)  
            {  
                instance_create(x, (y + 39), obj_bangeffect)  
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            }  
            if (floor(image_index) == (image_number - 1) && sprite_index == spr_mango_slip_fallland)  
                image_index = image_number - 1  
            if (relativestate != (290 << 0))  
                substate = relativestate  
            break  
    }  
  
}
~~~