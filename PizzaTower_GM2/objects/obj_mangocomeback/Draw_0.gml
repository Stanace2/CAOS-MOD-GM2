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
pal_swap_set(spr_palette_wm, obj_player1.paletteselect, false)
draw_self()
shader_reset()
