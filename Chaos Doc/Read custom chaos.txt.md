This is not comprehensive for the whole game, dialog from granny and others are handled still by the default functions, the following script is to make chaos dialogs work
Referenced in:
- [[Talkers]]
- [[Palette dresser code changes#EndStep]]
***
## scr_chaoslang

~~~js
function lang_get_chaos(argument0) 
{  
    var n = ds_map_find_value(ds_map_find_value(global.lang_map, "en_ch"), argument0)  
    if is_undefined(n)  
    {  
        n = ""  
        instance_create_unique(0, 0, 133)  
        with (obj_langerror)  
            text = concat("Error: Could not find lang value \"", argument0, "\"\nPlease restore your chaos.txt file")  
    }  
    return n;  
}  
  
function lang_get_chaos_newline(argument0) //gml_Script_lang_get_chaos_newline  
{  
    return string_replace_all(lang_get_chaos(argument0), "\\n", "\n");  
}
~~~

==**lang_get_chaos()**==  
- Helps the game recognize the file "en_ch" and look for the desired dialog text
==**lang_get_chaos_newline()**==
- For some reason, in order to put a new line in the drawing function of the dresser, this needs to be implemented
