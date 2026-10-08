if (!instance_exists(obj_backtohub_fadeout) && (!instance_exists(obj_pause) || obj_pause.alarm[5] == -1 || obj_pause.alarm[3] == -1))
{
	with (other)
	{
		if (state == states.handstandjump || state == states.lungeattack || state == states.punch)
		{
			switch (other.content) {
				case "shotgun":
					image_index = 0;
					sprite_index = spr_shotgunpullout;
					fmod_event_one_shot_3d("event:/sfx/pep/shotgunload", x, y);
					shotgunAnim = true;
					state = states.shotgun;
					create_transformation_tip(lang_get_value("shotguntip"), "shotgun");
					global.heattime = 60;
					break;
				case "revolver":
					if (characterID == characters.noise)
						fmod_event_one_shot_3d("event:/sfx/noise/bombbounce", x, y);
					else
						fmod_event_one_shot("event:/sfx/pep/pistolstart");
					sprite_index = spr_pistolintro;
					state = states.animation;
					image_index = 0;
					image_speed = 0.35;
					tauntstoredstate = states.normal;
					global.pistol = true;
					global.heattime = 60;
					break;
			}
			
			other.sprite_index = spr_gunbox_open;
			other.image_index = 0;
		}
	}
}
