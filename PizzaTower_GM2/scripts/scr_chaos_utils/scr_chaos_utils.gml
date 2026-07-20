function draw_sprite_line(_sprindex, _imgindex, sx, sy, ex, ey, gallow, ini_alpha, gmaxrange){
	if (gallow == undefined)
        gallow = false;
    if (ini_alpha == undefined)
        ini_alpha = 1;
    if (gmaxrange == undefined)
        gmaxrange = -1;
    var _xoffset = sprite_get_xoffset(_sprindex)
    var _yoffset = sprite_get_yoffset(_sprindex)
    var _angle = point_direction(sx, sy, ex, ey)
    var _spriteWidth = sprite_get_width(_sprindex)
    var _spriteHeight = sprite_get_height(_sprindex)
    var _d = point_distance(sx, sy, ex, ey)
    var _count = 1
    var _total = floor(_d / _spriteWidth)
    for (var _i = 0; _i < _d; _i += _spriteWidth)
    {
        var alpha = ini_alpha
        if (gallow && (_total < gmaxrange || gmaxrange == -1))
            alpha = ini_alpha * (1 - _count / (_total - 1))
        else
            alpha = ini_alpha * (1 - _count / (_total * (gmaxrange / _total) - 1))
        var _x = sx + _i / _d * (ex - sx)
        var _y = sy + _i / _d * (ey - sy)
        if ((_i + _spriteWidth) <= _d)
        {
            _count += 1
            draw_sprite_ext(_sprindex, _imgindex, _x, _y, 1, 1, _angle, draw_get_color(), alpha)
        }
        else
            draw_sprite_general(_sprindex, _imgindex, 0, 0, (_d - _i), _spriteHeight, (_x - (lengthdir_x(_xoffset, _angle)) + (lengthdir_x(_yoffset, (_angle + 90)))), (_y - (lengthdir_y(_xoffset, _angle)) + (lengthdir_y(_yoffset, (_angle + 90)))), 1, 1, _angle, draw_get_color(), draw_get_color(), draw_get_color(), draw_get_color(), alpha)
    }
}

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

/*
function scr_corrupt_door()
{
    if (image_index == 0 && string_copy(room_get_name(room), 1, 5) != "tower" && global.caoschase && (!instance_exists(obj_chaoschaser)))
    {
        obj_player1.supercharged = 1
        instance_create(x, y, obj_chaoschaser)
    }
}
*/

function scr_displaykeys(_color, _display)
{
    if (!_display)
        return;
    var xr = obj_screensizer.actual_width / 2
    var yr = obj_screensizer.actual_height - 100
    draw_sprite_ext(spr_controlicons, 0, (xr - 50), (yr - 20), 1, 1, 0, key_up ? _color : c_white, key_up ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 1, (xr - 50), (yr + 25), 1, 1, 0, key_down ? _color : c_white, key_down ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 2, (xr - 21), yr, 1, 1, 0, key_right ? _color : c_white, key_right ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 3, (xr - 75), yr, 1, 1, 0, -key_left ? _color : c_white, -key_left ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 4, (xr + 15), yr, 1, 1, 0, key_jump2 ? _color : c_white, key_jump2 ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 5, (xr + 50), (yr - 10), 1, 1, 0, key_slap ? _color : c_white, key_slap ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 6, (xr - 145), yr, 1, 1, 0, key_attack ? _color : c_white, key_attack ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 7, (xr + 95), yr, 1, 1, 0, key_taunt ? _color : c_white, key_taunt ? 1 : 0.5)
    draw_sprite_ext(spr_controlicons, 8, (xr + 50), (yr - 45), 1, 1, 0, key_shoot ? _color : c_white, key_shoot ? 1 : 0.5)
}

function scr_displaydata(_display)
{
    if (!_display)
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
    //draw_text(10, 320, concat("clingexitspeed: ", clingexitspeed))
}

/*
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
*/

function scr_outline_sprite(_sprindex, _imgindex, _x, _y, _xscale, _yscale, _angle, _alpha, _R, _G, _B)
{
    shader_set(shd_color_afterimage)
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), (_R / 255))
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), (_G / 255))
    shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), (_B / 255))
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
		
        draw_sprite_ext(_sprindex, _imgindex, (_x + xoffset), (_y + yoffset), _xscale, _yscale, _angle, c_white, _alpha)
    }
    reset_shader_fix()
}

function mango_ledge_bump(hicup, amount)
{
    if (amount == undefined)
        amount = 4
    var old_x = x
    var old_y = y
    x += (image_xscale * amount)
    var ty = try_solid(0, -1, 574, hicup)
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