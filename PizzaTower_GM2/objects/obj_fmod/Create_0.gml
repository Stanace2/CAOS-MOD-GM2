var maxChannels = 256;
trace("Initializing FMOD: ", fmod_init(maxChannels));
fmod_set_num_listeners(1);
if file_exists(working_directory + "sound/Desktop/Chaos/chaos-sfx.bank")  
{  
    trace("Chaos found!");
    var plat = "Desktop/Chaos";
}  
else {
	instance_create_unique(0, 0, obj_fmoderror);
	with (obj_fmoderror)
	{
		text = concat("Error: Could not find and load the sound banks for the mod \nGo watch the tutorial on the mod page");
	}
    plat = "Desktop";
}
var banks = [concat("sound/", plat, "/Master.bank"), concat("sound/", plat, "/music.bank"), concat("sound/", plat, "/sfx.bank"), concat("sound/", plat, "/Master.strings.bank"), concat("sound/", plat, "/chaos-sfx.bank")];
trace("Loading banks! Platform -> ", plat);
for (var i = 0; i < array_length(banks); i++)
{
	var b = working_directory + banks[i];
	trace("Loading bank at: ", b);
	if (fmod_bank_load(b, false))
	{
		trace("Loading bank sample data at: ", b);
		if (!fmod_bank_load_sample_data(b))
		{
			trace("Could not load bank sample data: ", b);
		}
	}
	else
	{
		trace("Could not load bank: ", b);
	}
}
global.sound_map = ds_map_create();
global.steam_api = false;
global.screenshotcount = 0;
