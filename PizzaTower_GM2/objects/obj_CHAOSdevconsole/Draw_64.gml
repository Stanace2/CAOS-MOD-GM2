var _offset = 0;
var death = true;
if (tick_records || display) {
	draw_set_font(global.caosfont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	if (!ds_list_empty(records)) {
		for (var i = ds_list_size(records) - 1; i >= 0; i--) {
			var r = ds_list_find_value(records, i)
			if r[1] == "error"
				draw_set_color(c_red);
			else
				draw_set_color(c_white);
			if r[2] < 50 && r[2] != 0 && !display {
				draw_set_alpha(r[2] / 50);
				death = false;
			}
			else if r[2] == 0 
				draw_set_alpha(display)
			else {
				draw_set_alpha(1);
				death = false;
			}
			draw_text(8, SCREEN_HEIGHT - 60 - _offset, r[0]);
			var dying = r[2] - 1
			if (dying < 0)
				dying = 0
			ds_list_set(records, i, [r[0],r[1], dying])
			_offset += 20;
		}
	}
}
if death
	tick_records = false;
if !display
	return;
draw_rectangle_color(0, SCREEN_HEIGHT - 25, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
if (searching && string_starts_with(search_sugges, command) && haslist && search_list != undefined && search_sugges != "" && search_sugges != undefined) {
	draw_set_color(c_white);
	draw_set_font(global.caosfont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_alpha(0.5);
	draw_text(8 + rootpos, SCREEN_HEIGHT - 4, search_sugges);
}
draw_set_color(c_white);
draw_set_font(global.caosfont);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_alpha(0.9);
draw_text(8, SCREEN_HEIGHT - 4, command);
if !cursor_blink {
	if !cursor_pos_async
		draw_text(8 + ((cursor_pos - 1) * sprite_get_width(spr_caosfont)), SCREEN_HEIGHT - 4, "_");
	else
		draw_text(4 + ((cursor_pos - 1) * sprite_get_width(spr_caosfont)), SCREEN_HEIGHT - 4, "|");
}
var _offset = 0;
var _boxsize = 26;
var _color = c_white;
var _alpha = 0.5;
var _listsize = 5;
if !haslist && param_tip != "" && rootpos > 0 {
	draw_rectangle_color(10 + rootpos, SCREEN_HEIGHT - 27 - _boxsize - _offset, 14 + rootpos + string_length(param_tip) * sprite_get_width(spr_caosfont), SCREEN_HEIGHT - 27 - _offset, c_black, c_black, c_black, c_black, false);
	draw_set_font(global.caosfont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_text_ext_colour(12 + rootpos, SCREEN_HEIGHT - 27 - _boxsize - (_offset + 2), param_tip,0,SCREEN_WIDTH,_color,_color,_color,_color,0.35);
}
if !searching || search_list == undefined || !haslist
	return;
if (search_cursor > search_index + _listsize - 1 && search_cursor > search_cursor_prev)
	search_index = search_cursor - _listsize + 1;
if (search_cursor < search_index)
	search_index = search_cursor;
var _boxlength = 0;
for (var i = 0; i < ds_list_size(search_list); i++)
	_boxlength = max(_boxlength, string_length(ds_list_find_value(search_list, i)));
for (var i = search_index; i < ds_list_size(search_list); i++) {
	if (ds_list_find_value(search_list, i) == undefined)
		break;
	if (i > search_index + _listsize - 1)
		break;
	draw_rectangle_color(10 + rootpos, SCREEN_HEIGHT - 27 - _boxsize - _offset, 14 + rootpos + _boxlength * sprite_get_width(spr_caosfont), SCREEN_HEIGHT - 27 - _offset, c_black, c_black, c_black, c_black, false);
	draw_set_font(global.caosfont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	if (i == search_cursor) {
		_color = c_yellow;
		_alpha = 1;
	}
	else {
		_color = c_white;
		_alpha = 0.5;
	}
	draw_text_ext_colour(12 + rootpos, SCREEN_HEIGHT - 27 - _boxsize - (_offset + 2), ds_list_find_value(search_list, i),0,SCREEN_WIDTH,_color,_color,_color,_color,_alpha);
	_offset += _boxsize;
}
