## obj_palettedresser
This object handles all the logic related to displaying all palettes on screen
### Create
Main changes are:
- Distinction between Noise and pep ==(Probably will be obsolete later)==
- More palettes
- New variables and actor array
~~~js
depth = 100  
actor_array = []  
player_palettes = []  
player_palettes[0] = [["classic", 1, 1], ["unfunny", 0, 3], ["money", 0, 4], ["sage", 0, 5], ["blood", 0, 6], ["tv", 0, 7], ["dark", 0, 8], ["shitty", 0, 9], ["golden", 0, 10], ["garish", 0, 11], ["mooney", 0, 15], ["funny", 0, 17, 4398], ["itchy", 0, 12, 511], ["pizza", 0, 12, 3125], ["stripes", 0, 12, 1806], ["goldemanne", 0, 16, 4065], ["bones", 0, 12, 4322], ["pp", 0, 18, 4293], ["war", 0, 19, 917], ["john", 0, 20, 4315], ["aqua", 0, 24, 4835], ["shadow", 0, 25], ["goth", 0, 26], ["quetzal", 0, 27, 4699], ["maguma", 0, 28, 4601], ["demoness", 0, 29, 4604], ["gloomy", 0, 30, 4734], ["hero", 0, 31], ["cheese", 0, 32, 4730], ["boiling", 0, 33], ["aldente", 0, 34], ["spectral", 0, 35], ["fun", 0, 36], ["sunset", 0, 37], ["party", 0, 38], ["goblin", 0, 39], ["goof", 0, 40, 4733], ["space", 0, 41], ["italian", 0, 42, 4731], ["donibot", 0, 43, 4732], ["two", 0, 44], ["snow", 0, 45], ["varoness", 0, 46]]  
player_palettes[1] = [["classicN", 1, 1], ["boise", 0, 3], ["roise", 0, 4], ["poise", 0, 5], ["reverse", 0, 6], ["critic", 0, 7], ["outlaw", 0, 8], ["antidoise", 0, 9], ["flesheater", 0, 10], ["super", 0, 11], ["porcupine", 0, 15], ["feminine", 0, 16], ["realdoise", 0, 17], ["forest", 0, 18], ["racer", 0, 28, 699], ["comedian", 0, 27, 656], ["banana", 0, 26, 4035], ["noiseTV", 0, 25, 3629], ["madman", 0, 24, 4488], ["bubbly", 0, 23, 3863], ["welldone", 0, 22, 2633], ["grannykisses", 0, 21, 1930], ["towerguy", 0, 20, 2277]]  
ini_open_from_string(obj_savesystem.ini_str_options)  
for (var i = 0; i < array_length(player_palettes); i++)  
{  
    array_push(player_palettes[i], ["candy", 0, 12, 4546])  
    array_push(player_palettes[i], ["bloodstained", 0, 12, 2999])  
    array_push(player_palettes[i], ["bat", 0, 12, 3635])  
    if (i == 0)  
    {  
        array_push(player_palettes[i], ["pumpkin", 0, 21, 1988])  
        array_push(player_palettes[i], ["fur", 0, 22, 2047])  
        array_push(player_palettes[i], ["flesh", 0, 23, 4577])  
    }  
    else  
    {  
        array_push(player_palettes[i], ["pumpkin", 0, 12, 1988])  
        array_push(player_palettes[i], ["fur", 0, 12, 2047])  
        array_push(player_palettes[i], ["flesh", 0, 12, 4577])  
    }  
    for (var j = 1; j < array_length(player_palettes[i]); j++)  
    {  
        if ini_read_real("Palettes", player_palettes[i][j][0], 0)  
            player_palettes[i][j][1] = 1  
    }  
}  
ini_close()  
for (i = 0; i < array_length(player_palettes); i++)  
{  
    array_push(actor_array, [])  
    for (j = 0; j < array_length(player_palettes[i]); j += 3)  
    {  
        var dud = []  
        for (var w = 0; w < 3; w++)  
        {  
            if ((j + w) < array_length(player_palettes[i]))  
                array_push(dud, player_palettes[i][(j + w)])  
        }  
        array_push(actor_array[i], dud)  
    }  
}  
scr_create_uparrowhitbox()  
paletteselect = 0  
ispeppino = -1  
showtext = 0  
alpha = 0  
palettetitle = ""  
palettedesc = ""  
display = 0  
ad = 0  
drawn = 0  
bg_x = 0  
bg_y = 0  
usebuffer = 0  
scolumn = 0  
srow = 0  
scr_menu_getinput()
~~~

### Step
Main code got deleted, got remade in EndStep. Handles basic stuff.
~~~js
if (obj_player1.ispeppino != ispeppino)  
{  
    ispeppino = obj_player1.ispeppino  
    if obj_player1.ispeppino  
        palettes = player_palettes[0]  
    else  
        palettes = player_palettes[1]  
}  
showtext = place_meeting(x, y, obj_player)  
if instance_exists(obj_transfotip)  
    showtext = 0  
if showtext  
    alpha = Approach(alpha, 1, 0.1)  
else  
    alpha = Approach(alpha, 0, 0.1)
~~~
### EndStep
#states
All code is new additions
Related objects:
- [[Palettes visualizer#obj_dresserbg]]
- [[Palettes visualizer#obj_dresseractor]]
~~~js
// Main boolean to run the logic, due to this being run the whole time youre in the same room
if display  
{  
	// This thing brings the actors depending on the amount of palettes for character, 0 is peppino (Donisha), 1 is noise palettes
    var pep = 0  
    if (!ispeppino)  
        pep = 1  
    var actors = actor_array[pep]  
    scr_menu_getinput()  
    ad = Approach(ad, 1, 0.1)  
    // Exit menu, deactivate all related objects
    if key_back  
    {  
        obj_dresserbg.die = 1  
        obj_dresseractor.die = 1  
        display = 0  
        obj_player1.state = (0 << 0)  
    }  
    // Selecting a palette, check for jump key, and if the palette is unlocked
    if (key_jump && actors[scolumn][srow][1])  
    {  
	    // spawn the floating clothe
        with (instance_create(x, y, obj_sausageman_dead))  
        {  
            fmod_event_one_shot_3d("event:/sfx/misc/clotheswitch", x, y)  
            hsp = irandom_range(-5, 5)  
            vsp = (-(irandom_range(6, 11)))  
            usepalette = 1  
            sprite_index = spr_palettedresserdebris  
            if (!obj_player1.ispeppino)  
                sprite_index = spr_palettedresserdebrisN  
            spr_palette = obj_player1.spr_palette  
            paletteselect = obj_player1.paletteselect  
            oldpalettetexture = global.palettetexture  
        }  
        // Assign the variables to select the correct column in the palette sprite
        obj_player1.player_paletteselect[obj_player1.player_paletteindex] = actors[scolumn][srow][2]  
        var pattern = -4  
        if (array_length(actors[scolumn][srow]) > 3)  
            pattern = actors[scolumn][srow][3]  
        obj_player1.player_patterntexture[obj_player1.player_paletteindex] = pattern  
        trace(obj_player1.player_paletteselect, " pal")  
        trace(obj_player1.player_patterntexture, " texture")  
        // Save the selected palette in the save file
        ini_open_from_string(obj_savesystem.ini_str)  
        ini_write_real("Game", "palette", obj_player1.player_paletteselect[0])  
        ini_write_real("Game", "palette_player2", obj_player1.player_paletteselect[1])  
        ini_write_string("Game", "palettetexture", scr_get_texture_name(obj_player1.player_patterntexture[0]))  
        ini_write_string("Game", "palettetexture_player2", scr_get_texture_name(obj_player1.player_patterntexture[1]))  
        obj_savesystem.ini_str = ini_close()  
        // Exit
        obj_dresserbg.die = 1  
        obj_dresseractor.die = 1  
        display = 0  
         // Make the character do the dress sprite
        obj_player1.image_index = 0  
        obj_player1.sprite_index = spr_player_dressup  
        obj_player1.jumpAnim = true  
        obj_player1.landAnim = false  
        // When selecting the pp palette, assign the peppino sprites
        with (obj_player1)  
        {  
            if ispeppino  
            {  
                if (actors[other.scolumn][other.srow][0] == "pp")  
                {  
                    spr_suplexdash = 4707  
                    spr_suplexdashjumpstart = 4705  
                    spr_suplexdashjump = 4704  
                    spr_longjump = 4703  
                    spr_longjumpend = 4706  
                }  
                else if dos  
                {  
                    spr_suplexdash = 811  
                    spr_suplexdashjumpstart = 1110  
                    spr_suplexdashjump = 1105  
                    spr_longjump = 3759  
                    spr_longjumpend = 621  
                }  
            }  
        }  
    }  
    if (key_jump && (!actors[scolumn][srow][1]))  
        fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    // Assigns title and description when displayed in draw function
    palettetitle = lang_get_chaos(concat("dresser_", actors[scolumn][srow][0], "title"))  
    palettedesc = lang_get_chaos_newline(concat("dresser_", actors[scolumn][srow][0]))  
}  
else  
    ad = Approach(ad, 0, 0.1)  
// Menu controls, has position awareness
if (usebuffer < 1 && display)  
{  
    if (-key_left2)  
    {  
        if (scolumn != 0)  
        {  
            with (obj_dresseractor)  
                relx += 100  
            scolumn -= 1  
        }  
        else if (srow > ((array_length(actors[(array_length(actors) - 1)])) - 1))  
        {  
            with (obj_dresseractor)  
                relx -= (100 * (array_length(actors) - 2))  
            scolumn = array_length(actors) - 2  
        }  
        else  
        {  
            with (obj_dresseractor)  
                relx -= (100 * (array_length(actors) - 1))  
            scolumn = array_length(actors) - 1  
        }  
    }  
    if key_right2  
    {  
        if (scolumn != (array_length(actors) - 1))  
        {  
            if (srow > ((array_length(actors[(scolumn + 1)])) - 1))  
            {  
                with (obj_dresseractor)  
                    relx += (100 * (array_length(actors) - 2))  
                scolumn = 0  
            }  
            else  
            {  
                with (obj_dresseractor)  
                    relx -= 100  
                scolumn += 1  
            }  
        }  
        else  
        {  
            with (obj_dresseractor)  
                relx += (100 * (array_length(actors) - 1))  
            scolumn = 0  
        }  
    }  
    if key_up2  
    {  
        if (srow != 0)  
        {  
            with (obj_dresseractor)  
                rely += 100  
            srow -= 1  
        }  
        else  
        {  
            with (obj_dresseractor)  
                rely -= (100 * (array_length(actors[other.scolumn]) - 1))  
            srow = array_length(actors[scolumn]) - 1  
        }  
    }  
    if key_down2  
    {  
        if (srow != (array_length(actors[scolumn]) - 1))  
        {  
            with (obj_dresseractor)  
                rely -= 100  
            srow += 1  
        }  
        else  
        {  
            with (obj_dresseractor)  
                rely += (100 * (array_length(actors[other.scolumn]) - 1))  
            srow = 0  
        }  
    }  
}  
// Prevent spam
if (usebuffer > 0)  
    usebuffer--
~~~
### Collision_obj_player
#states
Handles the activation of visuals and frozing the player
Related scripts or objects:
- state (8 << 0) | "[[scr_player_transitioncutscene()]]"
- [[Palettes visualizer#obj_dresserbg]]
- [[Palettes visualizer#obj_dresseractor]]
~~~js
if (other.key_up2 && (!display) && other.ispeppino == ispeppino && other.state == (0 << 0))  
{  
    obj_camera.chargecamera = 0  
    usebuffer = 20  
    display = 1  
    // I hijacked this state to make a sort of "freeze" state
    other.state = (8 << 0)  
    other.sprite_index = spr_player_idle  
    other.hsp = 0  
    other.movespeed = 0  
    other.vsp = 0  
    other.image_speed = 0.35  
    // Creation of dresser GUI Background
    instance_create(x, y, obj_dresserbg) 
    // This is unsued vvv 
    var _player = -2  
    // Defines which actor to spawn
    var pep = 0  
    if (!ispeppino)  
        pep = 1  
    var actors = actor_array[pep]  
    with (obj_player1)  
        var pal = (ispeppino ? get_pep_palette_info() : get_noise_palette_info())  
    var _relx = 0  
    var _rely = 0  
    for (var i = 0; i < array_length(actors); i++)  
    {  
        for (var j = 0; j < array_length(actors[i]); j++)  
        {  
	        // Create every actor
            with (instance_create((obj_player1.x - camera_get_view_x(view_camera[0]) + _relx), (obj_player1.y - camera_get_view_y(view_camera[0]) + _rely), obj_dresseractor))  
            {  
                sprite_index = choose(spr_player_idle, spr_player_3hpidle, spr_player_blush, spr_player_wonder, spr_player_rageidle, spr_donisha_scared, spr_player_freezeridle)  
                image_index = 0  
                if actors[i][j][1]  
                    unlocked = 1  
                palettespr = pal.spr_palette  
                paletteindex = actors[i][j][2]  
                if (array_length(actors[i][j]) > 3)  
                    palettetexture = actors[i][j][3]  
            }  
            // If the actor spawned has the same palette selected as the player, safe its position for later
            if ((actors[i][j][2] == obj_player1.paletteselect && array_length(actors[i][j]) <= 3) || (array_length(actors[i][j]) > 3 && actors[i][j][3] == global.palettetexture))  
            {  
                fmod_event_one_shot_3d("event:/sfx/misc/clotheswitch", x, y)  
                scolumn = i  
                srow = j  
            }  
            _rely += 100  
        }  
        _rely = 0  
        _relx += 100  
    }  
    // Move all actors to match the current player palette with the actor with the same palette
    with (obj_dresseractor)  
    {  
        relx -= (100 * other.scolumn)  
        rely -= (100 * other.srow)  
    }  
}
~~~
### Draw
Really itti pitti tiny change
~~~js
if (!global.option_hud)  
    return;  
// The alpha variable got replaced with ad
if (obj_player1.ispeppino == ispeppino && ad > 0)  
{  
    var text = concat(palettetitle, "\n", palettedesc)  
    draw_set_font(lang_get_font("creditsfont"))  
    draw_set_halign(fa_center)  
    draw_set_valign(fa_bottom)  
    tdp_draw_text_color((obj_screensizer.actual_width / 2), (obj_screensizer.actual_height - 16), text, 16777215, 16777215, 16777215, 16777215, ad)  
    tdp_text_commit(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height)  
}
~~~
