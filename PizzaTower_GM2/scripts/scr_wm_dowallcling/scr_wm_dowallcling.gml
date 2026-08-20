function scr_wm_dowallcling() {  
    wallstick = 0  
    input_buffer_chaos = 0  
    clingexitspeed = movespeed  
    if (state == states.mach3)  
    {  
        if (vsp > -10)  
            vsp = -10  
        if (sprite_index == spr_wm_djump && vsp > 0)  
            vsp = -14  
    }  
    if (state != states.jump)  
    {  
        if (movespeed > 8)  
            vsp = movespeed * 1.2 * -1  
        else  
            vsp -= 8  
        if place_meeting(x, (y + 1), obj_slope)  
            vsp -= 4  
    }  
    movespeed = 0  
    if (brick == 1 && sprite_index != spr_wm_wallclimb)  
    {  
        with (instance_create(x, y, obj_mango_companion))  
            wait = 1  
        brick = 0  
    }  
    state = states.climbwall 
    if (sprite_index != spr_wm_wallclimb)  
        wallclingbuffer = 5  
    kpulsebuffer = 0  
    fakehsp = 0  
}