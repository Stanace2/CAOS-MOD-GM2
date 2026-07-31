function scr_dos_mach3() //gml_Script_scr_dos_mach3
{
    if (!scr_doniMoveset())
        return;
    if (sprite_index == spr_fightball)
    {
        scr_player_fightball()
        return;
    }
    switch character
    {
        case "P":
            var slopeaccel = 0.1
            var slopedeccel = 0.2
            var speedcap = 30
            var mach4movespeed = 21
            var mach3movespeed = 16
            var accel = 0.03
            var capaccel = 0.01
            var mach4accel = 0.0001
            var jumpspeed = -11
            var machrollspeed = 10
            var mach3_spr = spr_mach4
            if (global.swapmode && key_attack && key_fightball && (!instance_exists(obj_swapmodegrab)) && (!instance_exists(obj_swapdeatheffect)) && (!instance_exists(obj_noiseanimatroniceffect)) && obj_swapmodefollow.animatronic <= 0)
            {
                sprite_index = spr_fightball
                jump_p2 = 0
                if noisecrusher
                    instance_create_unique(x, y, 158)
                return;
            }
            if (windingAnim < 2000)
                windingAnim++
            if place_meeting(x, (y + 1), obj_railparent)
            {
                var _railinst = instance_place(x, (y + 1), obj_railparent)
                railmovespeed = _railinst.movespeed
                raildir = _railinst.dir
            }
            hsp = xscale * movespeed + railmovespeed * raildir
            if grounded
            {
                if (scr_slope() && hsp != 0 && movespeed > 10 && movespeed < 18)
                    scr_player_addslopemomentum(slopeaccel, slopedeccel)
            }
            if (move == xscale && grounded)
            {
                if (movespeed < 16)
                    movespeed += accel
                else if (movespeed < 20)
                    movespeed += mach4accel
            }
            if ((!key_jump2) && jumpstop == 0 && vsp < 0.5)
            {
                vsp /= 20
                jumpstop = 1
            }
            if (grounded && sprite_index == spr_playerN_skateboarddoublejump)
            {
                sprite_index = mach3_spr
                fmod_event_one_shot_3d("event:/sfx/playerN/wallbounceland", x, y)
            }
            mach2 = 100
            momemtum = 1
            move = key_right + key_left
            move2 = key_right2 + key_left2
            if (fightball == 1 && global.coop == 1)
            {
                if (object_index == obj_player1)
                {
                    x = obj_player2.x
                    y = obj_player2.y
                }
                if (object_index == obj_player2)
                {
                    x = obj_player1.x
                    y = obj_player1.y
                }
            }
            if (sprite_index == spr_crazyrun)
            {
                if (flamecloud_buffer > 0)
                    flamecloud_buffer--
                else
                {
                    flamecloud_buffer = 10
                    with (instance_create(x, y, obj_dashcloud))
                    {
                        image_xscale = other.xscale
                        sprite_index = spr_flamecloud
                    }
                }
            }
            if (sprite_index == spr_dos_unhingedrun)
            {
                if (flamecloud_buffer > 0)
                    flamecloud_buffer--
                else
                {
                    flamecloud_buffer = 5
                    with (instance_create(x, y, obj_dashcloud))
                    {
                        image_xscale = other.xscale
                        sprite_index = spr_flamecloud
                    }
                }
            }
            crouchslideAnim = 1
            if (floor(image_index) == (image_number - 1) && sprite_index == spr_machsplit)
                sprite_index = spr_machsplit_loop
            if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerN_skateboarddoublejump)
                image_index = image_number - 3
            if (sprite_index == spr_playerN_skateboarddoublejump && grounded && vsp > 0)
                sprite_index = mach3_spr
            if (grounded && vsp > 0)
                jumpstop = 0
            if (input_buffer_jump > 0 && sprite_index != spr_mach3jump && can_jump && (!((move == 1 && xscale == -1))) && (!((move == -1 && xscale == 1))))
            {
                input_buffer_jump = 0
                scr_fmod_soundeffect(jumpsnd, x, y)
                particle_set_scale(states.tumble, xscale, 1)
                create_particle(x, y, states.tumble, 0)
                if (sprite_index != spr_fightball && sprite_index != spr_crazyrun && sprite_index != spr_dos_unhingedrun)
                {
                    image_index = 0
                    sprite_index = spr_mach3jump
                }
                if (sprite_index == spr_crazyrun && ispeppino)
                {
                    mach4mode = 1
                    image_index = 0
                    sprite_index = spr_rolljump
                }
                if (character == "P")
                    vsp = jumpspeed
                else
                    vsp = -13
            }
            if (input_buffer_jump > 0 && (!can_jump) && key_up && (!ispeppino) && character == "P" && noisedoublejump)
                scr_player_do_noisecrusher()
            if (fightball == 0)
            {
                if (mach4mode && (!grounded) && sprite_index != spr_dos_unhingedrun && sprite_index != spr_spinkf && sprite_index != spr_machsplit_loop && sprite_index != spr_machsplit && ispeppino)
                    sprite_index = spr_rolljump
                if (sprite_index == spr_mach3jump && floor(image_index) == (image_number - 1))
                    sprite_index = mach3_spr
                if (sprite_index == spr_superjumpcancel && grounded)
                    sprite_index = mach3_spr
                if ((sprite_index == spr_machsplit_loop || sprite_index == spr_spinkf) && grounded)
                {
                    flash = 1
                    sprite_index = spr_rollgetup
                    image_index = 0
                }
				// ALT ANIM
                if (floor(image_index) == (image_number - 1) && (/*sprite_index == spr_player_rollgetupALT || */sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach))
                    sprite_index = mach3_spr
                if (sprite_index == spr_rolljump && grounded && vsp > 0 && movespeed <= mach3movespeed)
                {
                    flash = 1
                    sprite_index = mach3_spr
                }
                if (sprite_index == spr_playerN_sidewayspin && floor(image_index) == (image_number - 1))
                    sprite_index = spr_playerN_sidewayspinend
                if (grounded && (sprite_index == spr_playerN_sidewayspin || sprite_index == spr_playerN_sidewayspinend))
                    sprite_index = mach3_spr
                if ((movespeed > mach3movespeed && sprite_index != spr_dos_unhingedrun && sprite_index != spr_crazyrun && sprite_index != spr_superjumpcancel_start && sprite_index != spr_spinkf && sprite_index != spr_machsplit_loop && sprite_index != spr_machsplit && sprite_index != spr_taunt && sprite_index != spr_rolljump) || (sprite_index == spr_rolljump && grounded && movespeed >= mach3movespeed))
                {
                    mach4mode = 1
                    flash = 1
                    sprite_index = spr_crazyrun
                }
                else if (movespeed <= mach3movespeed && (sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun))
                    sprite_index = mach3_spr
                if (movespeed >= mach4movespeed && grounded && sprite_index != spr_dos_unhingedrun)
                {
                    if (!mach5)
                    {
                        mach5 = 1
                        if (!mach5buffer)
                            fmod_event_one_shot("event:/chaos-sfx/donisha/mach5Horn")
                        mach5buffer = 1
                    }
                    sprite_index = spr_dos_unhingedrun
                    flash = 1
                }
            }
            if ((sprite_index == spr_crazyrun || sprite_index == spr_dos_unhingedrun) && (!instance_exists(crazyruneffectid)))
            {
                with (instance_create(x, y, obj_crazyrunothereffect))
                {
                    playerid = other.object_index
                    other.crazyruneffectid = id
                }
            }
            if (sprite_index == mach3_spr || sprite_index == spr_fightball)
                image_speed = 0.4
            else if (sprite_index == spr_dos_unhingedrun)
                image_speed = 0.4
            else if (sprite_index == spr_crazyrun)
                image_speed = 0.75
			// ALT
            else if (/*sprite_index == spr_player_rollgetupALT || */sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach)
                image_speed = 0.4
            if (((!key_attack) && fightball == 0 && (!launched) && sprite_index != spr_dashpadmach && grounded && vsp > 0 && (character == "P" || character == "N")) || (character == "S" && (move == 0 || move != xscale) && grounded && fightball == 0))
            {
                sprite_index = spr_machslidestart
                if ispeppino
                    fmod_event_one_shot_3d("event:/sfx/pep/break", x, y)
                else
                    fmod_event_one_shot_3d("event:/sfx/playerN/break", x, y)
                state =states.machslide
                image_index = 0
                launched = 0
            }
            if (move == (-xscale) && grounded && vsp > 0 && (!launched) && (character == "P" || character == "N") && fightball == 0 && sprite_index != spr_dashpadmach)
            {
                if ispeppino
                    fmod_event_one_shot_3d("event:/sfx/pep/machslideboost", x, y)
                else
                    fmod_event_one_shot_3d("event:/sfx/playerN/machslide", x, y)
                sprite_index = spr_mach3boost
                state =states.machslide
                image_index = 0
            }
            if (fightball == 0 && (sprite_index != spr_dashpadmach || dropboost))
            {
                if doSnapjump()
                    return;
            }
            if (scr_mach_check_dive() && fightball == 0 && sprite_index != spr_spinkf && sprite_index != spr_machsplit && sprite_index != spr_machsplit_loop && (sprite_index != spr_dashpadmach || dropboost))
            {
                particle_set_scale(states.tumble, xscale, 1)
                create_particle(x, y, states.tumble, 0)
                flash = 0
                state = states.tumble
                image_index = 0
                vsp = machrollspeed
                if ((!grounded) && ispeppino)
                    sprite_index = spr_rolljump
                else
                    sprite_index = spr_machroll
                if (character == "V")
                    sprite_index = spr_playerV_divekickstart
            }
            if (grounded && sprite_index == spr_dos_unhingedrun && place_meeting((x + sign(hsp)), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))) && (!(place_meeting((x + hsp), y, obj_mach3solid))))
            {
                var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)
                var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)
                if ((gap == -4 || dx != -4) && sprite_index == spr_dos_unhingedrun)
                {
                    mask_index = spr_crouchmask
                    state = states.tumble
                    sprite_index = spr_machroll
                    image_index = 0
                    fmod_event_instance_play(snd_dive)
                    return;
                }
                var _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40)
                if _climb
                {
                    wallspeed = movespeed
                    grabclimbbuffer = 0
                    state = states.climbwall
                    sprite_index = spr_dos_walllaunch
                    image_index = 0
                    image_speed = 0.35
                }
                instance_create(x, y, obj_noiseeffect)
                fmod_event_one_shot_3d("event:/sfx/misc/superspring", x, y)
                return;
            }
            if (((!grounded) && (place_meeting((x + hsp), y, obj_solid) || scr_solid_slope((x + hsp), y)) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock)))) || (grounded && (place_meeting((x + sign(hsp)), (y - 16), obj_solid) || scr_solid_slope((x + sign(hsp)), (y - 16))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))) && (!(place_meeting((x + hsp), y, obj_metalblock))) && place_meeting(x, (y + 1), obj_slope)))
            {
                _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40, (abs(hsp) + 1))
                if _climb
                {
                    wallspeed = movespeed
                    grabclimbbuffer = 0
                    if (movespeed < 1)
                        wallspeed = 1
                    else
                        movespeed = wallspeed
                    state = states.climbwall
                }
            }
            if ((!grounded) && place_meeting((x + sign(hsp)), y, obj_climbablewall) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))))
            {
                _climb = 1
                if (!ispeppino)
                    _climb = ledge_bump(40)
                if _climb
                {
                    wallspeed = movespeed
                    grabclimbbuffer = 0
                    state = states.climbwall
                }
            }
            if (input_buffer_slap > 0 && (!key_up) && shotgunAnim == 0 && (!global.pistol) && sprite_index != spr_dashpadmach)
            {
                input_buffer_slap = 0
                sprite_index = spr_suplexdash
                suplexmove = 1
                fmod_event_instance_play(suplexdashsnd)
                particle_set_scale(states.tumble, xscale, 1)
                create_particle(x, y, states.tumble, 0)
                state = states.handstandjump
                if (movespeed < 5)
                    movespeed = 5
                image_index = 0
            }
            else if (input_buffer_slap > 0 && key_up && shotgunAnim == 0 && sprite_index != spr_dashpadmach && ((!global.pistol) || (!ispeppino)))
            {
                input_buffer_slap = 0
                state = states.punch
                image_index = 0
                sprite_index = spr_breakdanceuppercut
                fmod_event_instance_play(snd_uppercut)
                if ispeppino
                    vsp = -10
                else
                    vsp = -21
                movespeed = hsp
                particle_set_scale(states.grabbed, xscale, 1)
                create_particle(x, y, states.grabbed, 0)
                if (!ispeppino)
                {
                    repeat (4)
                    {
                        with (instance_create((x + (irandom_range(-40, 40))), (y + (irandom_range(-40, 40))), obj_explosioneffect))
                        {
                            sprite_index = spr_shineeffect
                            image_speed = 0.35
                        }
                    }
                }
            }
            if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach && sprite_index != spr_machsplit)
            {
                if shotgunAnim
                    scr_shotgunshoot()
                else if global.pistol
                    scr_pistolshoot(states.mach3)
            }
            if (scr_solid((x + sign(hsp)), y) && (!(place_meeting((x + sign(hsp)), y, obj_mach3solid))) && (!scr_slope()) && (scr_solid_slope((x + sign(hsp)), y) || place_meeting((x + sign(hsp)), y, obj_solid)) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_climbablewall))) && grounded)
            {
                var _bump = 1
                if (ispeppino || noisemachcancelbuffer <= 0)
                    _bump = ledge_bump((vsp >= 0 ? 32 : 22))
                if _bump
                {
                    with (obj_camera)
                    {
                        shake_mag = 20
                        shake_mag_acc = 40 / room_speed
                    }
                    with (obj_baddie)
                    {
                        if (shakestun && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0)
                        {
                            stun = 1
                            alarm[0] = 200
                            ministun = 0
                            vsp = -5
                            hsp = 0
                        }
                    }
                    if (!fightball)
                    {
                        sprite_index = spr_hitwall
                        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                        fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)
                        hsp = 0
                        flash = 0
                        state = states.bump
                        hsp = -6 * xscale
                        vsp = -6
                        mach2 = 0
                        image_index = 0
                        instance_create((x + xscale * 15), (y + 10), obj_bumpeffect)
                    }
                    else
                    {
                        fightball = 0
                        with (obj_player)
                        {
                            sprite_index = spr_hitwall
                            instance_create((x + 10), (y + 10), obj_bumpeffect)
                            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)
                            fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)
                            hsp = 0
                            flash = 0
                            state = states.bump
                            hsp = -6 * xscale
                            vsp = -6
                            mach2 = 0
                            image_index = 0
                        }
                    }
                }
            }
            break
    }

    var b = 0
    with (obj_hamkuff)
    {
        if (state == states.blockstance && playerid == other.id)
            b = 1
    }
    if ((!instance_exists(dashcloudid)) && grounded && (!(place_meeting(x, (y + 1), obj_water))) && (!b))
    {
        with (instance_create(x, y, obj_superdashcloud))
        {
            if (other.fightball == 1)
                instance_create(obj_player.x, obj_player.y, obj_slapstar)
            image_xscale = other.xscale
            other.dashcloudid = id
        }
    }
    if ((!instance_exists(dashcloudid)) && grounded && place_meeting(x, (y + 1), obj_water) && (!b))
    {
        with (instance_create(x, y, obj_superdashcloud))
        {
            if (other.fightball == 1)
                instance_create(obj_player.x, obj_player.y, obj_slapstar)
            image_xscale = other.xscale
            sprite_index = spr_watereffect
            other.dashcloudid = id
        }
    }
    scr_dotaunt()
    if (!instance_exists(chargeeffectid))
    {
        with (instance_create(x, y, obj_chargeeffect))
        {
            playerid = other.object_index
            other.chargeeffectid = id
        }
    }
    if (sprite_index == mach3_spr || sprite_index == spr_fightball)
        image_speed = 0.4
    else if (sprite_index == spr_dos_unhingedrun)
        image_speed = 0.4
    else if (sprite_index == spr_crazyrun)
        image_speed = 0.75
    else if (sprite_index == spr_machsplit_loop)
        image_speed = 0.8
	// ALT GETUP
    else if (/*sprite_index == spr_player_rollgetupALT || */sprite_index == spr_rollgetup || sprite_index == spr_mach3hit)
        image_speed = 0.4
    else if (sprite_index == spr_rolljump && movespeed >= mach3movespeed)
        image_speed = 0.8
    else if (sprite_index == spr_rolljump && movespeed < mach3movespeed)
        image_speed = 0.6
    else if (sprite_index == spr_machsplit || sprite_index == spr_spinkf)
        image_speed = 0.35
    else
        image_speed = 0.4
    if (scr_check_superjump() && fightball == 0 && state == states.mach3 && grounded && vsp > 0 && sprite_index != spr_dashpadmach && (!(place_meeting(x, y, obj_dashpad))))
    {
        sprite_index = spr_superjumpprep
        state = states.Sjumpprep
        hsp = 0
        image_index = 0
    }
    if (global.attackstyle == 2 && key_slap2)
    {
        randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, 801, 800, 797, spr_punch])
        image_index = 0
        state = states.lungeattack
    }
    if (movespeed > speedcap)
        movespeed = speedcap
	if ds_list_empty(global.afterimage_list) {
		with (create_mach3effect(x, y, sprite_index, image_index - 1, true))
		{
			playerid = other.object_index;
			image_xscale = other.xscale;
		}
	}
}