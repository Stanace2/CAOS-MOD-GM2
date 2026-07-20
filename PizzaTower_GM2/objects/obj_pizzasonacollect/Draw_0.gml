draw_self();
draw_sprite(spr_chigaco, index, x, y + 46);
if (showtext)
{
	draw_sprite(spr_pizzasona_thankyou, index, x, y - 40);
}
//shader_set(global.Pal_Shader)  
//pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
//pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)  
//pattern_set(global.Base_Pattern_Color_Shared, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
//pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)  
//pattern_reset()  
//shader_reset()
