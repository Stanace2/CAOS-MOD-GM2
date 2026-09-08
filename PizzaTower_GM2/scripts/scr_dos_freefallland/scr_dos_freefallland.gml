function scr_dos_freefallland() //gml_Script_scr_dos_freefallland
{
    move = key_right + key_left
    mach2 = 0
    poundbuffer = 0
    jumpAnim = 1
    dashAnim = 1
    landAnim = 0
    moveAnim = 1
    stopAnim = 1
    crouchslideAnim = 1
    crouchAnim = 0
    machhitAnim = 0
    movespeed = 0
    facehurt = 1
    start_running = 1
    alarm[4] = 14
    vsp = 0
    hsp = 0
    if (sprite_index == spr_poundmach)
    {
        if (move != 0 && floor(image_index) < 3)
            xscale = move
        if (floor(image_index) >= 3)
            hsp = xscale * 3
        if (!grounded)
        {
            hsp = 0
            movespeed = 0
            vsp = 10
            freefallsmash = 13
            sprite_index = spr_machdrill
            state = states.freefall
            return;
        }
    }
    if (ANIMATION_END)
    {
        if (scr_check_superjump())
        {
            sprite_index = spr_superjumpprep
            state = states.Sjumpprep
            hsp = 0
            image_index = 0
            return;
        }
        if (sprite_index == spr_poundmach)
        {
            jumpstop = 1
            if quickroll
                movespeed = 14
            else
                movespeed = 10
            sprite_index = spr_machroll
            flash = 1
            image_index = 0
            if (!key_down)
            {
                vsp = -7
                sprite_index = spr_machsplit
                if quickroll
                {
                    repeat (5)
                        instance_create(x, y, obj_firemouthflame)
                    movespeed = 16
                }
                else
                    movespeed = 12
                with (instance_create(x, y, obj_crazyrunothereffect))
                    image_xscale = other.xscale
                quickroll = 0
                state = states.mach3
                return;
            }
            state = states.tumble
        }
        else
        {
            facehurt = 1
            sprite_index = spr_facehurtup
            image_index = 0
            state = states.normal
            jumpstop = 1
        }
    }
    if quickroll
        image_speed = 0.7
    else
        image_speed = 0.35
}