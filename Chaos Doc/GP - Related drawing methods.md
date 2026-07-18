Really OBSCURE MECHANIC
*spr_glowpalette*
==(I have to find a shader to make this a less of a pain in the ass to implement)==
==(As well as a global director for drawing the glow)==

Code References:
## scr_drawcontroller
### draw_player()
Main source:
- [[scr_drawcontroller]]
~~~js
// For dark and door instances, goes after the main drawing function
if ((object_index == obj_player1 || object_index == obj_player2) && (obj_player1.sprite_index == spr_player_walkfront || other.use_dark) && false) 
{  
	shader_set(global.Pal_Shader)  
	pal_swap_set(spr_glowpalette, ps, 0)  
	draw_sprite_ext(_sprite_index, _image_index, x, y, (xscale * scale_xs), (yscale * scale_ys), angle, c_white, image_alpha)  
	shader_reset()  
}
~~~
## obj_pizzaface_thunderdark
### DrawEnd
#states
Draw over the darkness in the final scene
~~~js
// This goes after the main darkness drawing
// Glow for gustavo grabbable
if (instance_exists(obj_gustavograbbable) && obj_gustavograbbable.visible)  
{  
    with (obj_gustavograbbable)  
    {  
        var _stun = 0  
        if ((state == (138 << 0) && thrown == 0 && object_index != obj_peppinoclone) || state == (294 << 0) || (state == (262 << 0) && sprite_index == stunfallspr))  
            _stun = 25  
        if (state == (294 << 0) && object_index == obj_gustavograbbable)  
            _stun = 0  
        var _ys = 1  
        shader_set(global.Pal_Shader)  
        pattern_set(global.Base_Pattern_Color, sprite_index, image_index, (xscale * image_xscale), (yscale * _ys), global.palettetexture)  
        if (obj_player1.paletteselect != 28)  
            pattern_reset()  
        pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
        if (state == (4 << 0))  
        {  
            if enemy_is_superslam(id)  
            {  
                _stun += 18  
                _ys = -1  
            }  
        }  
        draw_sprite_ext(sprite_index, image_index, x, (y + _stun), (xscale * image_xscale), (yscale * _ys), angle, image_blend, image_alpha)  
        if (obj_player1.paletteselect == 28)  
            pattern_reset()  
        shader_reset()  
    }  
}  
// Player glow
if instance_exists(obj_pizzahead_finalecutscene)  
{  
    with (obj_pizzahead_finalecutscene)  
    {  
        if (visible && sprite_index != -4)  
        {  
            shader_set(global.Pal_Shader)  
            pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
            if (obj_player1.paletteselect != 28)  
                pattern_reset()  
            pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha)  
            if (obj_player1.paletteselect == 28)  
                pattern_reset()  
            shader_reset()  
        }  
    }  
}
~~~
## obj_drawcontroller
### DrawGUI
In this GUI method the forest leaves from gnome forest are drawn
~~~js
// Goes at the end of the method
// Player glow
if (glowover && instance_exists(obj_player1) && obj_player1.visible)  
{  
    shader_set(global.Pal_Shader)  
    pattern_set(global.Base_Pattern_Color, obj_player1.sprite_index, obj_player1.image_index, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), global.palettetexture)  
    if (obj_player1.paletteselect != 28)  
        pattern_reset()  
    pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(obj_player1.sprite_index, obj_player1.image_index, (obj_player1.x - camera_get_view_x(view_camera[0])), (obj_player1.y - camera_get_view_y(view_camera[0])), (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), obj_player1.angle, c_white, obj_player1.image_alpha)  
    if (obj_player1.paletteselect == 28)  
        pattern_reset()  
    shader_reset()  
}  
// Brickcomeback glow
if (glowover && instance_exists(obj_brickcomeback) && obj_brickcomeback.visible)  
{  
    shader_set(global.Pal_Shader)  
    pattern_set(global.Base_Pattern_Color, obj_player1.sprite_index, obj_player1.image_index, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), global.palettetexture)  
    if (obj_player1.paletteselect != 28)  
        pattern_reset()  
    pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(obj_brickcomeback.sprite_index, obj_brickcomeback.image_index, (obj_brickcomeback.x - camera_get_view_x(view_camera[0])), (obj_brickcomeback.y - camera_get_view_y(view_camera[0])), 1, 1, 0, c_white, obj_brickcomeback.image_alpha)  
    if (obj_player1.paletteselect == 28)  
        pattern_reset()  
    shader_reset()  
}  
// Brickball glow
if (glowover && instance_exists(obj_brickball) && obj_brickball.visible)  
{  
    shader_set(global.Pal_Shader)  
    pattern_set(global.Base_Pattern_Color, obj_player1.sprite_index, obj_player1.image_index, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), global.palettetexture)  
    if (obj_player1.paletteselect != 28)  
        pattern_reset()  
    pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(obj_brickball.sprite_index, obj_brickball.image_index, (obj_brickball.x - camera_get_view_x(view_camera[0])), (obj_brickball.y - camera_get_view_y(view_camera[0])), 1, 1, 0, c_white, obj_brickball.image_alpha)  
    if (obj_player1.paletteselect == 28)  
        pattern_reset()  
    shader_reset()  
}
~~~
### DrawEnd
This is for general, like floor 5 hub or "Dont make a sound"
~~~js
// It has to go inside this conditional, right at the end
if (kidsparty_lightning || dark_lightning)  
{
	if (instance_exists(obj_player1) && obj_player1.visible)  
    {  
        shader_set(global.Pal_Shader)  
        pattern_set(global.Base_Pattern_Color, obj_player1.sprite_index, obj_player1.image_index, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), global.palettetexture)  
        if (obj_player1.paletteselect != 28)  
            pattern_reset()  
        pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
        draw_sprite_ext(obj_player1.sprite_index, obj_player1.image_index, obj_player1.x, obj_player1.y, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), obj_player1.angle, c_white, obj_player1.image_alpha)  
        if (obj_player1.paletteselect == 28)  
            pattern_reset()  
        shader_reset()  
    }  
    if (room == tower_5 && instance_exists(obj_gusbrickhub))  
    {  
        shader_set(global.Pal_Shader)  
        pattern_set(global.Base_Pattern_Color, obj_gusbrickhub.sprite_index, obj_gusbrickhub.image_index, obj_gusbrickhub.image_xscale, obj_gusbrickhub.image_yscale, global.palettetexture)  
        if (obj_player1.paletteselect != 28)  
            pattern_reset()  
        pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
        draw_sprite_ext(obj_gusbrickhub.sprite_index, obj_gusbrickhub.image_index, obj_gusbrickhub.x, obj_gusbrickhub.y, obj_gusbrickhub.image_xscale, obj_gusbrickhub.image_yscale, 0, c_white, obj_gusbrickhub.image_alpha)  
        if (obj_player1.paletteselect == 28)  
            pattern_reset()  
        shader_reset()  
    }  
    if (room == tower_5 && instance_exists(obj_wethamfollowerexit))  
    {  
        with (obj_wethamfollowerexit)  
        {  
            shader_set(global.Pal_Shader)  
            pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
            if (obj_player1.paletteselect != 28)  
                pattern_reset()  
            pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha)  
            if (obj_player1.paletteselect == 28)  
                pattern_reset()  
            shader_reset()  
        }  
    }
}
~~~
## obj_bossspotlight
Kinde self explanatory
### DrawEnd
~~~js
// At the end of method
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, _sprite_index, _image_index, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), global.palettetexture)  
if (obj_player1.paletteselect != 28)  
    pattern_reset()  
pal_swap_set(spr_glowpalette, obj_player1.paletteselect, 0)  
draw_sprite_ext(_sprite_index, _image_index, obj_player1.x, obj_player1.y, (obj_player1.xscale * obj_player1.scale_xs), (obj_player1.yscale * obj_player1.scale_ys), obj_player1.angle, c_white, obj_player1.image_alpha)  
if (obj_player1.paletteselect == 28)  
    pattern_reset()  
shader_reset()
~~~
## obj_dresseractor
### DrawGUI
Right here the glow is shown, it's only apparent if the palette is not unloked
Related:
- [[Palettes visualizer#DrawGUI]]
~~~js
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, palettetexture)  
pal_swap_set(palettespr, paletteindex, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, blend, alpha)  
pattern_reset()  
// H e r e
// To make it work properly, replace the last parameter with 1
pal_swap_set(spr_glowpalette, paletteindex, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
if (paletteindex == 28)  
    pattern_reset()  
reset_shader_fix()
~~~