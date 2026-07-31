/// @description Insert description here
// You can write your code in this editor
scr_colormap(shd_gm_afterimage, 0, 0, 0, colour_get_red(image_blend), colour_get_green(image_blend), colour_get_blue(image_blend))
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
shader_reset();


