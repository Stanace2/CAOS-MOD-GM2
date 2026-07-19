FINALLY I WAS ABLE TO CHANGE THE LANG SCRIPT MWAAHAHHAHAHA
I added a variable to check whether the user has installed the chaos.txt or not
## obj_textureloading

~~~js
global.hascaostxt = false; // Here
scr_get_languages();
global.texture_load_count = ds_list_create();
tex_list = noone;
~~~
## scr_lang.gml
### scr_get_languages()

~~~js
function scr_get_languages()
{
	global.lang_map = ds_map_create();
	global.lang_sprite_map = ds_map_create();
	global.lang_texture_map = ds_map_create();
	global.lang_to_load = ds_queue_create();
	global.lang_available = ds_map_create();
	global.lang_loaded = ds_list_create();
	global.lang_tex_max = 0;
	if (!variable_global_exists("lang"))
	{
		global.lang = "en";
	}
	var arr = [];
	var def = file_find_first("lang/*.def", 0);
	while (def != "")
	{
		// Added the checker, defines the variable
		if (def == "chaos.def")
			global.hascaostxt = true;
		array_push(arr, def);
		def = file_find_next();
	}
	file_find_close();
	for (var i = 0; i < array_length(arr); i++)
	{
		var str = scr_lang_get_file_arr("lang/" + arr[i]);
		ds_map_set(global.lang_available, array_get(str, 0), 
		{
			name: str[1],
			file: str[2]
		});
	}
	global.credits_arr = scr_lang_get_credits();
	global.noisecredits_arr = scr_lang_get_noise_credits();
	global.lang_textures_to_load = ds_list_create();
	if (global.hascaostxt) {
		ds_list_add(global.lang_loaded, "en_ch");	
		lang_parse_file("chaos.txt");
	}
	else {
		ds_list_add(global.lang_loaded, "en");	
		lang_parse_file("english.txt");
	}
}
~~~
### lang_get_value_raw()
This is entirely new, seems like the decomp is from the noise update, yaay!
~~~js
function lang_get_value_raw(_language, _entry)
{
	if global.hascaostxt
		var n = ds_map_find_value(ds_map_find_value(global.lang_map, "en_ch"), _entry);
	else {
		var n = ds_map_find_value(ds_map_find_value(global.lang_map, "en"), _entry);
		instance_create_unique(0, 0, obj_langerror);
		with (obj_langerror)
		{
			text = concat("Error: Could not find the mod lang file \nInstall the chaos.txt file");
		}
		if (is_undefined(n))
		{
			n = "";
			instance_create_unique(0, 0, obj_langerror);
			with (obj_langerror)
			{
				text = concat("Error: Could not find lang value \"", _entry, "\"\nPlease restore your english.txt file");
			}
		}
	}
	return n;
}
~~~
