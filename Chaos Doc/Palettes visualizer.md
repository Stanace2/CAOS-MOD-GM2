This objects are created and mainly handled by [[Palette dresser code changes#obj_palettedresser]]
## obj_dresseractor
### Create
~~~js
// Palette related variables
palettespr = -4  
paletteindex = -1  
palettetexture = -4  
unlocked = 0  
// Sprite shenanigans
blend = 16777215  
alpha = 0  
depth = 101  
image_speed = 0.35  
amax = 1
// Logic
relx = x  
rely = y  
die = 0  
~~~
### Step
Main logic to move the actors and make the ease out
~~~js
// Ease their movement
x = Approach(x, relx, 25)  
y = Approach(y, rely, 25)  
// When told to DIE
if (!die)  
    alpha = Approach(alpha, amax, 0.1)  
else  
    alpha = Approach(alpha, 0, 0.1)  
if (alpha == 0 && die)  
    instance_destroy()  
// Sees if it's being selected, so it changes it's alpha value
with (obj_palettedresser)  
{  
    var pep = 0  
    if (!ispeppino)  
        pep = 1  
    var actors = actor_array[pep]  
    if ((actors[scolumn][srow][2] == other.paletteindex && array_length(actors[scolumn][srow]) <= 3) || (array_length(actors[scolumn][srow]) > 3 && actors[scolumn][srow][3] == other.palettetexture))  
        other.amax = 1  
    else  
        other.amax = 0.3  
}
~~~
### DrawGUI
Related:
- [[GP - Related drawing methods#obj_dresseractor]]
~~~js
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, palettetexture)  
pal_swap_set(palettespr, paletteindex, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, blend, alpha)  
pattern_reset()  
pal_swap_set(spr_glowpalette, paletteindex, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha)  
if (paletteindex == 28)  
    pattern_reset()  
reset_shader_fix()
~~~
### DrawGUIBegin
~~~js
if unlocked  
    blend = 16777215  
else  
    blend = 0
~~~
## obj_dresserbg
Related sprites:
- spr_dresserbg | *200 200*
- spr_paletteselector | *50 50*
### Create
~~~js
bg_x = 0  
bg_y = 0  
depth = 102  
die = 0  
cursoralpha = 0  
bgalpha = 0  
// Cursor
sprite_index = spr_paletteselector
~~~
### Step
~~~js
// Background drag
bg_x += 1  
bg_y += 1  
// Ease it's destroying
if (!die)  
{  
    bgalpha = Approach(bgalpha, 1, 0.1)  
    cursoralpha = Approach(cursoralpha, 1, 0.1)  
}  
else  
{  
    bgalpha = Approach(bgalpha, 0, 0.1)  
    cursoralpha = Approach(cursoralpha, 0, 0.1)  
}  
if (bgalpha == 0 && die)  
    instance_destroy()
~~~
### DrawGUI
~~~js
// BG
draw_sprite_tiled_ext(spr_dresserbg, 1, bg_x, bg_y, 1, 1, c_white, bgalpha)  
// CURSOR
draw_sprite_ext(sprite_index, image_index, (obj_player1.x - camera_get_view_x(view_camera[0])), (obj_player1.y - camera_get_view_y(view_camera[0])), 1, 1, 0, c_white, cursoralpha)
~~~
