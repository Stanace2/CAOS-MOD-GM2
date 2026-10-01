with (instance_create(x, y, obj_parryeffect))
{
	image_xscale = other.image_xscale;
	sprite_index = other.spr_dead;
	image_speed = 0.35;
}
fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y);
if (fmod_event_instance_is_playing(sniffsnd))
{
	fmod_event_instance_stop(sniffsnd, true);
}
fmod_event_one_shot_3d(deadsnd, x, y);
var x1 = (x - sprite_xoffset) + (sprite_width / 2);
var y1 = (y - sprite_yoffset) + (sprite_height / 2);
repeat (3)
{
	with (create_debris(x1, y1, spr_slapstar))
	{
		hsp = random_range(-5, 5);
		vsp = random_range(-10, 10);
	}
}
instance_create(x1, y1, obj_bangeffect);
notification_push(notifications.rat_destroyed, [room]);
with (obj_camera)
{
	shake_mag = 3;
	shake_mag_acc = 3 / room_speed;
}
with (obj_player1)
{
	supercharge += 1;
}
GamepadSetVibration(0, 0.8, 0.8, 0.65);
if (platformID != -1) {
	global.combotime = 60;
	if (ds_list_find_index(global.saveroom, platformID.id) == -1) {
		global.combo += 1;
		global.enemykilled += 1;
		var combototal = 10 + floor(global.combo * 0.5);
		global.collect += combototal;
		global.comboscore += combototal;
	}
	with (platformID) {
		if (ds_list_find_index(global.saveroom, id) == -1)
			ds_list_add(global.saveroom, id);
		sprite_index = spr_ratdummyplatform_pop;
		image_index = 0;
		points = false;
		popped = true;
	}
} else {
	global.combotime = 60;
}
destroy_sounds([sniffsnd]);
