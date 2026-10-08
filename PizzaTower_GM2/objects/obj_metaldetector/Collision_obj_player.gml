with (other)
{
	if (shotgunAnim)
	{
		shotgunAnim = false;
		with (instance_create(x, y, obj_sausageman_dead))
		{
			sprite_index = obj_player1.spr_shotgundrop;
			//if (!obj_player1.ispeppino && obj_player1.characterID != characters.noise)
			//{
			//	sprite_index = spr_minigunfall;
			//}
		}
		if (state == states.shotgunshoot)
		{
			state = states.normal;
		}
	}
	if (global.pistol) 
	{
		global.pistol = false;
		if (state == states.animation)
			state = states.normal;
		with (instance_create(x, y, obj_sausageman_dead))
			sprite_index = spr_pistolrevolver;
	}
	if (shotgunAnim || global.pistol) {
		fmod_event_one_shot_3d("event:/sfx/misc/detransfo", x, y);
	}
}
