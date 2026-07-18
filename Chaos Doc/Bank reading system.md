Changes the script "gml_Object_obj_fmod_Create_0" to make the game recognize the new Master.bank file to apply new sounds without overwritting anything.
The below code helps find the custom bank in the "Chaos" folder, if it's not present, it'll default to the original one
***
## gml_Object_obj_fmod_Create_0

````js
var maxChannels = 256  
trace("Initializing FMOD: ", fmod_init(maxChannels))  
fmod_set_num_listeners(1)  
if file_exists(working_directory + "sound/Desktop/Chaos/chaos-sfx.bank")  
{  
    trace("Chaos found!")  
    var plat = "Desktop/Chaos"  
}  
else  
    plat = "Desktop"  
trace("Loading banks! Platform -> ", plat)  
var banks = [concat("sound/", plat, "/Master.bank"), concat("sound/", plat, "/music.bank"), concat("sound/", plat, "/sfx.bank"), concat("sound/", plat, "/Master.strings.bank"), concat("sound/", plat, "/chaos-sfx.bank")]
for (var i = 0; i < array_length(banks); i++)  
{  
    var b = working_directory + banks[i]  
    trace("Loading bank at: ", b)  
    if fmod_bank_load(b, 0)  
    {  
        trace("Loading bank sample data at: ", b)  
        if (!fmod_bank_load_sample_data(b))  
            trace("Could not load bank sample data: ", b)  
    }  
    else  
        trace("Could not load bank: ", b)  
}  
global.sound_map = ds_map_create()  
global.steam_api = 0  
global.screenshotcount = 0
````

