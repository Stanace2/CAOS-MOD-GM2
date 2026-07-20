shader_set(global.Pal_Shader)
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, palettetexture)
pal_swap_set(palettespr, paletteindex, 0)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, blend, alpha)
pattern_reset()
/*
pal_swap_set(spr_glowpalette, paletteindex, 0)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)
if (paletteindex == 28)
    pattern_reset()
*/
reset_shader_fix()