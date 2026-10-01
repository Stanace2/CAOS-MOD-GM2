sprite_index = spr_ratdummyplatform_inflate_success;
image_index = 0;
with (instance_create(x,y, obj_ratblock_balloon)) {
	platformID = other.id;
	other.balloonID = id;
}