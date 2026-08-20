var my_player = obj_player1.id  
if (player_id == 2)  
    my_player = obj_player2.id  
if (my_player.state != states.dynamite || sprite_index != spr_wethamslash || sprite_index != spr_wethamslash2)  
    instance_destroy()  
if (my_player.parrytimer <= 0)  
    instance_destroy()  
image_xscale = my_player.xscale  
x = my_player.x  
y = my_player.y  
var xoff = sprite_get_xoffset(sprite_index)  
var yoff = sprite_get_yoffset(sprite_index)  
if (image_xscale == -1)  
    xoff *= -1  
var _list = ds_list_create()  
var ender = collision_rectangle_list((x + 80 * image_xscale - xoff), (y + 28 - yoff), (x + abs(sprite_width) * image_xscale - xoff), (y + sprite_height - 3 - yoff), 596, 0, 0, _list, 0)  
if (ender > 0)  
{  
    for (var i = 0; i < ender; i++)  
    {  
        if (ds_list_find_value(_list, i).object_index != obj_onewaybigblock)  
        {  
            instance_destroy(ds_list_find_value(_list, i))  
            GamepadSetVibration(0, 0.5, 0.5, 0.8)  
        }  
        else if (ds_list_find_value(_list, i).image_xscale != my_player.xscale)  
        {  
            instance_destroy(ds_list_find_value(_list, i))  
            GamepadSetVibration(0, 0.5, 0.5, 0.8)  
        }  
    }  
}  
ds_list_destroy(_list)