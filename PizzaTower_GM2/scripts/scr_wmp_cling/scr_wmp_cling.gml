function scr_wmp_cling()
{  
    if (wallclingbuffer > 0)  
    {  
        wallclingbuffer--  
        if (input_buffer_slap > 0)  
        {  
            input_buffer_slap = 0  
            wallclingbuffer = 0  
            wallclingpulse = 15  
            clingexitspeed = 16  
            vsp = -13  
            with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
            {  
                state = wrstates.wait
                image_xscale = other.xscale * 1.5  
                image_yscale = 1.5  
                image_index = 0  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_wallcurrent  
            }  
            katanawalloutbuffer = 10  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
        }  
    }  
    if (wallclingpulse > 0 && clingexitspeed > 8)  
    {  
        wallclingpulse--  
        if (clingexitspeed < 16)  
            vsp = clingexitspeed * -1  
        else  
            vsp = -16  
    }  
    if (wallstick > 0)  
    {  
        wallstick--  
        vsp = 0  
    }  
    if (katanawalloutbuffer > 0)  
    {  
        katanawalloutbuffer--  
        if (move == (xscale * -1))  
        {  
            scr_wm_dokatana(false, true)  
            katanawalloutbuffer = 0  
        }  
    }  
    movespeed = 0  
    hsp = 0  
    clingboost = 0  
    if (wallclimbbuffer > 0)  
        wallclimbbuffer--  
    if (verticalbuffer <= 0 && (!(scr_solid((x + xscale), y))) && (!(place_meeting(x, y, obj_verticalhallway))) && (!(place_meeting(x, (y - 12), obj_verticalhallway))))  
    {  
        if (vsp <= 0)  
        {  
            trace("climbwall out")  
            instance_create(x, y, obj_jumpdust)  
            var old_x = x  
            var old_y = y  
            var i = 0  
            scr_climboutchecker(i, old_x, old_y)  
            grounded = 1  
            wrollbuffer = 10  
            movespeed = clingexitspeed  
            if (movespeed < 8)  
                movespeed = 8  
            hsp = movespeed * xscale  
            vsp = 0  
            flash = 1  
            image_index = 0  
            sprite_index = spr_mach4  
            with (instance_create(x, y, obj_dashcloud))  
            {  
                image_xscale = other.xscale  
                other.dashcloudid = id  
            }  
            state = states.mach3
            return;  
        }  
        else  
        {  
            state = states.jump 
            sprite_index = spr_fall  
        }  
        return;  
    }  
    if (grounded && scr_slope())  
    {  
        with (instance_place(x, (y + 1), obj_slope))  
        {  
            other.xscale = (-sign(image_xscale))  
            other.wrollbuffer = 10  
            other.state = states.crouch
            other.image_index = 0  
            other.sprite_index = other.spr_wm_roll  
            other.movespeed = 12  
            with (instance_create(other.x, other.y, obj_jumpdust))  
                image_xscale = (-sign(other.image_xscale))  
            return;  
        }  
    }  
    if (grounded && wallclimbbuffer == 0 && ispeppino && (!scr_slope()) && vsp > 0 && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (place_meeting(x, (y + 1), obj_solid) || place_meeting(x, (y + 1), obj_platform)))  
    {  
        var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
        var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
        if (gap == 4 || gap == -4 || (dx != -4 && dx != 4))  
        {  
            mask_index = spr_crouchmask  
            state = states.crouch  
            sprite_index = spr_wm_roll  
            image_index = 0  
            fmod_event_instance_play(snd_dive)  
            return;  
        }  
        movespeed = 0  
        hsp = 0  
        wallspeed = 0  
        vsp = 0  
        state = states.normal 
    }  
	if (sprite_index == spr_wm_wallclimb && vsp > 4)  
        sprite_index = spr_wm_wall_losingas  
	if (vsp > -4 && key_down) || (vsp > 18) || (sprite_index == spr_wethamcling_dive) || (sprite_index == spr_wethamcling_dive_start) {
		if (sprite_index != spr_wethamcling_dive_start && sprite_index != spr_wethamcling_dive) {
			if key_down
				fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallclingcancel", x, y)  
			sprite_index = spr_wethamcling_dive_start
			image_index = 0
		}
		if (ANIMATION_END && sprite_index == spr_wethamcling_dive_start)
			sprite_index = spr_wethamcling_dive
	}
	else {
		if place_meeting(x, y - 1, obj_solid) && sprite_index != spr_wm_cling && sprite_index != spr_wetham_runtocling {
			if sprite_index == spr_wetham_wallrun {
				sprite_index = spr_wetham_runtocling
				image_index = 0
			}
			else
				sprite_index = spr_wm_cling 
		}
		if (wallclingpulse > 0 && vsp < -4 && !place_meeting(x, y - 1, obj_solid) && sprite_index != spr_wm_cling && sprite_index != spr_wetham_runtocling)
			sprite_index = spr_wetham_wallrun
		else {
			if (sprite_index == spr_wetham_wallrun) {
				sprite_index = spr_wetham_runtocling
				image_index = 0
			}
			if (ANIMATION_END && sprite_index == spr_wetham_runtocling)
	    		sprite_index = spr_wm_cling  
			if (sprite_index != spr_wm_cling && sprite_index != spr_wetham_runtocling && sprite_index != spr_wetham_wallrun)
				sprite_index = spr_wm_cling  
		}
	}
	if (!fmod_event_instance_is_playing(snd_wethamslide))
		fmod_event_instance_play(snd_wethamslide)
	var s = 0
	if sprite_index != spr_wetham_wallrun
		s = 1
	fmod_event_instance_set_parameter(snd_wethamslide, "state", s, 1)
	// Keeping this in just for nostalgia
	/*
    if (sprite_index != spr_wm_cling && string_copy(sprite_get_name(sprite_index), 1, 11) != "spr_wm_wall")  
    {  
        sprite_index = spr_wm_cling  
        image_index = 0  
    }  
    if (string_copy(sprite_get_name(sprite_index), 1, 11) == "spr_wm_wall")  
    {  
        if key_jump2  
        {  
            movespeed = clingexitspeed  
            scr_wm_bouncejaws(true)  
            jawsup = 1  
            return;  
        }  
        if key_down  
        {  
            movespeed = clingexitspeed  
            scr_wm_bouncejaws(true)  
            jawsup = 0  
            return;  
        }  
    }  
	*/
    if (key_jump && input_buffer_jump_negative <= 0)  
    {  
        state = states.mach2
        xscale *= -1  
        vsp = -14  
        jumpAnim = 1  
        hsp = 10 * xscale  
        movespeed = 10  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        sprite_index = spr_walljumpstart  
        return;  
    }  
    if (key_down && wallclimbbuffer == 0)  
    {  
        if (vsp < 0)  
        {  
            vsp = 0  
            wallclingpulse = 0  
        }  
        if (vsp < 10)  
            vsp += 0.75  
    }  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
	image_speed = 0.35 
}