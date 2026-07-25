if (noisex != 545)
{
	image_blend = c_black;
}
else
{
	image_blend = c_white;
}
draw_sprite_tiled(spr_versusflame, -1, 0, flamey);
if (pepx != 0)
{
	draw_sprite(obj_player.spr_vsportrait_shadow, 0, pepx, room_height - 357);
	draw_sprite(spr_vsnoiseshadow, 0, noisex, room_height - 357);
}
else
{
	draw_sprite(obj_player.spr_vsportrait, 0, pepx, room_height - 357);
	draw_sprite(spr_vsnoise, 0, noisex, room_height - 357);
}
draw_sprite(spr_vstitle, 0, shake, vsy + shake);
if (flash)
{
	shader_set(shd_hit);
	draw_sprite(obj_player.spr_vsportrait, 0, pepx, room_height - 357);
	draw_sprite(spr_vsnoise, 0, noisex, room_height - 357);
	draw_sprite(spr_vstitle, 0, shake, vsy + shake);
	shader_reset();
}
else
{
}
