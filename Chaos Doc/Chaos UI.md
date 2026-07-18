# obj_chaosUI
200 years of game design
Serves as a sort of director for the Caos chase
Hand to hand with [[Caos Chaser]]
Indirectly mentioned by:
- [[obj_exitgate#Create]] To stablish the toppin goal at the start of the level
**Persistent**
Scripts:
- [[scr_ktoppingoal]]
## Create

~~~js
image_speed = 0.35  
sprite_index = spr_ui_chaossuperparry_start  
ragebartop = 0  
barspr = 4764  
barxinfijump = 0  
barxpatience = 0  
barxstun = 0  
barxwm = 0  
barxflamedash = 0  
barxpanic = 0  
rageshakeyx = 0  
rageshakeyy = 0  
toppincut = -75  
gg = 0  
hide = 0  
showflame = 0  
flamealpha = 0  
angelqueue = []
~~~
## Step
#states
Teh bar system needs a revision, so it functions globally with all external agents and effects done to the bar
~~~js
if (!instance_exists(obj_chaoschaser))  
    return;  
if instance_exists(obj_chaosangel)  
{  
}  
else  
    barxinfijump = 0  
if (global.ktoppingoal == obj_chaoschaser.toppins && (!gg) && global.ktoppins && global.ktoppingoal != 0)  
{  
    gg = 1  
    create_transformation_tip("Good to go!!")  
}  
if (toppincut != 0)  
    toppincut = Approach(toppincut, 0, 0.5)  
with (obj_chaoschaser)  
{  
    var goop = (targetplayer.state != (24 << 0) && targetplayer.state != (25 << 0) && targetplayer.state != (26 << 0))  
    if (sprite_index == spr_caos_munch || (patience > 0 && goop) || targetplayer.state == (106 << 0) || targetplayer.state == (147 << 0) || (place_meeting(x, y, targetplayer) && iframes))  
        other.barxpatience = 1  
    else  
        other.barxpatience = 0  
    if global.panic  
        other.barxpanic = 1  
    else  
        other.barxpanic = 0  
    var transfo = (targetplayer.state == (47 << 0) || targetplayer.state == (38 << 0) || targetplayer.state == (49 << 0) || targetplayer.state == (113 << 0) || targetplayer.state == (114 << 0) || targetplayer.state == (115 << 0) || targetplayer.state == (116 << 0) || targetplayer.state == (33 << 0) || targetplayer.state == (34 << 0) || targetplayer.state == (35 << 0))  
    if (targetplayer.isgustavo || hasmort || global.noisejetpack || transfo)  
        other.barxwm = 1  
    else  
        other.barxwm = 0  
    if (((state == (3 << 0) || (state == (8 << 0) && sprite_index == spr_caos_high2) || targetplayer.state == (150 << 0)) && (!other.barxwm)) || supertaunted)  
        other.barxstun = 1  
    else  
        other.barxstun = 0  
    if (targetplayer.flamedash && targetplayer.flamedashkick < 14 && targetplayer.state == (265 << 0))  
        other.barxflamedash = 1  
    else  
        other.barxflamedash = 0  
    if (targetplayer.flameheat > 175)  
        other.showflame = 1  
}  
if (obj_chaoschaser.targetplayer.supercharged && sprite_index == spr_ui_chaossuperparry_off)  
{  
    sprite_index = spr_ui_chaossuperparry_on  
    image_index = 0  
}  
if ((!obj_chaoschaser.targetplayer.supercharged) && (sprite_index == spr_ui_chaossuperparry_start || sprite_index == spr_ui_chaossuperparry_chargeloop))  
{  
    sprite_index = spr_ui_chaossuperparry_off  
    image_index = 0  
}  
if (floor(image_index) == (image_number - 1))  
{  
    if (sprite_index == spr_ui_chaossuperparry_start)  
        sprite_index = spr_ui_chaossuperparry_chargeloop  
    if (sprite_index == spr_ui_chaossuperparry_on)  
        sprite_index = spr_ui_chaossuperparry_start  
    if (sprite_index == spr_ui_chaossuperparry_off)  
        image_index = image_number - 1  
}  
if hide  
    return;  
var _infijump = 0  
var _patience = 0  
var _wm = 0  
var _flamedash = 0  
var _panic = 0  
if barxpatience  
    _patience = 0.66  
if barxinfijump  
    _infijump = 0.03  
if barxflamedash  
    _flamedash = 0.45  
if barxpanic  
    _panic = 0.05  
var multipliers = _infijump + _patience + _flamedash + _panic  
if (barxstun && ragebartop > 1)  
    ragebartop -= 0.3  
else  
    ragebartop = Approach(ragebartop, 155, (0.075 + multipliers))  
if (ragebartop > 154 && barspr != spr_ui_chaosragebar_full)  
{  
    with (obj_chaoschaser)  
    {  
        if (state == (6 << 0))  
            scr_chaosvomit()  
        berserk = 1  
        state = (0 << 0)  
        sprite_index = spr_caos_berserk  
    }  
    barspr = spr_ui_chaosragebar_full  
}
if (ragebartop > 154 || barxpatience)  
{  
    rageshakeyx = random_range(-5, 5)  
    rageshakeyy = random_range(-5, 5)  
}  
else  
{  
    rageshakeyx = 0  
    rageshakeyy = 0  
    if (barxflamedash || barxpanic)  
    {  
        rageshakeyx = random_range(-1, 1)  
        rageshakeyy = random_range(-1, 1)  
    }  
}
~~~
## EndStep
Angel pos director
~~~js
for (var i = 0; i < array_length(angelqueue); i++)  
{  
    switch i  
    {  
        case 1:  
            angelqueue[i].posxoffset = 0  
            angelqueue[i].posyoffset = 100  
            break  
        case 2:  
            angelqueue[i].posxoffset = 100  
            angelqueue[i].posyoffset = 0  
            break  
        case 3:  
            angelqueue[i].posxoffset = 100  
            angelqueue[i].posyoffset = 100  
            break  
    }  
  
}
~~~
## RoomStart

~~~js
ragebartop = 0  
barspr = spr_ui_chaosragebar  
rageshakeyx = 0  
rageshakeyy = 0  
showflame = 0  
flamealpha = 0
~~~
## Draw
==(Should place this on the drawing method in player)==
~~~js
// Draws the flame guy above the player
if (!instance_exists(obj_chaoschaser))  
    return;  
with (obj_chaoschaser)  
{  
    if (targetplayer != noone)  
    {  
        if (targetplayer.flamedash && other.showflame)  
        {  
            if (other.flamealpha < 1)  
                other.flamealpha += 0.05  
            var _spr = spr_pw_flame  
            var spr_w = sprite_get_width(_spr)  
            var spr_h = sprite_get_height(_spr)  
            var ox = sprite_get_xoffset(_spr)  
            var oy = sprite_get_yoffset(_spr)  
            var t = targetplayer.flameheat / 250  
            var _img = 0  
            if (targetplayer.state == (9 << 0))  
            {  
                t = 1  
                _img = 1  
            }  
            var upoffset = 90  
            var shakey = random_range((-5 * t), (5 * t))  
            var shakex = random_range((-5 * t), (5 * t))  
            draw_sprite_ext(_spr, _img, (targetplayer.x + shakex), (targetplayer.y - upoffset + shakey), 1, 1, 0, c_black, other.flamealpha)  
            draw_sprite_part_ext(_spr, _img, 0, (spr_h * (1 - t)), spr_w, (spr_h * t), (targetplayer.x + shakex - ox), (targetplayer.y + shakey - oy - upoffset + spr_h * (1 - t)), 1, 1, c_white, other.flamealpha)  
        }  
    }  
}
~~~
## DrawGUI
Main dish
~~~js
if instance_exists(obj_dragonsnap_effect)  
    return;  
if (!instance_exists(obj_chaoschaser))  
    return;  
if hide  
    return;  
// Bar position
var bary = obj_screensizer.actual_height - 220 + rageshakeyy  
var barx = 20 + rageshakeyx  
// Toppin markers
if (global.ktoppins && (!global.panic) && global.ktoppingoal != 0)  
{  
    var toppinc = barx + 100 + toppincut  
    var toppinr = bary - 25  
    draw_sprite_ext(spr_ui_chaostoppinmarkers_shroom, (!instance_exists(obj_pizzakinshroom)), toppinc, toppinr, 1, 1, 0, c_white, 1)  
    if (global.ktoppingoal >= 2)  
        draw_sprite_ext(spr_ui_chaostoppinmarkers_cheese, (!instance_exists(obj_pizzakincheese)), toppinc, (toppinr + 50), 1, 1, 0, c_white, 1)  
    if (global.ktoppingoal >= 3)  
        draw_sprite_ext(spr_ui_chaostoppinmarkers_tomato, (!instance_exists(obj_pizzakintomato)), toppinc, (toppinr + 100), 1, 1, 0, c_white, 1)  
    if (global.ktoppingoal >= 4)  
        draw_sprite_ext(spr_ui_chaostoppinmarkers_sausage, (!instance_exists(obj_pizzakinsausage)), toppinc, (toppinr + 150), 1, 1, 0, c_white, 1)  
    if (global.ktoppingoal == 5)  
        draw_sprite_ext(spr_ui_chaostoppinmarkers_pineapple, (!instance_exists(obj_pizzakinpineapple)), toppinc, (toppinr + 200), 1, 1, 0, c_white, 1)  
}  
// Flamedash heat
if (obj_chaoschaser.targetplayer != noone)  
{  
    if obj_chaoschaser.targetplayer.flamedash  
    {  
        shader_set(shd_color_afterimage)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "red"), 1)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "green"), 0.5333333333333333)  
        shader_set_uniform_f(shader_get_uniform(shd_color_afterimage, "blue"), 0)  
        var spr_w = sprite_get_width(barspr)  
        var spr_h = sprite_get_height(barspr)  
        var t = obj_chaoschaser.targetplayer.flameheat / 350  
        if (obj_chaoschaser.targetplayer.state == (9 << 0))  
            t = 1  
        draw_sprite_part_ext(barspr, 0, 0, (spr_h * (1 - t)), spr_w, (spr_h * t), barx, (bary + spr_h * (1 - t)), 1, 1, c_white, 1)  
        reset_shader_fix()  
    }  
}  
// Superparry indicator
var _sprparry = sprite_index  
if (ragebartop > 154)  
    _sprparry = spr_ui_chaossuperparry_rage  
draw_sprite_ext(_sprparry, image_index, (-15 + rageshakeyx), (obj_screensizer.actual_height / 2 - 80 + rageshakeyy), 1, 1, 0, c_white, 1)  
// Bar cover and fill
draw_set_colour(0x2B2C34)  
draw_rectangle((barx + 32), (bary + 37), (barx + 49), (bary + 193), 0)  
if (ragebartop > 154)  
    draw_set_colour(c_fuchsia)  
else if barxstun  
    draw_set_colour(make_colour_rgb(23, 231, 127))  
else if barxpatience  
    draw_set_colour(c_red)  
else if barxflamedash  
    draw_set_colour(make_colour_rgb(255, 131, 0))  
else if barxpanic  
    draw_set_colour(make_colour_rgb(239, 94, 255))  
else if barxwm  
    draw_set_colour(make_colour_rgb(104, 149, 197))  
else if barxinfijump  
    draw_set_colour(c_yellow)  
else  
    draw_set_colour(c_white)  
draw_rectangle((barx + 32), (bary + 193 - ragebartop), (barx + 49), (bary + 194), 0)  
draw_sprite_ext(barspr, 0, barx, bary, 1, 1, 0, c_white, 1)
~~~
# obj_chaostracker
Get a warn, im getting close to your position, mwehehe
Main controllers and all, are managed by [[Caos Chaser]]
**Parent : obj_objecticontracker**
## DrawGUI

~~~js
draw_sprite_ext(sprite_index, image_index, (x - camera_get_view_x(view_camera[0])), (y - camera_get_view_y(view_camera[0]) + yoffset), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
~~~