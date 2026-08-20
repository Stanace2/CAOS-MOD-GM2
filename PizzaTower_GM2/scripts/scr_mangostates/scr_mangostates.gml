function scr_mangostates(){
	switch substate  
	{  
		// Normal
	    case states.normal:  
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
	            substate = states.jump  
	        }  
	        if (relativestate == states.dynamite)  
	            substate = states.dynamite  
	        if (relativestate == states.machslide)  
	            substate = states.machslide  
	        if (relativestate == states.mach3)  
	            substate = states.mach3  
	        if (relativestate == states.crouch)  
	            substate = states.crouch  
	        break  
	    // Katana
	    case states.dynamite: 
	        sprite_index = spr_lonemango_pose  
	        if (relativestate == states.mach2)  
	        {  
	            substate = states.mach2  
	            slashbuffer = 0  
	        }  
	        if (relativestate == states.dynamite)  
	            slashbuffer = 10  
	        else if (slashbuffer > 0)  
	            slashbuffer--  
	        if (slashbuffer == 0)  
	            substate = relativestate  
	        break  
	    // Tumble
	    case states.tumble:  
	        sprite_index = spr_lonemango_tumble  
	        if (playerid.sprite_index == playerid.spr_dive && (!grounded))  
	            sprite_index = spr_lonemango_dive  
	        if (relativestate == states.normal)  
	            substate = states.normal  
	        if (relativestate == states.climbwall)  
	            substate = states.climbwall  
	        if (relativestate == states.jump)  
	            substate = states.jump  
	        if (relativestate == states.mach2)  
	        {  
	            substate = states.mach2  
	            sprite_index = spr_lonemango_longjump  
	            image_index = 0  
	        }  
	        if (relativestate == states.mach3)  
	        {  
	            flash = 1  
	            substate = states.mach3  
	        }  
	        if (relativestate == states.bump)  
	        {  
	            substate = states.bump  
	            image_index = 0  
	        }  
	        break  
	    // Wallclimb
	    case states.climbwall:  
	        sprite_index = spr_lonemango_cling  
	        if (playerid.state == states.normal)  
	            substate = states.normal  
	        if (playerid.state == states.dynamite)  
	            substate = states.dynamite  
	        if (playerid.state == states.crouch)  
	            substate = states.crouch  
	        if (playerid.state == states.mach3)  
	        {  
	            flash = 1  
	            substate = states.mach3  
	        }  
	        if (playerid.state == states.mach2)  
	        {  
	            substate = states.mach2  
	            sprite_index = spr_lonemango_longjump  
	            image_index = 0  
	        }  
	        if (playerid.state == states.jump && substate != states.mach3 && substate != states.mach2)  
	        {  
	            substate = states.jump  
	            sprite_index = spr_lonemango_fall  
	        }  
	        if (playerid.state == states.freefall)  
	        {  
	            substate = states.freefall  
	            sprite_index = spr_lonemango_groundpound_start  
	            image_index = 0  
	        }  
	        if (playerid.state != states.climbwall)  
	        {  
	            substate = playerid.state  
	            relativestate = playerid.state  
	        }  
	        break  
	    // Jaws and ballmode
	    case states.punch:  
	    case states.ratmountbounce:  
	        sprite_index = spr_lonemango_pose  
	        substate = states.dynamite  
	        break  
	    // Jump
	    case states.jump:  
	        if (sprite_index == spr_lonemango_cling)  
	            sprite_index = spr_lonemango_fall  
	        if (sprite_index == spr_wm_idle)  
	            sprite_index = spr_lonemango_fall  
	        if (floor(image_index) == (image_number - 1))  
	        {  
	            if (sprite_index == spr_lonemango_jump)  
	                sprite_index = spr_lonemango_fall  
	        }  
	        if grounded  
	            substate = states.normal  
	        if (relativestate == states.dynamite)  
	            substate = states.dynamite  
	        if (relativestate == states.climbwall)  
	            substate = states.climbwall  
	        if (relativestate == states.freefall)  
	        {  
	            substate = states.freefall  
	            sprite_index = spr_lonemango_groundpound_start  
	            image_index = 0  
	        }  
	        break  
	    // Ladder
	    case states.ladder:  
	        sprite_index = spr_lonemango_ladder  
	        if (playerid.vsp == 0.5)  
	            image_index = 0  
	        if (relativestate != states.ladder)  
	            substate = states.normal  
	        break  
	    // crouch and roll
	    case states.crouch:  
	    case states.crouchjump:  
	        if (playerid.sprite_index == spr_wethamroll && sprite_index != spr_lonemango_roll)  
	        {  
	            sprite_index = spr_lonemango_roll  
	            image_index = 0  
	        }  
	        if (floor(image_index) == (image_number - 1))  
	        {  
	            if (sprite_index == spr_lonemango_roll)  
	            {  
	                if (relativestate == states.tumble)  
	                {  
	                    sprite_index = spr_lonemango_tumble  
	                    substate = states.tumble  
	                }  
	                else  
	                {  
	                    flash = 1  
	                    substate = states.normal  
	                }  
	            }  
	        }  
	        if (sprite_index != spr_lonemango_roll && substate != states.tumble)  
	        {  
	            if moving  
	                sprite_index = spr_lonemango_crawl  
	            else  
	                sprite_index = spr_m_wait4
	            if (relativestate == states.normal)  
	                substate = states.normal  
	            if (relativestate == states.tumble)  
	            {  
	                sprite_index = spr_lonemango_tumble  
	                substate = states.tumble  
	            }  
	            if (relativestate == states.jump)  
	                substate = states.jump  
	            if (relativestate == states.mach2)  
	            {  
	                substate = states.mach2  
	                sprite_index = spr_lonemango_longjump  
	                image_index = 0  
	            }  
	            if (relativestate == states.mach3)  
	                substate = states.mach3  
	            if (relativestate == states.bump)  
	            {  
	                substate = states.bump  
	                image_index = 0  
	            }  
	        }  
	        if (sprite_index == spr_lonemango_roll)  
	        {  
	            if (playerid.sprite_index == playerid.spr_dive && (!grounded))  
	            {  
	                substate = states.tumble  
	                sprite_index = spr_lonemango_dive  
	            }  
	            if (relativestate == states.bump)  
	            {  
	                substate = states.bump  
	                image_index = 0  
	            }  
	            if (relativestate == states.mach2)  
	            {  
	                substate = states.mach2  
	                sprite_index = spr_lonemango_longjump  
	                image_index = 0  
	            }  
	            if (relativestate == states.climbwall)  
	                substate = states.climbwall  
	        }  
	        break  
	    // Mach2
	    case states.mach2:  
	        if (floor(image_index) == (image_number - 1))  
	        {  
	            if (sprite_index == spr_lonemango_longjump)  
	                sprite_index = spr_lonemango_longjump_end  
	        }  
	        if (sprite_index != spr_lonemango_longjump)  
	            sprite_index = spr_lonemango_longjump_end  
	        if (relativestate == states.normal)  
	            substate = states.normal  
	        if (relativestate == states.dynamite)  
	            substate = states.dynamite  
	        if (relativestate == states.machslide)  
	            substate = states.machslide  
	        if (relativestate == states.mach3)  
	            substate = states.mach3  
	        if (relativestate == states.climbwall)  
	            substate = states.climbwall  
	        if (relativestate == states.freefall)  
	        {  
	            substate = states.freefall  
	            sprite_index = spr_lonemango_groundpound_start  
	            image_index = 0  
	        }  
	        break  
	    // Machslide
	    case states.machslide:  
	        sprite_index = spr_mango_skid  
	        if (relativestate != states.machslide)  
	            substate = states.normal  
	        break  
	    // Crash
	    case states.bump:  
	        sprite_index = spr_lonemango_wallsplat  
	        if (floor(image_index) == (image_number - 1))  
	            image_index = image_number - 1  
	        if (relativestate != states.bump)  
	            substate = states.normal  
	        break  
	    // Hurt
	    case states.hurt:  
	        sprite_index = spr_mango_cries  
	        if (relativestate != states.hurt)  
	            substate = states.normal  
	        break  
	    // Bodyslam
	    case states.freefallland:  
	    case states.freefall:  
	        if (string_copy(sprite_get_name(sprite_index), 1, 25) != "spr_lonemango_groundpound")  
	            sprite_index = spr_lonemango_groundpound_start  
	        if (floor(image_index) == (image_number - 1))  
	        {  
	            if (sprite_index == spr_lonemango_groundpound_start)  
	                sprite_index = spr_lonemango_groundpound  
	            if (sprite_index == spr_lonemango_groundpound_land)  
	                substate = states.normal  
	        }  
	        if grounded  
	            sprite_index = spr_lonemango_groundpound_land  
	        if (relativestate == states.normal)  
	            substate = states.normal  
	        if (relativestate == states.mach2)  
	        {  
	            substate = states.mach2  
	            sprite_index = spr_lonemango_longjump  
	            image_index = 0  
	        }  
	        if (relativestate == states.crouch)  
	            substate = states.crouch  
	        break  
	    // Mach3
	    case states.mach3:  
	        if grounded  
	            sprite_index = spr_lonemango_mach2  
	        else  
	            sprite_index = spr_lonemango_mach2_jump  
	        if (relativestate == states.normal)  
	            substate = states.normal  
	        if (relativestate == states.dynamite)  
	            substate = states.dynamite  
	        if (relativestate == states.tumble)  
	            substate = states.tumble  
	        if (relativestate == states.climbwall)  
	            substate = states.climbwall  
	        if (relativestate == states.jump)  
	            substate = states.jump  
	        if (relativestate == states.crouch)  
	            substate = states.crouch  
	        if (relativestate == states.mach2)  
	        {  
	            substate = states.mach2  
	            sprite_index = spr_lonemango_longjump  
	            image_index = 0  
	        }  
	        if (relativestate == states.machslide)  
	            substate = states.machslide  
	        if (relativestate == states.bump)  
	        {  
	            substate = states.bump  
	            image_index = 0  
	        }  
	        break  
	    // Level exit
	    case states.backtohub:  
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
	        if (relativestate != states.backtohub)  
	            substate = relativestate  
	        break  
    }  
}