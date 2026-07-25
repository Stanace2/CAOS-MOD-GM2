if (active)
{
	with (obj_player)
	{
		state = states.actor;
		hsp = 0;
		vsp = 0;
		visible = false;
	}
}
if (ANIMATION_END)
{
	switch (sprite_index)
	{
		case spr_pizzaportal_appear:
			fmod_event_one_shot_3d("event:/sfx/misc/secretexit", x, y);
			sprite_index = obj_player.spr_lapportal_out;
			if (!obj_player1.ispeppino)
			{
				sprite_index = spr_pizzaportalentrancestartN;
			}
			break;
		case obj_player.spr_lapportal_out:
		case spr_pizzaportalentrancestartN:
			sprite_index = spr_pizzaportal_disappear;
			with (obj_player)
			{
				state = states.normal;
				visible = true;
			}
			active = false;
			break;
		case spr_pizzaportal_disappear:
			instance_create_unique(0, 0, obj_lap2visual);
			instance_destroy();
			break;
	}
}
