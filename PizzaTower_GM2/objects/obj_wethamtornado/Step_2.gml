if (instance_number(object_index) > 1 && state != 1)  
{  
    if (sprite_index != undefined)  
    {  
        for (var i = 0; i < instance_number(object_index); i++)  
        {  
            if (instance_find(object_index, i).sprite_index == sprite_index && instance_find(object_index, i) != id)  
                instance_destroy()  
        }  
    }  
}