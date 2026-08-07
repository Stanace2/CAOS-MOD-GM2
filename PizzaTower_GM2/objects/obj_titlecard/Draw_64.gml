if (start)
{
	if obj_player1.characterID == characters.dos {
		shader_set(global.Pal_Shader)
		pattern_set(global.Base_Pattern_Color, titlecard_sprite, titlecard_index, 1, 1, global.palettetexture)
		pal_swap_set(spr_dos_titlecardpalette, obj_player1.paletteselect, 0)
	}
	draw_sprite(titlecard_sprite, titlecard_index, 0, 0);
	if obj_player1.characterID == characters.dos {
		pattern_reset()
		shader_reset()
	}
	var s = 1;
	lang_draw_sprite(title_sprite, title_index, 32 + irandom_range(-s, s), irandom_range(-s, s));
	for (var i = 0; i < array_length(noisehead); i++)
	{
		var head = noisehead[i];
		if (!head.visible)
		{
			continue;
		}
		head.visual_scale = Approach(head.visual_scale, 1, 0.25);
		draw_sprite_ext(spr_titlecard_noise, head.image_index, head.x, head.y, head.scale * head.visual_scale, head.scale * head.visual_scale, 0, c_white, 1);
	}
}
if (!instance_exists(obj_fadeout))
{
	draw_set_alpha(fadealpha);
}
else
{
	draw_set_alpha(obj_fadeout.fadealpha);
}
draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
