// Somewhat useless
if (playerid.brick || playerid.state == states.ratmountbounce || playerid.state == states.punch || (state == states.tumble && sprite_index == spr_wm_pounce_slide))  
{  
    poof = 0  
    brick = 1  
    instance_destroy()  
}