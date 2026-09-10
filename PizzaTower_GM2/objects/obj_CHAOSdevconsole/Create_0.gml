depth = -9999
command = ""
keyboard_string = "";
cursor = 0;
cursor_pos = 1;
cursor_pos_async = false;
cursor_blink = false;
alarm[0] = 20
display = false;
tick_records = false;
create_commandlists()
rooms = ds_list_create();
for (var i = 0; room_exists(i); i++)
	ds_list_add(rooms,room_get_name(i))
c_Createcommands();
records = ds_list_create();
command_bank = ds_list_create();
bank_index = 0;
cycling_bank = false;
noclip_arguments = [spr_player_idle,states.normal];
showhud = true;
baddieID = -1;
fire_obj = noone;
fire_var = noone;
fire_val = -1;
command_titles = ds_list_create();
for (var i = 0; i < ds_list_size(command_list); i++)
	ds_list_add(command_titles,ds_list_find_value(command_list, i).command_name);
search_list = ds_list_create();
ds_list_copy(search_list, command_titles);
search_cursor = 0;
search_cursor_prev = -1;
search_index = 0;
search_sugges = "";
search_abs_list = ds_list_create();
phraseroot = false;
rootpos = 0;
haslist = true;
ds_list_copy(search_abs_list, command_titles);
searching = false;
param_tip = "";
ds_list_sort(command_titles, true);
ds_list_sort(rooms, true);
ds_list_sort(ID_transfos, true);
ds_list_sort(ID_items, true);
ds_list_sort(ID_chars, true);
global.sv_cheats = false;