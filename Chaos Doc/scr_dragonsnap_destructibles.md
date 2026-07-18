This script reads all the objects on screen that are affected by the dragonsnap dash for displaying it on the GUI
Referenced in:
- [[Level garnish#Managers#BlinkSnap#Objects#obj_dragonsnap_effect]]
## scr_layout_init()

~~~js
function scr_layout_init() //gml_Script_scr_layout_init  
{  
    todisplay = []  
    layouts = [obj_baddie, obj_destructibles, obj_metalblock, obj_asteroid, obj_pizzaboxunopen, obj_collect, obj_bigcollect, obj_giantcollect, obj_secretbigblock]  
    with (obj_chaosangel)  
    {  
        if (sprite_index == spr_ratkillsign)  
            array_push(other.layouts, obj_ratblock)  
    }  
    for (var j = 0; j < array_length(layouts); j++)  
    {  
        for (var i = 0; i <= instance_number(layouts[j]); i++)  
        {  
            with (instance_find(layouts[j], i))  
            {  
                if (image_alpha == 1 && visible)  
                    array_push(other.todisplay, [sprite_index, image_index, image_xscale, (x - camera_get_view_x(view_camera[0])), (y - camera_get_view_y(view_camera[0]))])  
            }  
        }  
    }  
}
~~~