shader_set(global.Pal_Shader)  
/*
if scr_checkMT(obj_player1.paletteselect)  
{  
    var mangoPattern = scr_searchMT(obj_player1.paletteselect)  
    pattern_set([9, 10], sprite_index, image_index, image_xscale, image_yscale, mangoPattern)  
    pal_swap_set(spr_ratmountpalette, obj_player1.paletteselect, 0)  
    draw_self()  
}  
*/
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_palette_wm, obj_player1.paletteselect, 0)  
draw_self()  
if flash  
{  
    shader_set(shd_color_afterimage)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 1)  
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 1)  
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
}  
shader_reset()