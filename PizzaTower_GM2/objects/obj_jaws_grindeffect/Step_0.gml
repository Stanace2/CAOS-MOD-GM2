if (obj_player.state == states.tumble)  
    x = obj_player.x + 40 * obj_player.xscale * -1  
else  
    x = obj_player.x + 20 * obj_player.xscale * -1  
y = obj_player.y  
image_xscale = obj_player.xscale  
if (obj_player.state != states.punch && obj_player.state != states.tumble)  
    instance_destroy()