if (instance_exists(obj_player1) && instance_exists(obj_mango_brickball) && current != -1)  
{  
    var ispd = hand_image_speed  
    if (current < obj_mango_brickball.recover_distance)  
    {  
        draw_set_color(make_colour_rgb(0, 255, 115))  
        ini_alpha = 0.8  
    }  
    else  
    {  
        draw_set_color(make_colour_rgb(61, 61, 61))  
        ispd = 0  
        ini_alpha = 0.5  
    }  
    draw_sprite_line(spr_lastbreath_indicator, image_index, obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20), true, image_alpha, 180)  
    var _angle = point_direction(obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20))  
    var dis = point_distance(obj_player1.x, (obj_player1.y + 20), obj_mango_brickball.x, (obj_mango_brickball.y + 20))  
    var offset = 160 - sprite_get_width(spr_lastbreath_indicator)  
    if (dis < offset)  
        offset = dis  
    draw_sprite_ext(spr_lastbreath_hand, ispd, (obj_player1.x + (lengthdir_x(offset, _angle))), (obj_player1.y + 20 + (lengthdir_y(offset, _angle))), 1, 1, _angle, draw_get_color(), image_alpha)  
}