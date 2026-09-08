if (sprite_index != spr_mortspawn && !instance_exists(obj_backtohub_fadeout) && (!instance_exists(obj_pause) || obj_pause.alarm[5] == -1 || obj_pause.alarm[3] == -1))
{
	with (other)
	{
		if (state != states.mort && state != states.mortjump && state != states.mortattack && state != states.morthook && state != states.ridecow)
		{
			global.friendShip += 1
			with (obj_player1) {
				if (global.panic || global.friendShip >= 4) && characterID == characters.dos
		        {
		            spr_playermortidle = spr_dos_mortidleD
		            spr_playermortwalk = spr_dos_mortwalkD
		            spr_playermortjump = spr_dos_mortjumpD
		            spr_playermortjumpstart = spr_dos_mortjumpstartD
		            spr_mortdoublejumpstart = spr_dos_mortdoublejumpD
		            spr_playermortland = spr_dos_mortlandD
		            spr_mortdoublejump = spr_dos_mortjumpD
		            spr_mortattackfront = spr_dos_mortattackfrontD
		        }
			}
			repeat (6)
			{
				create_debris(x, y, spr_feather);
			}
			mort = true;
			movespeed = hsp;
			state = states.mort;
			fmod_event_one_shot_3d("event:/sfx/mort/mortpickup", x, y);
			create_transformation_tip(lang_get_value("morttip"), "morttip");
			instance_destroy(other);
		}
	}
}
