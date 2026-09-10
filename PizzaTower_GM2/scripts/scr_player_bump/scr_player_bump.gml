function scr_player_bump()
{
	if (sprite_index != spr_wallsplat)
	{
		movespeed = 0;
		mach2 = 0;
		var _gus = sprite_index == spr_player_ratmountbump || sprite_index == spr_lonegustavo_bump;
		start_running = true;
		alarm[4] = 14;
		if (grounded && vsp > 0)
		{
			hsp = 0;
		}
		var can_end = true;
		if (sprite_index == spr_tumbleend)
		{
			can_end = !place_meeting(x, y, obj_pepgoblin_kickhitbox);
		}
		if (sprite_index == spr_tumbleend && !can_end)
		{
			image_speed = 0;
		}
		else
		{
			image_speed = 0.35;
		}
		if (sprite_index == spr_tumbleend && floor(image_index) >= 3 && !grounded)
		{
			image_index = 3;
		}
		if (sprite_index == spr_rockethitwall && grounded && vsp > 0)
		{
			image_index = image_number - 1;
		}
		if (ANIMATION_END && characterID != characters.wm && sprite_index != spr_player_catched && sprite_index != spr_boxxedpep_air && !_gus)
		{
			if (!skateboarding)
			{
				if (sprite_index != spr_rockethitwall || (grounded && vsp > 0))
				{
					state = states.normal;
				}
			}
			else
			{
				state = states.mach2;
			}
		}
		if (grounded && vsp > 0 && _gus)
		{
			state = states.ratmount;
		}
		if (sprite_index != spr_player_catched && sprite_index != spr_boxxedpep_air && sprite_index != spr_rockethitwall && sprite_index != spr_tumbleend && sprite_index != spr_hitwall && !_gus && sprite_index != spr_mach && sprite_index != spr_mach4)
		{
			sprite_index = !skateboarding ? spr_bump : spr_clownbump;
		}
		//wm crash anims have only 1 frame, the image index animation ender doesnt work properly, they can only stand up when grounded
		if (characterID == characters.wm && grounded && vsp >= 0.5)
        {
            movespeed = 0
            hsp = 0
            vsp = 0
            state = (0 << 0)
            return;
        }
	}
	else
	{
		// Bump overwritter, if pressed shoot key, jumps out in a ball bounce
        var hasM = (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_mangocomeback) && obj_mangocomeback.sprite_index == spr_m_flykicked))  
        if (key_shoot && characterID == characters.wm && hasM)  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                brick = 1  
            }  
            if instance_exists(obj_mangocomeback)  
            {  
                with (obj_mangocomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            scr_wm_bouncejaws(true)  
        }  
		movespeed = 0;
		hsp = 0;
		vsp = 0;
		if (ANIMATION_END)
		{
			state = states.normal;
		}
		image_speed = 0.35;
	}
	if (state == states.normal && isgustavo)
	{
		state = states.ratmount;
	}
}
