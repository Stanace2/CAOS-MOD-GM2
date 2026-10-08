if (tospawn == noone)
	instance_destroy();
image_speed = Approach(image_speed, 1.5, 0.005);
if (image_speed >= 1.5 && place_empty(x, y)) {
	with (instance_create(x, y, tospawn)) {
		sprite_index = spawn_anim;
		image_index = 0;
	}
	instance_destroy();
} 
