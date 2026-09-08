if ((!instance_exists(obj_player1)) || (!instance_exists(obj_mango_brickball)))  
{  
    instance_destroy()  
    return;  
}  
var _recover = 650  
current = point_distance(obj_player1.x, obj_player1.y, obj_mango_brickball.x, obj_mango_brickball.y)  
if (current >= (obj_mango_brickball.recover_distance - _recover) && current < obj_mango_brickball.recover_distance && (!lost_him))  
    losing_him = true  
else  
    losing_him = false  
if (current > obj_mango_brickball.recover_distance)  
    lost_him = true  
if (current < (obj_mango_brickball.recover_distance - _recover))  
    lost_him = false  
if (losing_him && alarm[0] == -1)  
    alarm[0] = 5  
if (alarm[0] > -1)  
    image_alpha = Approach(image_alpha, 0, 0.1)  
else  
    image_alpha = ini_alpha  
hand_image_speed += 0.35