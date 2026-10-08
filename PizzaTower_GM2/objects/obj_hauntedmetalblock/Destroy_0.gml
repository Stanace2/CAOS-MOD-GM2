
repeat (8)
{
	with (create_debris(x + random_range(0, 64), y + random_range(0, 64), spr_haunted_metalblockdebris, false))
	{
		hsp = random_range(-5, 5);
		vsp = random_range(-10, 10);
		image_speed = 0;
		image_index = random_range(0, image_number - 1);
	}
}
scr_sleep(5);
instance_create(x + 32, y + 32, obj_bangeffect);
tile_layer_delete_at(1, x, y);
tile_layer_delete_at(1, x + 32, y);
tile_layer_delete_at(1, x + 32, y + 32);
tile_layer_delete_at(1, x, y + 32);
with (obj_camera)
{
	shake_mag = 20;
	shake_mag_acc = 40 / room_speed;
}
GamepadSetVibration(playerindex, 1, 1, 0.8);
fmod_event_one_shot("event:/sfx/misc/breakmetal");
depth = 1;
with (instance_create(x,y, obj_hauntedblocklayout)) {
	sprite_index = spr_blockghost;
	tospawn = other.object_index;
	spawn_anim = other.spawn_anim;
}