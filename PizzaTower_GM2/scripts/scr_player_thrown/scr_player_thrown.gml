function scr_player_thrown()
{
	image_speed = 0.35;
	hsp = movespeed * -xscale;
	if (place_meeting(x + sign(hsp), y, obj_solid) && !grounded)
	{
		xscale *= -1;
		movespeed /= 2;
	}
	if (grounded && vsp > -1)
	{
		hsp = 0;
		if (sprite_index == spr_vsdead2)
		{
			fmod_event_one_shot("event:/sfx/misc/bossdefeattonk");
			sprite_index = spr_vsdead3;
			image_index = 0;
		}
	}
	if (grounded && vsp > 0 && sprite_index != spr_vsdead1 && sprite_index != spr_vsdead2 && sprite_index != spr_vsdead3 && sprite_index != spr_vsdead4)
	{
		state = states.normal;
		movespeed = 0;
		sprite_index = spr_idle;
		inv_frames = true;
		alarm[1] = 15;
		hitstunned = 0;
	}
	if (image_index > (image_number - 1))
	{
		switch (sprite_index)
		{
			case spr_vsdead1:
				sprite_index = spr_vsdead2;
				image_index = 0;
				break;
			case spr_vsdead3:
				sprite_index = spr_vsdead4;
				image_index = 0;
				break;
		}
	}
}
