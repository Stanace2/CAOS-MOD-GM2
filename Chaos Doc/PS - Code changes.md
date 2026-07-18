## obj_pizzasonacollect
Changes to the already existing object Pizzasona
### Create 
Mainly changes to avoid not changed pizzasonas
~~~js
idlespr = 4479  
throwspr = 1083  
transitionspr = 4095  
collectID = -4  
onebyoneID = -4  
index = 0  
showtext = 0  
state = (0 << 0)  
image_speed = 0.35  
depth = 0  
var r = -1  
var alt = ""  
while 1  
{  
    r = irandom_range(1, 55)  
    if (r == 8)  
        continue  
    else if (r == 1 || r == 2 || r == 3 || r == 19 || r == 21 || r == 33 || r == 41 || r == 39 || r == 55 || r == 34 || r == 13 || r == 45 || r == 28 || r == 5 || r == 9 || r == 20 || r == 38 || r == 51)  
        break  
    else  
        continue  
}  
if (r == 51)  
    alt = concat("_", irandom_range(1, 4))  
idlespr = asset_get_index(concat("spr_pizzasona", r, alt))  
throwspr = asset_get_index(concat("spr_pizzasona", r, "throw"))  
transitionspr = asset_get_index(concat("spr_pizzasona", r, "trans"))
~~~

### Step
#states
The exit animations got changed
~~~js
index += 0.35  
if (x != obj_player1.x)  
    image_xscale = sign(obj_player1.x - x)  
switch state  
{  
    case (0 << 0):  
        sprite_index = idlespr  
        if (!instance_exists(collectID))  
        {  
            state = (74 << 0)  
            sprite_index = throwspr  
            image_index = 0  
            showtext = 1  
            alarm[0] = 50  
        }  
        break  
    case (74 << 0):  
        if (floor(image_index) == (image_number - 1))  
        {  
            sprite_index = transitionspr  
            if (onebyoneID == noone)  
            {  
                global.collect -= 150  
                onebyoneID = instance_create(x, (y - 30), obj_pizzasona_points)  
            }  
            else if (!instance_exists(onebyoneID))  
                state = (8 << 0)  
        }  
        break  
    case (8 << 0):  
        if (floor(image_index) == (image_number - 1))  
        {  
            state = (92 << 0)  
            movespeed = 4  
            showtext = 0  
            scr_ghostcollectible(1)  
        }  
        break  
    case (92 << 0):  
        movespeed += 0.25  
        y -= movespeed  
        if (y < -500)  
            instance_destroy()  
        break  
}
~~~

### Draw
Pizzasonas are affected by palette shader ==(Future note: Implement their own palette sprite to prevent errors)==
~~~js
draw_self()  
draw_sprite(spr_chigaco, index, x, (y + 46))  
if showtext  
    draw_sprite(spr_pizzasona_thankyou, index, x, (y - 40))  
shader_set(global.Pal_Shader)  
pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)  
pattern_set(global.Base_Pattern_Color_Shared, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture)  
pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, image_alpha)  
pattern_reset()  
shader_reset()
~~~

## obj_ghostcollectibles
Tiny change done to this guy, to also use the palette shader and change the collision mask
### Create
Adds the new mask
~~~js
collectiblelist = ds_list_create()  
depth = 20  
with (instance_nearest(obj_secretportal.x, obj_secretportal.y, obj_bigcollect))  
{  
    mask_index = spr_monster_mask  
    visible = 0  
    value = 150  
    with (instance_create(x, (y - 42), obj_pizzasonacollect))  
        collectID = other.id  
}
~~~

### Draw
Adds the palette shader
~~~js
draw_set_color(c_white)  
for (var i = 0; i < ds_list_size(collectiblelist); i++)  
{  
    var b = ds_list_find_value(collectiblelist, i)  
    shader_set(global.Pal_Shader)  
    pattern_set(global.Base_Pattern_Color, b.sprite_index, b.image_index, 1, 1, global.palettetexture)  
    pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(b.sprite_index, b.image_index, b.x, b.y, 1, 1, 0, c_white, 0.25)  
    pattern_set(global.Base_Pattern_Color_Shared, b.sprite_index, b.image_index, 1, 1, global.palettetexture)  
    pal_swap_set(spr_sharedpalette, obj_player1.paletteselect, 0)  
    draw_sprite_ext(b.sprite_index, b.image_index, b.x, b.y, 1, 1, 0, c_white, 0.25)  
    pattern_reset()  
    shader_reset()  
    if b.pizzasona  
        draw_sprite_ext(spr_chigaco, b.image_index, b.x, (b.y + 49), 1, 1, 0, c_white, b.image_alpha)  
}
~~~

