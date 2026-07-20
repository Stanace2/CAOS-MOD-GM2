draw_set_color(c_white);
for (var i = 0; i < ds_list_size(collectiblelist); i++)
{
	var b = ds_list_find_value(collectiblelist, i);
	
	//shader_set(global.Pal_Shader)  
    //pattern_set(global.Base_Pattern_Color, b.sprite_index, b.image_index, 1, 1, global.palettetexture)  
    //pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
	
	draw_sprite_ext(b.sprite_index, b.image_index, b.x, b.y, 1, 1, 0, c_white, b.image_alpha);
	
	//pattern_set(global.Base_Pattern_Color_Shared, b.sprite_index, b.image_index, 1, 1, global.palettetexture)  
    //pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
    //draw_sprite_ext(b.sprite_index, b.image_index, b.x, b.y, 1, 1, 0, c_white, 0.25)  
    //pattern_reset()  
    //shader_reset()  
	
	if (b.pizzasona)
	{
		draw_sprite_ext(spr_chigaco, b.image_index, b.x, b.y + 49, 1, 1, 0, c_white, b.image_alpha);
	}
}
