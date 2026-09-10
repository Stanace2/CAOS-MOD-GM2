if (true)
	exit;
draw_set_color(c_white);
draw_set_font(global.caosfont);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_alpha(0.85);
draw_text(8, 20, search_sugges);
draw_text(8, 40, string_starts_with(search_sugges, command));
if ds_list_find_value(search_list, 0) != undefined
	draw_text(8, 60, ds_list_find_value(search_list, 0));
else
	draw_text(8, 60, "No list");
draw_text(8, 80, search_cursor = 0);
