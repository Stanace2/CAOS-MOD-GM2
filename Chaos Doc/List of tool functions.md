Some useful functions to support game systems, debugging or process some numbers.
***
## scr_chaos_utils
### draw_sprite_line()
Can draw a sprite followed by the same next to each other in a line defined by 2 sets of coordinates, it can draw them normaly, or in an alpha gradient
~~~js
function draw_sprite_line(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) //gml_Script_draw_sprite_line
{
    if (argument6 == undefined)
        argument6 = 0
    if (argument7 == undefined)
        argument7 = 1
    if (argument8 == undefined)
        argument8 = -1
    var _xoffset = sprite_get_xoffset(argument0)
    var _yoffset = sprite_get_yoffset(argument0)
    var _angle = point_direction(argument2, argument3, argument4, argument5)
    var _spriteWidth = sprite_get_width(argument0)
    var _spriteHeight = sprite_get_height(argument0)
    var _d = point_distance(argument2, argument3, argument4, argument5)
    var _count = 1
    var _total = floor(_d / _spriteWidth)
    for (var _i = 0; _i < _d; _i += _spriteWidth)
    {
        var alpha = argument7
        if (argument6 && (_total < argument8 || argument8 == -1))
            alpha = argument7 * (1 - _count / (_total - 1))
        else
            alpha = argument7 * (1 - _count / (_total * (argument8 / _total) - 1))
        var _x = argument2 + _i / _d * (argument4 - argument2)
        var _y = argument3 + _i / _d * (argument5 - argument3)
        if ((_i + _spriteWidth) <= _d)
        {
            _count += 1
            draw_sprite_ext(argument0, argument1, _x, _y, 1, 1, _angle, draw_get_color(), alpha)
        }
        else
            draw_sprite_general(argument0, argument1, 0, 0, (_d - _i), _spriteHeight, (_x - (lengthdir_x(_xoffset, _angle)) + (lengthdir_x(_yoffset, (_angle + 90)))), (_y - (lengthdir_y(_xoffset, _angle)) + (lengthdir_y(_yoffset, (_angle + 90)))), 1, 1, _angle, draw_get_color(), draw_get_color(), draw_get_color(), draw_get_color(), alpha)
    }
}
~~~
[^1]: argument0 : *sprite_index* | sprite
[^2]: argument1 : *image_index* | num
[^3]: argument2 : *origin x* | num
[^4]: argument3 : *origin y* | num
[^5]: argument4 : *end x* | num
[^6]: argument5 : *end y* | num
[^7]: argument6 : *allow alpha gradient* | boolean
[^8]: argument7 : *initial alpha* | num 0-1
[^9]: argument8 : *max range for gradient* | num

**This is used in:
	drawGUI | obj_dragonsnap_effect
	draw | obj_mango_brickball_indicator**
### clean_dragonexit()
Used to clean the exit position of the player after doing a dragon snap
~~~js
function clean_dragonexit()
{
    while place_meeting(x, y, obj_destructibles)
    {
        with (place_meeting(x, y, obj_destructibles))
            instance_destroy()
    }
    while place_meeting(x, y, obj_metalblock)
    {
        with (place_meeting(x, y, obj_metalblock))
            instance_destroy()
    }
    while place_meeting(x, y, obj_asteroid)
    {
        with (place_meeting(x, y, obj_asteroid))
            instance_destroy()
    }
    while place_meeting(x, (y + 2), obj_slope)
        y--
}
~~~

**This is executed in:
	step | obj_dragonsnap_effect**
### scr_corrupt_door()
Spawns the caoschaser if caos challenge is activated
~~~js
function scr_corrupt_door()
{
    if (image_index == 0 && string_copy(room_get_name(room), 1, 5) != "tower" && global.caoschase && (!instance_exists(obj_chaoschaser)))
    {
        obj_player1.supercharged = 1
        instance_create(x, y, obj_chaoschaser)
    }
}
~~~

**This is executed in:
	Collision_obj_player | [[obj_exitgate#Collision_obj_player]]**
### scr_get_cameraborder()
==(Unused, i dont remeber what this does)==
~~~js
function scr_get_cameraborder(argument0, argument1, argument2)
{
    var cam = view_camera[0]
    var view_x = camera_get_view_x(cam)
    var view_y = camera_get_view_y(cam)
    var view_w = camera_get_view_width(cam)
    var view_h = camera_get_view_height(cam)
    var left = view_x
    var right = view_x + view_w
    var top = view_y
    var bottom = view_y + view_h
    switch argument2
    {
        case 0:
            return abs(argument0 - left); //
        case 1:
            return abs(right - argument0); //
        case 2:
            return abs(argument1 - top); //
        case 3:
            return abs(bottom - argument1); //
    }

}
~~~
[^1]: argument0 :
[^2]: argument1 :
[^3]: argument2 :

**This is used in: 
	Uh...**
### scr_displaykeys()
Debug feature - Displays on screeb the main moveset keys and shows if their are bing pressed
~~~js
function scr_displaykeys(argument0, argument1)
{
    if (!argument1)
        return;
    var xr = obj_screensizer.actual_width / 2
    var yr = obj_screensizer.actual_height - 100
    draw_sprite_ext(spr_controlicons, 0, (xr - 50), (yr - 20), 1, 1, 0, scr_dkeycolor(key_up, argument0), scr_dkeyalpha(key_up))
    draw_sprite_ext(spr_controlicons, 1, (xr - 50), (yr + 25), 1, 1, 0, scr_dkeycolor(key_down, argument0), scr_dkeyalpha(key_down))
    draw_sprite_ext(spr_controlicons, 2, (xr - 21), yr, 1, 1, 0, scr_dkeycolor(key_right, argument0), scr_dkeyalpha(key_right))
    draw_sprite_ext(spr_controlicons, 3, (xr - 75), yr, 1, 1, 0, scr_dkeycolor((-key_left), argument0), scr_dkeyalpha((-key_left)))
    draw_sprite_ext(spr_controlicons, 4, (xr + 15), yr, 1, 1, 0, scr_dkeycolor(key_jump2, argument0), scr_dkeyalpha(key_jump2))
    draw_sprite_ext(spr_controlicons, 5, (xr + 50), (yr - 10), 1, 1, 0, scr_dkeycolor(key_slap, argument0), scr_dkeyalpha(key_slap))
    draw_sprite_ext(spr_controlicons, 6, (xr - 145), yr, 1, 1, 0, scr_dkeycolor(key_attack, argument0), scr_dkeyalpha(key_attack))
    draw_sprite_ext(spr_controlicons, 7, (xr + 95), yr, 1, 1, 0, scr_dkeycolor(key_taunt, argument0), scr_dkeyalpha(key_taunt))
    draw_sprite_ext(spr_controlicons, 8, (xr + 50), (yr - 45), 1, 1, 0, scr_dkeycolor(key_shoot, argument0), scr_dkeyalpha(key_shoot))
}
~~~
[^1]: argument0 : *pressed key color* | color value
[^2]: argument1 : *toogle* | boolean

Within functions:
==Note to self: I think this can be simplified with the "x ? y : z" format==
~~~js
function scr_dkeyalpha(argument0)
{
    if argument0
        return 1; //solid color when true
    else
        return 0.5; //half alpha when false
} 

function scr_dkeycolor(argument0, argument1)
{
    if argument0
        return argument1; //choosed color in scr_displaykey() when true
    else
        return 16777215; //white color when false
}
~~~

**This is executed in:
	[[Player create shenanigans#obj_player DrawGUI]]**
### scr_displaydata()
Debug feature - Displays information about the player
~~~js
function scr_displaydata(argument0)
{
    if (!argument0)
        return;
    draw_set_font(lang_get_font("creditsfont"))
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    draw_text(10, 80, concat("hsp: ", hsp))
    draw_text(10, 100, concat("vsp: ", vsp))
    draw_text(10, 120, concat("movespeed: ", movespeed))
    draw_text(10, 140, concat("state: ", state))
    draw_text(10, 160, concat("xscale: ", xscale))
    draw_text(10, 180, concat("move: ", (key_left + key_right)))
    draw_text(10, 200, concat("in_buffer_s: ", input_buffer_chaos))
    draw_text(10, 220, concat("in_buffer_j: ", input_buffer_jump))
    draw_text(10, 240, concat("room: ", room_get_name(room)))
    draw_text(10, 260, concat("sprite: ", sprite_get_name(sprite_index)))
    draw_text(10, 280, concat("brick: ", brick))
    draw_text(10, 300, concat("imagespeed: ", image_speed))
    draw_text(10, 320, concat("clingexitspeed: ", clingexitspeed))
}
~~~
[^1]: argument0 : *toggle* | boolean

**This is executed in:
	[[Player create shenanigans#obj_player DrawGUI]]**
### scr_colormap()
Compacts the intial values for shd_colormap
~~~js
function scr_colormap(argument0, argument1, argument2, argument3, argument4, argument5, argument6) //gml_Script_scr_colormap
{
    shader_set(argument0)
    shader_set_uniform_f(shader_get_uniform(argument0, "tailR"), argument1)
    shader_set_uniform_f(shader_get_uniform(argument0, "tailG"), argument2)
    shader_set_uniform_f(shader_get_uniform(argument0, "tailB"), argument3)
    shader_set_uniform_f(shader_get_uniform(argument0, "noseR"), argument4)
    shader_set_uniform_f(shader_get_uniform(argument0, "noseG"), argument5)
    shader_set_uniform_f(shader_get_uniform(argument0, "noseB"), argument6)
}
~~~
[^1]: argument 0 : *shader* | shader value
[^2]: argument 1 : *origin red value* | num 0-255
[^3]: argument 2 : *origin green value* | num 0-255
[^4]: argument 3 : *origin blue value* | num 0-255
[^5]: argument 4 : *end red value* | num 0-255
[^6]: argument 5 : *end green value* | num 0-255
[^7]: argument 6 : *end blue value* | num 0-255

**This is used in:
	endStep | obj_afterimage**
### scr_outline_sprite()
Draws a 1 pixel outline around a given sprite
~~~js
function scr_outline_sprite(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10)
{
    shader_set(shd_color_afterimage)
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), (argument8 / 255))
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), (argument9 / 255))
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), (argument10 / 255))
    for (var i = 0; i < 4; i++)
    {
        var xoffset = 0
        var yoffset = 0
        switch i
        {
            case 0:
                xoffset = 1
                break
            case 1:
                xoffset = -1
                break
            case 2:
                yoffset = 1
                break
            case 3:
                yoffset = -1
                break
        }
		
        draw_sprite_ext(argument0, argument1, (argument2 + xoffset), (argument3 + yoffset), argument4, argument5, argument6, c_white, argument7)
    }
    reset_shader_fix()
}
~~~
[^1]: argument0 : *sprite_index* | sprite
[^2]: argument1 : *image_index* | num
[^3]: argument2 : *sprite x position* | num
[^4]: argument3 : *sprite y position* | num
[^5]: argument4 : *sprite x scale* | num
[^6]: argument5 : *sprite y scale* | num
[^7]: argument6 : *angle* | num
[^8]: argument7 : *alpha* | num 0-1
[^9]: argument8 : *shader red value* | num 0-255
[^10]: argument9 : *shader green value* | num 0-255
[^11]: argument10 : *shader blue value* | num 0-255

**This is used in:
	[[scr_drawcontroller#draw_player()]]**
### mango_ledge_bump()
Lets obj_mango_brickball do a ledge hicup
~~~js
function mango_ledge_bump(argument0, argument1)
{
    if (argument1 == undefined)
        argument1 = 4
    var old_x = x
    var old_y = y
    x += (image_xscale * argument1)
    var ty = try_solid(0, -1, 574, argument0)
    x = old_x
    if (ty != -1)
    {
        y -= ty
        x += image_xscale
        if scr_solid(x, y)
        {
            x = old_x
            y = old_y
            return true;
        }
        return false;
    }
    return true;
}
~~~
[^1]: argument0 : *margin to allow ledge hicup* | num
[^2]: argument1 : *amount to check in front before collision* | num

**Used in:
	step | obj_mango_brickball**

