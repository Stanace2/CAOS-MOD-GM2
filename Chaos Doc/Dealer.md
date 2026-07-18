# obj_chaosdealer
#textstates
Caos with the gud stuff
Whole caos challenge config and main guru
**sprite : spr_chaosd_idle**
**parent : obj_tutorialbook**
Scripts:
- [[Read custom chaos.txt#scr_chaoslang]]
## Create
Everything should be sorted out, I HOPE
~~~js
scr_create_uparrowhitbox()  
image_speed = 0.35  
depth = 10  
display = 0  
scr_menu_getinput()  
chatted = 0  
show = 0  
skin = 1  
lang_name = ""  
donepanic = 0  
wave_timer = 0  
text = lang_get_chaos("chaoschtut")  
text_borderpad = 32  
text_contentpad = 16  
text_ystart = text_borderpad  
text_y = -200  
tex_x = 0  
text_state = (19 << 0)  
text_xscale = (obj_screensizer.actual_width - 64) / sprite_get_width(spr_tutorialbubble)  
text_oldxscale = text_xscale  
text_yscale = 1  
text_sprite_width = sprite_get_width(spr_tutorialbubble)  
text_sprite_height = sprite_get_height(spr_tutorialbubble)  
text_wave_x = 0  
text_wave_y = 0  
text_arr = -4  
text_dir = 1  
background_spr = spr_chaostexture  
bubble_spr = spr_tutorialbubble  
text_color = c_white  
surfclip = -4  
surffinal = -4  
showgranny = 1  
change_y = 1  
alarm[0] = 1  
voicecooldown = 0  
tippy = 0  
allowed = 0  
cursorimg = 0  
showbuffer = 0  
loaders = 1  
sub_menu = 0  
tips = 0  
tipsp = 0  
tipsg = 0  
tip_index = 1  
menu_pos = 0  
menu_arr = [["caos challenge", global.caoschase], ["customization", [["panic section", global.kpanic], ["iframes", global.ikframes], ["powerups", global.kpowerups], ["caos bells", global.kbells], ["patience", global.kpm], ["toppins", global.ktoppins], ["3rd lap", global.k3lap], ["italian manners", (!obj_player.dos)]]], ["tips", [["power up's", 0], ["general advice", 0]]]]  
ini_open_from_string(obj_savesystem.ini_str)  
virgin = (!(ini_read_real("Chaos", "notvirgin", 0)))  
if (ini_read_real("Chaos", "challenge", 0) == 0)  
{  
    var pscore = 0  
    if (ini_read_string("Ranks", "entrance", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "medieval", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "ruin", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "dungeon", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "badland", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "graveyard", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "farm", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "saloon", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "plage", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "forest", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "minigolf", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "space", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "street", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "industrial", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "sewer", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "freezer", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "chateau", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "war", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "kidsparty", "d") == "p")  
        pscore++  
    if (ini_read_string("Ranks", "exit", "d") == "p")  
        pscore++  
    if (pscore > 1)  
    {  
        quick_ini_write_real(get_savefile_ini(obj_player.ispeppino), "Chaos", "challenge", 1)  
        quick_ini_write_real(get_savefile_ini(obj_player.ispeppino), "Chaos", "tuthint", 1)  
        create_transformation_tip(lang_get_chaos("chaoshinttut"))  
        gamesave_async_save()  
        allowed = 1  
    }  
    else if (ini_read_string("Tutorial", "lapunlocked", 0) == 1)  
    {  
        quick_ini_write_real(get_savefile_ini(obj_player.ispeppino), "Chaos", "challenge", 1)  
        quick_ini_write_real(get_savefile_ini(obj_player.ispeppino), "Chaos", "tuthint", 1)  
        create_transformation_tip(lang_get_chaos("chaoshinttut"))  
        gamesave_async_save()  
        allowed = 1  
    }  
}  
else  
{  
    if (ini_read_real("Chaos", "tuthint", 0) == 0)  
    {  
        quick_ini_write_real(get_savefile_ini(obj_player.ispeppino), "Chaos", "tuthint", 1)  
        create_transformation_tip(lang_get_chaos("chaoshinttut"))  
        gamesave_async_save()  
    }  
    allowed = 1  
}  
ini_close()  
showmenu = (!virgin)
~~~
## Alarms
### 0

~~~js
alarm[0] = room_speed * 0.1  
text_dir *= -1
~~~
### 1

~~~js
event_perform(ev_other, ev_room_start)
~~~
## BeginStep

~~~js
// No idea what this _hide var is
var _hide;  
// All of this is supposed to manage the first time you talk to the dealer
scr_menu_getinput()  
// Look at me hehctor
if (x != obj_player1.x)  
    image_xscale = sign(obj_player1.x - x)  
// Are you a virgin?
if display  
{  
    if (key_jump && virgin)  
    {  
        text = lang_get_chaos("chaoschtut2")  
        event_perform(ev_other, ev_room_start)  
        virgin = 0  
        sprite_index = spr_chaosd_uncover_start  
        image_index = 0  
        menu_pos = 0  
        showmenu = 1  
        showbuffer = 100  
        with (obj_player)  
        {  
            ini_open_from_string(obj_savesystem.ini_str)  
            if (ini_read_real("Chaos", "notvirgin", 0) == 0)  
            {  
                quick_ini_write_real(get_savefile_ini(), "Chaos", "notvirgin", 1)  
                gamesave_async_save()  
            }  
            ini_close()  
        }  
    }  
}  
// Sprite init | Open your coat baby
if (!virgin)  
{  
    if (sprite_index == spr_chaosd_uncover_close && floor(image_index) == (image_number - 1))  
        sprite_index = spr_chaosd_idle  
    if (sprite_index == spr_chaosd_uncover_start && floor(image_index) == (image_number - 1))  
    {  
        var r = irandom_range(1, 101)  
        if (r == 100)  
            sprite_index = spr_chaosd_uncover_ohuh  
        else  
            sprite_index = spr_chaosd_uncover_open  
    }  
    if (sprite_index == spr_chaosd_uncover_ohuh && floor(image_index) == (image_number - 1))  
        sprite_index = spr_chaosd_uncover_open  
    if (sprite_index == spr_chaosd_uncover_open && floor(image_index) == (image_number - 1))  
    {  
        if global.caoschase  
            sprite_index = spr_chaosd_uncover_loop_on  
        else  
            sprite_index = spr_chaosd_uncover_loop_off  
    }  
    if (sprite_index == spr_chaosd_uncover_loop_on && (!global.caoschase))  
        sprite_index = spr_chaosd_uncover_loop_off  
    if (sprite_index == spr_chaosd_uncover_loop_off && global.caoschase)  
        sprite_index = spr_chaosd_uncover_loop_on  
}  
// For the arrow to do the wacky thing
cursorimg += 0.35
~~~
## Step
Basically the same as [[Talkers#obj_chaoschatter]]
~~~js
var r;  
text_xscale = (obj_screensizer.actual_width - 64) / sprite_get_width(spr_tutorialbubble)  
wave_timer += 20  
if (text_xscale != text_oldxscale)  
    event_perform(ev_other, ev_room_start)  
if showgranny  
{  
    if (voicecooldown > 1)  
        voicecooldown--  
    else if (!display)  
        voicecooldown = 0  
    if display  
    {  
        if (voicecooldown == 0)  
        {  
            fmod_event_one_shot_3d("event:/sfx/voice/pizzagranny", x, y)  
            voicecooldown = 100  
        }  
    }  
}  
var _hide = 0  
with (obj_grannypizzasign)  
{  
    if (text_state != (18 << 0))  
        _hide = 1  
}  
if instance_exists(obj_mrsticknotification)  
    _hide = 1  
switch text_state  
{  
    case (19 << 0):  
        repeat (_hide + 1)  
            text_y = Approach(text_y, (-((text_sprite_height * text_yscale))), 5)  
        if (obj_player1.state != (290 << 0) && display && (!_hide))  
        {  
            text_state = (135 << 0)  
            text_vsp = 0  
            if (object_index == obj_tutorialbook && ds_list_find_index(global.saveroom, id) == -1)  
            {  
                ds_list_add(global.saveroom, id)  
                notification_push((73 << 0), [lang_name])  
            }  
        }  
        break  
    case (135 << 0):  
        text_y += text_vsp  
        if (text_vsp < 20)  
            text_vsp += 0.5  
        if (text_y > text_ystart)  
            text_state = (0 << 0)  
        break  
    case (0 << 0):  
        text_y = Approach(text_y, text_ystart, 2)  
        if ((!display) || _hide)  
            text_state = (19 << 0)  
        break  
}  
  
// Same crap as chaoschatter, have to checkit
text_wave_x = gml_Script_Wave(-5, 5, 2, 10, wave_timer)  
text_wave_y = gml_Script_Wave(-1, 1, 4, 0, wave_timer)
~~~
## EndStep
Options manager, i do it here to have everything organized
~~~js
if (showbuffer > 0)  
    showbuffer--  
if (display && (!virgin) && showmenu && showbuffer == 0)  
{  
    if key_down2  
        menu_pos--  
    if key_up2  
        menu_pos++  
    var _menu = menu_arr  
    if sub_menu  
        _menu = menu_arr[1][1]  
    if tips  
        _menu = menu_arr[2][1]  
    if (menu_pos < 0)  
        menu_pos = array_length(_menu) - 1  
    if (menu_pos > (array_length(_menu) - 1))  
        menu_pos = 0  
    if ((key_down2 || key_up2) && sub_menu)  
    {  
        text = lang_get_chaos(concat("chaoscss", (menu_pos + 1)))  
        event_perform(ev_other, ev_room_start)  
    }  
    var horz = key_left2 + key_right2  
    if (horz != 0)  
    {  
        if sub_menu  
        {  
            switch menu_pos  
            {  
                case 4:  
                    if (horz && global.kpm > 0)  
                        global.kpm--  
                    else if (global.kpm < 5)  
                        global.kpm++  
                    _menu[menu_pos][1] = global.kpm  
                    if (global.kpm > 1)  
                    {  
                        text_color = 4235519  
                        text = lang_get_chaos("chaoswarn")  
                        event_perform(ev_other, ev_room_start)  
                    }  
                    else  
                    {  
                        text_color = 16777215  
                        text = lang_get_chaos("chaoscss5")  
                        event_perform(ev_other, ev_room_start)  
                    }  
                    break  
            }  
  
        }  
    }  
    if key_jump  
    {  
        if tips  
        {  
            tips = 0  
            switch menu_pos  
            {  
                case 0:  
                    tip_index = 1  
                    text = lang_get_chaos("chaospwtip1")  
                    event_perform(ev_other, ev_room_start)  
                    tipsp = 1  
                    break  
                case 1:  
                    tip_index = 1  
                    text = lang_get_chaos("chaostip1")  
                    event_perform(ev_other, ev_room_start)  
                    tipsg = 1  
                    break  
            }  
  
            menu_pos = 0  
        }  
        else if tipsg  
        {  
            tip_index++  
            if (tip_index > 8)  
                tip_index = 1  
            text = lang_get_chaos(concat("chaostip", tip_index))  
            event_perform(ev_other, ev_room_start)  
        }  
        else if tipsp  
        {  
            tip_index++  
            if (tip_index > 4)  
                tip_index = 1  
            text = lang_get_chaos(concat("chaospwtip", tip_index))  
            event_perform(ev_other, ev_room_start)  
        }  
        else if (!sub_menu)  
        {  
            switch menu_pos  
            {  
                case 0:  
                    if global.caoschase  
                        global.caoschase = 0  
                    else  
                        global.caoschase = 1  
                    menu_arr[menu_pos][1] = (!menu_arr[menu_pos][1])  
                    break  
                case 1:  
                    text = lang_get_chaos("chaoscss8")  
                    event_perform(ev_other, ev_room_start)  
                    menu_pos = 7  
                    sub_menu = 1  
                    break  
                case 2:  
                    text = lang_get_chaos("chaosstip")  
                    event_perform(ev_other, ev_room_start)  
                    menu_pos = 1  
                    tips = 1  
                    break  
            }  
  
        }  
        else  
        {  
            _menu[menu_pos][1] = (!_menu[menu_pos][1])  
            switch menu_pos  
            {  
                case 0:  
                    if global.kpanic  
                        global.kpanic = 0  
                    else  
                        global.kpanic = 1  
                    break  
                case 1:  
                    if global.ikframes  
                        global.ikframes = 0  
                    else  
                        global.ikframes = 1  
                    break  
                case 2:  
                    if global.kpowerups  
                        global.kpowerups = 0  
                    else  
                        global.kpowerups = 1  
                    break  
                case 3:  
                    if global.kbells  
                        global.kbells = 0  
                    else  
                        global.kbells = 1  
                    break  
                case 4:  
                    break  
                case 5:  
                    if global.ktoppins  
                    {  
                        text_color = 4235519  
                        text = lang_get_chaos("chaoswarn")  
                        event_perform(ev_other, ev_room_start)  
                        _menu[menu_pos][1] = 2  
                        global.ktoppins = 0  
                    }  
                    else  
                    {  
                        text_color = 16777215  
                        text = lang_get_chaos("chaoscss6")  
                        event_perform(ev_other, ev_room_start)  
                        _menu[menu_pos][1] = 1  
                        global.ktoppins = 1  
                    }  
                    break  
                case 6:  
                    if global.k3lap  
                        global.k3lap = 0  
                    else  
                        global.k3lap = 1  
                    break  
                case 7:  
                    if obj_player.dos  
                    {  
                        with (obj_player1)  
                        {  
                            spr_suplexdash = 4707  
                            spr_suplexdashjumpstart = 4705  
                            spr_suplexdashjump = 4704  
                            spr_longjump = 4703  
                            spr_longjumpend = 4706  
                        }  
                        obj_player.dos = 0  
                        obj_player.wm = 0  
                    }  
                    else  
                    {  
                        with (obj_player1)  
                        {  
                            if (paletteselect != 18 && ispeppino)  
                            {  
                                spr_suplexdash = 811  
                                spr_suplexdashjumpstart = 1110  
                                spr_suplexdashjump = 1105  
                                spr_longjump = 3759  
                                spr_longjumpend = 621  
                            }  
                        }  
                        obj_player.dos = 1  
                        obj_player.wm = 1  
                    }  
                    break  
            }  
  
        }  
    }  
    if key_back  
    {  
        text_color = 16777215  
        if sub_menu  
        {  
            var r = irandom_range(1, 4)  
            text = lang_get_chaos(concat("chaosdone", r))  
            event_perform(ev_other, ev_room_start)  
            sub_menu = 0  
            menu_pos = 0  
            return;  
        }  
        if tips  
        {  
            r = irandom_range(1, 4)  
            text = lang_get_chaos(concat("chaosdone", r))  
            event_perform(ev_other, ev_room_start)  
            tips = 0  
            menu_pos = 0  
            return;  
        }  
        if (tipsg || tipsp)  
        {  
            text = lang_get_chaos("chaosstip")  
            event_perform(ev_other, ev_room_start)  
            tips = 1  
            tipsg = 0  
            tipsp = 0  
            menu_pos = 0  
            return;  
        }  
        if (!virgin)  
        {  
            image_index = 0  
            sprite_index = spr_chaosd_uncover_close  
        }  
        obj_player1.state = (0 << 0)  
        display = 0  
    }  
}
~~~
## Collision | obj_player

~~~js
// Pressing up to have a little parley
if (other.key_up2 && (!display) && other.state == (0 << 0))  
{  
    if (!virgin)  
    {  
        var r = irandom_range(1, 6)  
        text = lang_get_chaos(concat("chaosch", r))  
        event_perform(ev_other, ev_room_start)  
        sprite_index = spr_chaosd_uncover_start  
        image_index = 0  
    }  
    menu_pos = -1  
    obj_camera.chargecamera = 0  
    display = 1  
    other.state = (8 << 0)  
    other.sprite_index = spr_player_idle  
    other.hsp = 0  
    other.movespeed = 0  
    other.vsp = 0  
    other.image_speed = 0.35  
}
~~~
## RoomStart
Resets the Dealer dialogs
~~~js
if loaders  
{  
    if (!allowed)  
        instance_destroy()  
    loaders = 0  
}  
if global.panic  
    instance_destroy()  
if is_undefined(text)  
    return;  
var r = string_letters(room_get_name(room))  
if surface_exists(surfclip)  
    surface_free(surfclip)  
if surface_exists(surffinal)  
    surface_free(surffinal)  
var p = 1  
var l = string_length(text)  
var old_text = text  
text = ""  
font = lang_get_font("tutorialfont")  
draw_set_font(font)  
trace("Separating text: ", old_text)  
while (p <= l)  
{  
    text = string_insert(string_char_at(old_text, p), text, (p + 1))  
    text = scr_separate_text(text, -4, (text_sprite_width * text_xscale - text_contentpad * 2))  
    p++  
}  
trace("Separated text: ", text)  
text_yscale = (string_height(text) + text_contentpad * 2) / text_sprite_height  
if (text_yscale < 1)  
    text_yscale = 1  
text_oldxscale = text_xscale  
draw_set_font(font)  
text_arr = scr_compile_icon_text(text)
~~~
## DrawGUIEnd

~~~js
// Draw Selector cursor
if display  
{  
    var handyy = text_y + text_wave_y + sprite_get_height(bubble_spr) * text_yscale  
    if (virgin || tipsp || tipsg)  
        draw_sprite_ext(spr_dealercursor, cursorimg, (obj_screensizer.actual_width - 100), handyy, 1, 1, 0, c_white, 1)  
    if tipsp  
    {  
        var pw = spr_chaospowerup  
        if (tip_index != 1)  
            pw = asset_get_index(concat("spr_chaospowerup", tip_index))  
        draw_sprite_ext(pw, cursorimg, 100, (handyy + 50), 1, 1, 0, c_white, 1)  
    }  
}
~~~
## Draw
For later
~~~js
draw_self()
~~~
## DrawGUIBegin
I didn't unified the three of the GUI methods to have everything more segmented.
That and the fact that GUI method for pizza granny is fucking broken in UTMT
~~~js
// Menu options drawer
if (display && showmenu && (!virgin))  
{  
    var handyy = text_y + text_wave_y + sprite_get_height(bubble_spr) * text_yscale  
    var _menu = menu_arr  
    if sub_menu  
        _menu = menu_arr[1][1]  
    if tips  
        _menu = menu_arr[2][1]  
    var offset = menu_pos * 30  
    if (tipsg || tipsp)  
        return;  
    var _spr = spr_dealercursor  
    if (sub_menu && menu_pos == 4)  
        _spr = 4805  
    draw_sprite_ext(_spr, cursorimg, 60, (handyy + 35), 1, 1, 0, c_white, 1)  
    for (var i = 0; i < array_length(_menu); i++)  
    {  
        var addon = ""  
        if (sub_menu && i == 4)  
            addon = concat(": x", global.kpm)  
        var text = concat(_menu[i][0], addon)  
        draw_set_font(lang_get_font("creditsfont"))  
        draw_set_halign(fa_left)  
        draw_set_valign(fa_top)  
        var _color = 16777215  
        if (_menu[i][1] == 1)  
            _color = 16711935  
        if (_menu[i][1] == 2)  
            _color = 4235519  
        if (sub_menu && i == 4)  
        {  
            if (global.kpm == 0)  
                _color = 16777215  
            else if (global.kpm == 1)  
                _color = 16711935  
            else  
                _color = 4235519  
        }  
        tdp_draw_text_color(100, (handyy + 10 + offset), text, _color, _color, _color, _color, 1)  
        offset -= 30  
    }  
}
~~~

