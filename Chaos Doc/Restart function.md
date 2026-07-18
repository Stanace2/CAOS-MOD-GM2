Custom function implemented to restart core variables (Couldn't place this on scr_playerrestart, it wasn't decompilable)
***
## gml_Script_scr_chaos_restart

~~~js
function scr_chaos_restart()
{
    instance_destroy(obj_chaoschaser)
    instance_destroy(obj_chaosUI)
    instance_destroy(obj_chaosangel)
    instance_destroy(obj_fakedonisha)
    instance_destroy(obj_wethamtornado)
    global.friendShip = 0
    global.ktoppingoal = 0
    scr_settoppingoal()
    with (obj_player)
    {
        tornadospeed = -16
        jawsbuffer = 0
        mangocall = 0
        clingboost = 0
        quickroll = 0
        wallclimbbuffer = 0
        flash = 0
        mach5 = 0
        mach5buffer = 0
        machengineprev = -1
        canrollsnd = 0
        snapjumps = 0
        ratpoison = 0
        infijump = 0
        flamedash = 0
        flamedashbuffer = 0
        dragonsnap = 0
        ninjablock = 1
        ballspeed = 14
        hoverspin = 5
        slashstored = 1
        wrollbuffer = 0
        callstored = 0
        brickcallbuffer = 0
        clingexitspeed = 0
        allowkpulse = 1
        ballvertical = 0
        bombdivesmash = 0
        jawsfriction = 0
        wallstick = 0
        wmlongjumpbuffer = 0
        fakeceilingrun = 0
        ceilinded = 0
        switch characterID
        {
            case 1:
                brick = 1
                brickskinbuffer = 1
                wethamcombo = [0, 0, 0, 0]
                katanatype = 0
                katanatypebuffer = katanatype
                break
        }

        scr_character_spr_init()
    }
    // This block saves the goth kills
    // Tells cigartracker to check for shadow palette and hellish
    // Deactivates boss trigger
    if instance_exists(obj_cigartracker)
    {
        with (obj_cigartracker)
        {
            alarm[0] = 5
            shadow_chk = 1
            hellish_chk = 1
            boss_trigger = 0
        }
    }
    with (obj_player1)
    {
        if (!ispeppino)
        {
            global.mach_color1 = make_colour_rgb(96, 208, 72)
            global.mach_color2 = make_colour_rgb(248, 0, 0)
        }
        else
        {
            global.mach_color1 = make_colour_rgb(37, 255, 227)
            global.mach_color2 = make_colour_rgb(255, 108, 251)
        }
    }
    if global.chaosexception
    {
        global.caoschase = 1
        global.chaosexception = 0
    }
}
~~~

