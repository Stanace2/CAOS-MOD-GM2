if (ds_list_size(records) > 10)
	ds_list_delete(records, 0);
if (ds_list_size(command_bank) > 20)
	ds_list_delete(command_bank, 0);
if (!display && command == "") {
	searching = false;
	search_sugges = "";
	cycling_bank = true;
}
if (command == "" && !searching) {
	cycling_bank = true;
	bank_index = 0;
	search_cursor = 0;
}
if (!searching || !display)
	search_sugges = "";
event_user(0)