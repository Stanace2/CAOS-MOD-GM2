if !display
	return;
var _hasparamlist = false;
var _paramlist = undefined;
if (array_length(string_split(command, " ")) > 0) {
	var _arr = string_split(command, " ");
	phraseroot = _arr[array_length(_arr) - 1] == ""
} else
	phraseroot = false;
if phraseroot
	haslist = false;
if (array_length(string_split(command, " ")) > 1) {
	var c = c_Findcommand(string_split(command, " ")[0]);
	if c != undefined {
		if (array_length(string_split(command, " ")) < array_length(string_split(c.params, ",")) + 2) {
			param_tip = string_split(c.params, ",")[array_length(string_split(command, " ")) - 2];
			if (c.lists != undefined) {
				if (c.lists[0] == array_length(string_split(command, " ")) - 2) {
					_hasparamlist = true;
					_paramlist = c.lists[1];
				}
			}
		}
		else
			param_tip = "";
	}
	else
		param_tip = "";
}
else
	param_tip = "";
var _phrases = string_split(command, " ");
var _raw = 0;
if (array_length(_phrases) < 2)
	_raw = 0;
else {
	for (var i = 0; i < array_length(_phrases); i++) {
		if (i !=  array_length(_phrases) - 1) {
			_raw++;
			_raw += string_length(_phrases[i])
		}
	}
}
rootpos = _raw * sprite_get_width(spr_caosfont);
if (array_length(string_split(command, " ")) == 1 || _hasparamlist) {
	if (array_length(string_split(command, " ")) == 1)
		ds_list_copy(search_abs_list, command_titles);
	else if _hasparamlist {
		ds_list_copy(search_abs_list, _paramlist);
	}
	if (!haslist)
		ds_list_copy(search_list, search_abs_list);
	haslist = true;
} else
	haslist = false;