function scr_dopepperjump_chaos() {
	switch characterID {
		case characters.dos:
			fmod_event_one_shot_3d("event:/sfx/firemouth/jump", x, y);
			if (key_down)
				vsp = 0;
			else
				vsp = -15;
			if (movespeed < 10)
				movespeed = 10;
			if (move != 0)
				xscale = move;
			if grounded {
				with (instance_create(x, y, obj_highjumpcloud2))
					sprite_index = spr_player_firemouthjumpdust;
			}
			repeat (5)
				instance_create(x, y, obj_firemouthflame);
			if state != states.jetpackjump
				state = states.jetpackjump;
			jumpstop = false;
			sprite_index = spr_pepperjump;
			image_index = 0;
			break
	}
}