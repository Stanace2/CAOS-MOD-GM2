# obj_chaoschatter
#textstates
Caos chitchatter
Every chaos chatter must have their dialog initialized when creating them, ex:
~~~js
// New lang function used here
arr_text = [lang_get_chaos("chaost1"), "Don't you have a tutorial to do?"]  
// 1 nonchalant 2 rude 3 cute
skin = 1
~~~
**sprite : spr_chaos_idle**
**parent : obj_tutorialbook**
Scripts:
- [[Read custom chaos.txt#scr_chaoslang]]
## Create

~~~js
image_speed = 0.35  
mask_index = spr_tutorialgranny_sleep  
chat = 0  
show = 0  
skin = 1  
lang_name = ""  
donepanic = 0  
wave_timer = 0  
arr_text = ["kiss my ass!"]  
text = arr_text[0]  
diagindex = 0  
text_borderpad = 32  
text_contentpad = 16  
text_ystart = text_borderpad  
text_y = -200  
tex_x = 0  
text_state = (18 << 0)  
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
depth = 10  
voicecooldown = 0  
spr_idle = spr_chaos_idle  
spr_chat = spr_chaos_chat  
if global.caoschase  
    instance_destroy()
~~~
## Step
Got to be careful with this one, decomp didn't do any favors
~~~js
if (sign(x - obj_player.x) != 0)  
    image_xscale = sign(obj_player.x - x)  
var activeRange = 100  
var inRange = (obj_player.x > (x - activeRange) && obj_player.x < (x + activeRange) && obj_player.y > (y - activeRange) && obj_player.y < (y + activeRange))  
if (global.panic && (!donepanic))  
    instance_destroy()  
text_xscale = (obj_screensizer.actual_width - 64) / sprite_get_width(spr_tutorialbubble)  
wave_timer += 20  
if (text_xscale != text_oldxscale)  
    event_perform(ev_other, ev_room_start)  
if showgranny  
{  
    if (voicecooldown > 1)  
        voicecooldown--  
    else if (!inRange)  
        voicecooldown = 0  
    if inRange  
    {  
        if (ds_list_find_index(global.saveroom, id) == -1)  
        {  
            ds_list_add(global.saveroom, id)  
            notification_push((73 << 0), [lang_name])  
        }  
        sprite_index = spr_chat  
        if (voicecooldown == 0)  
        {  
            fmod_event_one_shot_3d("event:/sfx/voice/pizzagranny", x, y)  
            voicecooldown = 100  
        }  
    }  
    else  
        sprite_index = spr_idle  
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
    case (18 << 0):  
        repeat (_hide + 1)  
            text_y = Approach(text_y, (-((text_sprite_height * text_yscale))), 5)  
        if (obj_player1.state != (290 << 0) && inRange && (!_hide))  
        {  
            text = arr_text[diagindex]  
            diagindex++  
            if (diagindex > (array_length(arr_text) - 1))  
                diagindex = 0  
            event_perform(ev_other, ev_room_start)  
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
        if ((!inRange) || _hide)  
            text_state = (18 << 0)  
        break  
}  
// This shit kinda broken, better look at it when rebuilding
text_wave_x = gml_Script_Wave(-5, 5, 2, 10, wave_timer)  
text_wave_y = gml_Script_Wave(-1, 1, 4, 0, wave_timer)
~~~
## Roomstart
This is used as a pseudo function to reset the dialogs
~~~js
if (skin == 1)  
{  
    spr_idle = spr_chaos_idle  
    spr_chat = spr_chaos_chat  
}  
else if (skin == 2)  
{  
    spr_idle = spr_chaos_rudei  
    spr_chat = spr_chaos_rudec  
}  
else  
{  
    spr_idle = spr_chaos_cutei  
    spr_chat = spr_chaos_cutec  
}
if (!instance_exists(self))  
    return;  
if is_undefined(text)  
{  
    instance_destroy()  
    return;  
}  
var r = string_letters(room_get_name(room))  
if (global.panic && r != "towertutorial" && r != "towertutorialN")  
{  
    instance_destroy()  
    return;  
}  
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
if change_y  
    text_y = (-((text_yscale * text_sprite_height)))  
else  
    change_y = 1  
text_oldxscale = text_xscale  
draw_set_font(font)  
text_arr = scr_compile_icon_text(text)
~~~
## Draw
For later
~~~js
draw_self()
~~~