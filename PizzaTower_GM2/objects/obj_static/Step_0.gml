static_index += (image_speed * static_dir);
if (static_dir == 1 && floor(static_index) == (sprite_get_number(sprite) - 1))
{
	static_index = (sprite_get_number(sprite) - 1);
	if (alarm[0] <= 0)
		alarm[0] = 10;
}
if (static_dir == -1 && floor(static_index) <= 0) {
	instance_destroy()
}