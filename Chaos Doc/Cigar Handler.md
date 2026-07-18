## obj_cigartracker
Sweet director that checks constantly if some parameters are met to give you new costumes
### Create
~~~js
// We check if there's more instances
if (instance_number(object_index) > 1)  
{  
    instance_destroy()  
    return;  
}  
// Exceptions in case of customization
global.nocigar = 0  
// Check for chaos prizes
checklevel = 0  
// Check for generic palettes
checkexit = 0  
lvl = ""  
// This is used in step while checking to give the player the level palette, if the toppin goal is not met, then is cheating
cheat = 1  
inlevel = 0  
// Buffer variables
shadow_chk = 1  
hellish_chk = 1  
hellish_buffer = 0  
magical_chk = 0  
aqua_chk = 0  
quetzal_chk = 0  
boss_trigger = 0  
// Opens the save file to define the last variables
// Gets the current number of goth kills and whether to check for the final rank costumes
ini_open_from_string(obj_savesystem.ini_str_options)  
global.gothkills = ini_read_real("ChaosChaos", "gothkills", 0)  
if (ini_read_real("ChaosChaos", "gothkills", 0) >= 100)  
    global.gothunlocked = 1  
magical_chk = ini_read_real("Palettes", "maguma", 0)  
aqua_chk = ini_read_real("Palettes", "aqua", 0)  
quetzal_chk = ini_read_real("Palettes", "quetzal", 0)  
obj_savesystem.ini_str_options = ini_close()
~~~
### BeginStep
Goth kills are tracked in:
- [[Cigar ocurrences and tracking spots#scr_player_superslam]]
~~~js
// This is checking constantly if the gothkills are above the expected number
// Once it unlocks the custome, in the create method of cigartracker, it'll acknowledge it has already being unlocked, making this block unaccesable
if (!global.gothunlocked)  
{  
    if (global.gothkills >= 100)  
    {  
        alarm[0] = 5  
        palette_cigar("goth", 26)  
        global.gothunlocked = 1  
    }  
}
~~~
### Step
Level check is done in:
- [[Cigar ocurrences and tracking spots#gml_GlobalScript_scr_do_rank]]
~~~js
// If toppins are disable of caos is chill
global.nocigar = ((!global.ktoppins) || global.kpm > 1)  
if (global.nocigar || (!global.caoschase))  
    return;  
// If toppin goal is met, not cheating, guilty until proven other wise
if instance_exists(obj_chaosUI)  
{  
    if obj_chaosUI.gg  
        cheat = 0  
}  
// When checklevel is true, then gives the palette if not cheating
if (checklevel && (!cheat))  
{  
    switch lvl  
    {  
        case "entrance":  
            palette_cigar("gloomy", 30, 4734)  
            break  
        case "medieval":  
            palette_cigar("hero", 31)  
            break  
        case "ruin":  
            palette_cigar("cheese", 32, 4730)  
            break  
        case "dungeon":  
            palette_cigar("boiling", 33)  
            break  
        case "badland":  
            palette_cigar("aldente", 34)  
            break  
        case "graveyard":  
            palette_cigar("spectral", 35)  
            break  
        case "farm":  
            palette_cigar("fun", 36)  
            break  
        case "saloon":  
            palette_cigar("sunset", 37)  
            break  
        case "plage":  
            palette_cigar("party", 38)  
            break  
        case "forest":  
            palette_cigar("goblin", 39)  
            break  
        case "minigolf":  
            palette_cigar("goof", 40, 4733)  
            break  
        case "space":  
            palette_cigar("space", 41)  
            break  
        case "street":  
            palette_cigar("italian", 42, 4731)  
            break  
        case "industrial":  
            palette_cigar("donibot", 43, 4732)  
            break  
        case "sewer":  
            palette_cigar("two", 44)  
            break  
        case "freezer":  
            palette_cigar("snow", 45)  
            break  
        case "chateau":  
            palette_cigar("varoness", 46)  
            break  
    }  
  
    cheat = 1  
    checklevel = 0  
    lvl = ""  
}
~~~
### EndStep
#states
Exit check is done in:
- [[Cigar ocurrences and tracking spots#gml_GlobalScript_scr_do_rank]]
~~~js
// "Calls" checkexit if the boss is dead
if (!boss_trigger)  
{  
    if instance_exists(obj_bosscontroller)  
    {  
        with (obj_bosscontroller)  
        {  
            if bossdead  
            {  
                other.boss_trigger = 1  
                other.checkexit = 1  
            }  
        }  
    }  
}  
// Restarts everything if the player is back to hub
if (string_copy(room_get_name(room), 1, 5) == "tower")  
{  
    inlevel = 0  
    cheat = 1  
    checklevel = 0  
    lvl = ""  
    checkexit = 0  
    shadow_chk = 1  
    hellish_chk = 1  
}  
else  
    inlevel = 1  
// This is to prevent the checking for the palettes while breaking john
// These palettes should always be checked while exiting using the exitgate
if (global.caoschase && (!global.kpanic))  
    return;  
if inlevel  
{  
    if shadow_chk  
    {  
        with (obj_player)  
        {  
	        // If run key is pressed, no cigar
            if (key_attack || key_attack2)  
                other.shadow_chk = 0  
        }  
        if checkexit  
            palette_cigar("shadow", 25)  
    }  
    if hellish_chk  
    {  
        if (!instance_exists(obj_bosscontroller))  
            hellish_chk = 0  
        with (obj_player)  
        {  
	        // While being in normal state and pressing a movement key for at least 30 frames, no cigar bucko
            if (state == (0 << 0) && (key_left || key_right))  
                hellish_buffer++  
            else  
                hellish_buffer = 0  
            if (hellish_buffer > 30)  
                other.hellish_chk = 0  
        }  
        if checkexit  
            palette_cigar("demoness", 29, 4604)  
    }  
}  
if checkexit  
    checkexit = 0
~~~
### Alarms
#### 0
Called in:
- [[#BeginStep]]
~~~js
ini_open_from_string(obj_savesystem.ini_str_options)  
var _prev = ini_read_real("ChaosChaos", "gothkills", 0)  
ini_write_real("ChaosChaos", "gothkills", (global.gothkills + 1))  
if (_prev <= 100)  
    gamesave_async_save_options()  
obj_savesystem.ini_str_options = ini_close()
~~~
#### 1
Called in:
- [[Cigar ocurrences and tracking spots#obj_endingrank#Create]]
~~~js
if (!magical_chk)  
{  
    palette_cigar("maguma", 28, 4601)  
    magical_chk = 1  
}
~~~
#### 2
Called in:
- [[Cigar ocurrences and tracking spots#obj_endingrank#Create]]
~~~js
if (!aqua_chk)  
{  
    palette_cigar("aqua", 24)  
    aqua_chk = 1  
}
~~~
#### 3
Called in:
- [[Cigar ocurrences and tracking spots#obj_endingrank#Create]]
~~~js
if (!quetzal_chk)  
{  
    palette_cigar("quetzal", 27, 4699)  
    quetzal_chk = 1  
}
~~~

==(Theres probably better ways to do those checks in a single line or method)==

## scr_chaoscigar
### palette_cigar()
Shows you what you just unlocked and saves it
~~~js
function palette_cigar(argument0, argument1, argument2) //gml_Script_palette_cigar  
{  
    if (argument2 == undefined)  
        argument2 = -4  
    ini_open_from_string(obj_savesystem.ini_str_options)  
    // Saves the unlocked palette
    var _unlocked = ini_read_real("Palettes", argument0, 0)  
    ini_write_real("Palettes", argument0, 1)  
    obj_savesystem.ini_str_options = ini_close()  
    gamesave_async_save_options()  
    if (!_unlocked)  
    {  
        with (instance_create(0, 0, obj_cheftask))  
        {  
            achievement_spr = -4  
            sprite_index = spr_newclothes  
            paletteselect = argument1  
            texture = argument2  
        }  
    }  
}
~~~
[^1]: argument0 : *name of the palette* | string
[^2]: argument1 : *column where the palette recides* | num
[^3]: argument2 : *texture sprite if any* | sprite