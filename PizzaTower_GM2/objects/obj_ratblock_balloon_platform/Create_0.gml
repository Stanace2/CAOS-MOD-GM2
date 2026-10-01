sprite_index = spr_ratdummyplatform_off;
image_speed = 0.35;
depth = 1;
popped = true;
balloonID = -1;
alarm[0] = 1;
if (ds_list_find_index(global.saveroom, id) == -1)
	points = true;
else
	points = false;