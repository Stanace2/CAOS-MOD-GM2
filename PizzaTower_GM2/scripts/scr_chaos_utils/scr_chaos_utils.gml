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
    draw_set_font(lang_get_font("smallfont"))
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
	var _arr = [
		concat("debug markers: ", debugmarkers[0], " + ", debugmarkers[1], " + ", debugmarkers[2], " + ", debugmarkers[3]),
		concat("hsp: ", hsp),
		concat("vsp: ", vsp),
		concat("movespeed: ", movespeed),
		concat("state: ", state),
		concat("xscale: ", xscale),
		concat("move: ", (key_left + key_right)),
		concat("in_buffer_s: ", input_buffer_chaos),
		concat("in_buffer_j: ", input_buffer_jump),
		concat("room: ", room_get_name(room)),
		concat("sprite: ", sprite_get_name(sprite_index)),
		concat("brick: ", brick),
		concat("clingexit: ", clingexitspeed),
		concat("imagespeed: ", image_speed),
		concat("imageindex: ", image_index)
	]
	var _padding = 8;
	var _offset = 0;
	for (var i = 0; i < array_length(_arr); i++) {
		var tw = string_width(_arr[i])
		var th = string_height(_arr[i])
		draw_sprite_ext(spr_fontbg,0,
			0,
			_offset + sprite_get_yoffset(spr_smallerfont), 
			string_length(_arr[i]) * sprite_get_width(spr_smallerfont), 
			sprite_get_height(spr_smallerfont) - sprite_get_yoffset(spr_smallerfont),
			0,c_black,0.6)
		draw_text(10, _offset, string_upper(_arr[i]))
		_offset += 20
	}
    //concat("clingexitspeed: ", clingexitspeed)
}

function scr_colormap(_shader, _tr, _tg, _tb, _nr, _ng, _nb)
{
    shader_set(_shader)
    shader_set_uniform_f(shader_get_uniform(_shader, "tailR"), _tr)
    shader_set_uniform_f(shader_get_uniform(_shader, "tailG"), _tg)
    shader_set_uniform_f(shader_get_uniform(_shader, "tailB"), _tb)
    shader_set_uniform_f(shader_get_uniform(_shader, "noseR"), _nr)
    shader_set_uniform_f(shader_get_uniform(_shader, "noseG"), _ng)
    shader_set_uniform_f(shader_get_uniform(_shader, "noseB"), _nb)
}

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
    var ty = try_solid(0, -1, obj_solid, hicup)
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

function palette_pepfilter(name = "") 
{
	if name != "" {
		if (name == "classic" ||
		name == "unfunny" ||
		name == "money" ||
		name == "sage" ||
		name == "blood" ||
		name == "tv" ||
		name == "dark" ||
		name == "shitty" ||
		name == "golden" ||
		name == "garish" ||
		name == "mooney" ||
		name == "funny" ||
		name == "itchy" ||
		name == "pizza" ||
		name == "stripes" ||
		name == "goldemanne" ||
		name == "bones" ||
		name == "pp" ||
		name == "war" ||
		name == "john") 
		{
			return true;
		}
		return false;
	}
	return false;
}