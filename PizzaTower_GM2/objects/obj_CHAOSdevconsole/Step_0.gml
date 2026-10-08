if !display
	return;
if (keyboard_check(vk_anykey) && !keyboard_check(vk_tab) && !keyboard_check(vk_backspace) && !keyboard_check(vk_up) && !keyboard_check(vk_down) && !keyboard_check(vk_left) && !keyboard_check(vk_right) && !keyboard_check(vk_f5))
{
	if !cursor_pos_async {
		command += keyboard_string;
		cursor_pos = string_length(command) + 1;
	} else {
		var _before = ""
		var _current = ""
		var _after = ""
		for (var i = 1; i <= string_length(command); i++) {
			if i == cursor_pos {
				_current += keyboard_string
			}
			if (_current == "")
				_before += string_char_at(command, i)
			else
				_after += string_char_at(command, i)
		}
		command = concat(_before,_current,_after)
	}
	if (cursor_pos_async && keyboard_string != "")
		cursor_pos += 1
	if (keyboard_string != "" && haslist) {
		cycling_bank = false;
		searching = true;
		if (search_sugges == "" && ds_list_size(search_list) > 0) {
			search_sugges = ds_list_find_value(search_list, 0);
			search_cursor = 0;
		} else
			search_sugges = "";
	}
	keyboard_string = "";
}
if (keyboard_check(vk_backspace))
{
	if !cursor_pos_async {
		command = string_delete(command, string_length(command), 1);
		cursor_pos = string_length(command) + 1;
	}
	else if cursor_pos != 1 {
		command = string_delete(command, cursor_pos - 1, 1);
		if cursor_pos > 1
			cursor_pos -= 1
	}
	if (haslist) {
		cycling_bank = false;
		searching = true;
		if (ds_list_size(search_list) > 0) {
			search_sugges = ds_list_find_value(search_list, 0);
			search_cursor = 0;
		} else
			search_sugges = "";
	}
	keyboard_key_release(vk_backspace);
}
cursor = string_length(command)
if string_length(command) > 0 {
	if (keyboard_check(vk_left) && cursor_pos > 1) {
		cursor_blink = false;
		cycling_bank = false;
		alarm[0] = 20;
		cursor_pos -= 1;
		cursor_pos_async = true;
		keyboard_key_release(vk_left);
	}
	if (keyboard_check(vk_right) && (cursor_pos < string_length(command) + 1)) {
		cursor_blink = false;
		cycling_bank = false;
		alarm[0] = 20;
		cursor_pos += 1;
		cursor_pos_async = true;
		keyboard_key_release(vk_right);
	}
} else
	cursor_pos_async = false;
if cursor_pos == string_length(command) + 1
	cursor_pos_async = false;
if (ds_list_size(command_bank) > 0 && !searching && (command == "" || cycling_bank)) {
	if (keyboard_check_pressed(vk_up)) {
		cycling_bank = true;
		if (ds_list_size(command_bank) > 1)
			bank_index--
		if (bank_index < 0)
			bank_index = ds_list_size(command_bank) - 1
		command = ds_list_find_value(command_bank, bank_index)
		cursor_pos = string_length(command) + 1;
	}
	if (keyboard_check_pressed(vk_down)) {
		cycling_bank = true;
		if (ds_list_size(command_bank) > 1)
			bank_index++
		if (bank_index > ds_list_size(command_bank) - 1)
			bank_index = 0
		command = ds_list_find_value(command_bank, bank_index)
		cursor_pos = string_length(command) + 1;
	}
}
if (keyboard_check(vk_backspace) && keyboard_check(vk_lcontrol))
{
	cycling_bank = false;
	command = "";
	keyboard_string = "";
	cursor_pos = 1;
}
if (keyboard_check_pressed(vk_enter) && command != "")
{
	c_Firecommand(string_split(command, " "))
	ds_list_add(command_bank, command)
	bank_index = 0;
	command = "";
	keyboard_string = "";
	cursor_pos = 1;
	display = false;
}
if (searching && haslist && search_list != undefined) {
	if (ds_list_size(search_list) > 0) {
		if (keyboard_check(vk_up)) {
			search_cursor_prev = search_cursor;
			search_cursor++;
			if (search_cursor >= ds_list_size(search_list))
				search_cursor = ds_list_size(search_list) - 1;
			keyboard_key_release(vk_up);
		}
		if (keyboard_check(vk_down)) {
			search_cursor_prev = search_cursor;
			search_cursor--;
			if (search_cursor < 0)
				search_cursor = 0;
			keyboard_key_release(vk_down);
		}
	}
	//if (!string_starts_with(search_sugges, command) && search_sugges != "")
		//search_sugges = "";
}
if (search_cursor != search_cursor_prev)
	search_sugges = ds_list_find_value(search_list, search_cursor);
if (search_sugges == undefined)
	search_sugges = "";
if (keyboard_check_pressed(vk_tab) && haslist) {
	trace("tab");
	if (search_sugges == "") {
		cycling_bank = false;
		searching = true;
		if ((search_sugges == "") && ds_list_size(search_list) > 0) {
			search_sugges = ds_list_find_value(search_list, 0);
			search_cursor = 0;
		}
	} else if (searching) {
		if (array_length(string_split(command, " ")) == 1)
			command = search_sugges;
		else {
			var _raw = "";
			for (var i = 0; i < array_length(string_split(command, " ")); i++) {
				if (i !=  array_length(string_split(command, " ")) - 1) {
					_raw += string_split(command, " ")[i];
					_raw += " ";
				}
			}
			command = _raw + search_sugges;	
		}
		cursor_pos = string_length(command) + 1;
	}
}
if (searching && haslist && search_list != undefined && keyboard_check(vk_anykey) && !keyboard_check(vk_up) && !keyboard_check(vk_down) && !keyboard_check(vk_left) && !keyboard_check(vk_right))
	filter_searchlist();