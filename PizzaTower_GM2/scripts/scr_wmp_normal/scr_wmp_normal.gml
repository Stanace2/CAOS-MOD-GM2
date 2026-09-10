function scr_wmp_normal() 
{  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doroll()  
    var maxmovespeed = 8  
    var maxmovespeed2 = 6  
    var accel = 0.5  
    var deccel = 0.1  
    var jumpspeed = -11  
    var machSpeed = 12  
    mach2 = 0  
    move = key_left + key_right  
    skateboarding = 0  
    momemtum = 0  
    jumpstop = 0  
    if key_taunt2  
    {  
        input_finisher_buffer = 60  
        input_attack_buffer = 0  
        input_up_buffer = 0  
        input_down_buffer = 0  
    }  
    var idlespr = spr_idle  
    var movespr = spr_move  
    if (global.leveltosave == "freezer" && (!global.noisejetpack))  
        idlespr = spr_idle  
    if (global.pistol && ispeppino)  
    {  
        idlespr = spr_player_pistolidle  
        movespr = spr_player_pistolwalk  
    }  
    if (room == tower_soundtest && obj_soundtest.play)  
    {  
        if (brick && (!instance_exists(obj_mango_companion)))  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        idlespr = spr_gusdance  
        idle = 0  
    }  
    var breakdance_max = 10  
    if (key_taunt && (!shotgunAnim) && ((!global.pistol) || (!ispeppino)))  
        breakdance_pressed++  
    else  
        breakdance_pressed = 0  
    if (breakdance_pressed >= breakdance_max && (!shotgunAnim))  
    {  
        if (brick && (!instance_exists(obj_mango_companion)))  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        breakdance_speed = Approach(breakdance_speed, 0.6, 0.005)  
        if ((breakdance_pressed - 1) < breakdance_max)  
            notification_push(notifications.breakdance_start, [])  
    }  
    else  
        breakdance_speed = 0.25  
    if (breakdance_speed >= 0.5)  
    {  
        if (!instance_exists(obj_beatbox))  
        {  
            instance_create(x, y, obj_genericpoofeffect)  
            with (instance_create(x, y, obj_beatbox))  
                vsp = -11  
        }  
        notecreate--  
    }  
    if (notecreate <= 0 && (!shotgunAnim))  
    {  
        instance_create((x + (random_range(-70, 70))), (y + (random_range(-70, 70))), obj_notes)  
        notecreate = 10  
    }  
    if place_meeting(x, (y + 1), obj_railparent)  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        railmovespeed = _railinst.movespeed  
        raildir = _railinst.dir  
        railmomentum = 1  
    }  
    if ((!key_attack) || place_meeting((x + xscale), y, obj_solid))  
    {  
        if (move != 0)  
            hsp = Approach(hsp, (move * movespeed + railmovespeed * raildir), 0.5)  
        else  
            hsp = Approach(hsp, (xscale * movespeed + railmovespeed * raildir), 0.5)  
    }  
    else  
    {  
        if (movespeed >= 8 || move == 0)  
            hsp = xscale * movespeed + railmovespeed * raildir  
        else if (move != 0)  
        {  
            xscale = move  
            hsp = move * movespeed + railmovespeed * raildir  
        }  
        if (movespeed < 8)  
            movespeed = Approach(movespeed, 8, 0.5)  
        else  
        {  
            movespeed = Approach(movespeed, machSpeed, 0.09)  
            if (move == (-xscale) && sprite_index != spr_dashpadmach)  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/backslide", x, y)  
                sprite_index = spr_mach3boost  
                state = states.machslide 
                xscale *= -1  
                image_index = 0  
                return;  
            }  
        }  
        sprite_index = spr_mach  
    }  
    if (brick && move != 0 && global.combo < 50)  
        image_speed = movespeed / 12  
    else  
        image_speed = 0.35  
    if ((!key_attack) || place_meeting((x + xscale), y, obj_solid))  
    {  
        if (move != 0)  
        {  
            if (move != 0)  
                xscale = move  
            if (movespeed < maxmovespeed)  
                movespeed = Approach(movespeed, maxmovespeed, accel)  
            else if (floor(movespeed) == maxmovespeed)  
                movespeed = maxmovespeed2  
            if (!(place_meeting((x + xscale), y, obj_solid)))  
            {  
                if ((!machslideAnim) && (!landAnim) && (!shotgunAnim))  
                {  
                    machslideAnim = 0  
                    idle = 0  
                    facehurt = 0  
                    if shoot  
                        sprite_index = spr_pistolwalk  
                    else if mort  
                        sprite_index = spr_player_mortwalk  
                    else if (breakdance_pressed >= breakdance_max)  
                        sprite_index = spr_breakdance  
                    else if (global.fill <= 0 && (!instance_exists(obj_ghostcollectibles)))  
                        sprite_index = spr_hurtwalk  
                    else if ((global.combo >= 25 && global.combo < 50) || instance_exists(obj_pizzafaceboss) || (global.noisejetpack && (ispeppino || noisepizzapepper)))  
                        sprite_index = spr_3hpwalk  
                    else if (global.combo >= 50 || (ispeppino && instance_exists(obj_pizzaface_thunderdark)))  
                        sprite_index = spr_ragemove  
                    else  
                        sprite_index = movespr  
                }  
            }  
            if (move != 0 && grounded && vsp > 0)  
            {  
                if (steppybuffer > 0)  
                    steppybuffer--  
                else if (sprite_index != spr_breakdance && sprite_index != spr_pepdance && sprite_index != spr_noise_vulnerable2)  
                {  
                    create_particle(x, (y + 43), particletypes.cloudeffect, 0)  
                    steppybuffer = 12  
                    if place_meeting(x, y, obj_poodebris)  
                        fmod_event_one_shot_3d("event:/sfx/pep/stepinshit", x, y)  
                    else  
                        fmod_event_one_shot_3d("event:/sfx/pep/step", x, y)  
                }  
            }  
        }  
        if (move == 0 || place_meeting((x + xscale), y, obj_solid))  
        {  
            steppybuffer = 12  
            if (sprite_index == spr_breakdance)  
                image_speed = breakdance_speed  
            else  
                image_speed = 0.35  
            movespeed = Approach(movespeed, 0, 0.5)  
            if ((!machslideAnim) && (!landAnim) && (!shotgunAnim))  
            {  
                if (idle < 400 && breakdance_pressed < breakdance_max)  
                    idle++  
                if (idle >= 150 && (!global.panic) && global.combo < 25 && brick && breakdance_pressed < breakdance_max)  
                {  
                    if (sprite_index != idlespr && floor(image_index) == (image_number - 1))  
                    {  
                        facehurt = 0  
                        idle = 0  
                    }  
                    if (((!global.pistol) || (!ispeppino)) && (!shotgunAnim) && sprite_index != spr_idle1 && sprite_index != spr_idle2 && sprite_index != spr_idle3 && sprite_index != spr_idle4 && sprite_index != spr_idle5 && sprite_index != spr_idle6)  
                    {  
                        idleanim = random_range(0, 100)  
                        if (irandom(100) <= 25)  
                            fmod_event_one_shot_3d("event:/sfx/voice/myea", x, y)  
                        image_index = 0  
                        if (idleanim <= 16)  
                            sprite_index = spr_idle1  
                        else if (idleanim > 16 && idleanim <= 32)  
                            sprite_index = spr_idle2  
                        else if (idleanim > 32 && idleanim <= 48)  
                            sprite_index = spr_idle3  
                        else if (idleanim > 48 && idleanim <= 64)  
                            sprite_index = spr_idle4  
                        else if (idleanim > 64 && idleanim <= 80)  
                            sprite_index = spr_idle5  
                        else  
                            sprite_index = spr_idle6  
                    }  
                }  
                else if (windingAnim >= 0 || angry || global.playerhealth == 1 || shoot)  
                {  
                    start_running = 1  
                    if shoot  
                        sprite_index = spr_player_pistolidle  
                    else if mort  
                        sprite_index = spr_player_mortidle  
                    else if (breakdance_pressed >= breakdance_max)  
                        sprite_index = spr_breakdance  
                    else if ((global.fill <= 0 && (!instance_exists(obj_ghostcollectibles))) || instance_exists(obj_kidspartybg))  
                        sprite_index = spr_hurtidle  
                    else if (global.panic && (!instance_exists(obj_ghostcollectibles)))  
                        sprite_index = spr_panic  
                    else if ((global.combo >= 25 && global.combo < 50) || (instance_exists(obj_pepperman) && (!instance_exists(obj_pizzaface_thunderdark))) || instance_exists(obj_pizzafaceboss) || (global.noisejetpack && (ispeppino || noisepizzapepper)))  
                        sprite_index = spr_3hpidle  
                    else if (global.combo >= 50 || (ispeppino && instance_exists(obj_pizzaface_thunderdark)))  
                        sprite_index = spr_rageidle  
                    else  
                        sprite_index = idlespr  
                }  
            }  
        }  
    }  
    if (movespeed > maxmovespeed && (!key_attack))  
        movespeed -= deccel  
    if landAnim  
    {  
        if (sprite_index == spr_player_mortland)  
        {  
            if (floor(image_index) == (image_number - 1))  
            {  
                landAnim = 0  
                sprite_index = spr_player_mortidle  
                image_index = 0  
            }  
        }  
        else if (sprite_index == spr_player_pistolland)  
        {  
            if (floor(image_index) == (image_number - 1))  
            {  
                sprite_index = idlespr  
                landAnim = 0  
            }  
        }  
        else if (!shotgunAnim)  
        {  
            if (move == 0)  
            {  
                movespeed = 0  
                sprite_index = spr_land  
                if (floor(image_index) == (image_number - 1))  
                    landAnim = 0  
            }  
            else  
            {  
                sprite_index = spr_land2  
                if (floor(image_index) == (image_number - 1))  
                {  
                    landAnim = 0  
                    sprite_index = movespr  
                    image_index = 0  
                }  
            }  
        }  
        else  
        {  
            sprite_index = spr_shotgunland  
            if (floor(image_index) == (image_number - 1))  
            {  
                landAnim = 0  
                sprite_index = spr_shotgunidle  
                if (move != 0)  
                    sprite_index = spr_shotgunwalk  
                image_index = 0  
            }  
        }  
    }  
    else if (shotgunAnim && sprite_index != spr_shotgunshoot && (!machslideAnim))  
        sprite_index = (move == 0 ? spr_shotgunidle : spr_shotgunwalk)  
    if machslideAnim  
        sprite_index = spr_machslideend  
    if (floor(image_index) == (image_number - 1))  
    {  
        switch sprite_index  
        {  
            case spr_machslideend:  
                machslideAnim = 0  
                sprite_index = idlespr  
                if shotgunAnim  
                    sprite_index = spr_shotgunidle  
                break  
            case 3368:  
                sprite_index = idlespr  
                break  
            case spr_shotgunshoot:  
                sprite_index = spr_shotgunidle  
                break  
            case spr_pistolshot:  
                sprite_index = idlespr  
                break  
        }  
  
    }  
    if grounded  
    {  
        if ((key_jump || (input_buffer_jump > 0 && vsp > 0)) && (!key_down))  
        {  
            input_buffer_jump = 0  
            scr_fmod_soundeffect(jumpsnd, x, y)  
            if (sprite_index != spr_shotgunshoot)  
            {  
                sprite_index = spr_jump  
                if shotgunAnim  
                    sprite_index = spr_shotgunjump  
                else if (global.pistol && ispeppino)  
                    sprite_index = spr_player_pistoljump1  
                image_index = 0  
            }  
            particle_set_scale(particletypes.highjumpcloud2, xscale, 1)  
            create_particle(x, y, particletypes.highjumpcloud2, 0)  
            vsp = jumpspeed  
            state = states.jump
            jumpAnim = 1  
            jumpstop = 0  
            if place_meeting(x, (y + 1), obj_railparent)  
                railmomentum = 1  
            freefallstart = 0  
        }  
        if (key_down || (grounded && vsp > 0 && scr_solid(x, (y - 3)) && scr_solid(x, y)) || place_meeting(x, y, obj_solid))  
        {  
            state = states.crouch
            landAnim = 0  
            crouchAnim = 1  
            image_index = 0  
            idle = 0  
            if (!(place_meeting((x + xscale), y, obj_solid)))  
                wcrouchbuffer = 10  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
        }  
    }  
    else if (!key_jump)  
    {  
        if (sprite_index != spr_shotgunshoot)  
        {  
            if (!shotgunAnim)  
                sprite_index = spr_fall  
            else  
                sprite_index = spr_shotgunfall  
            if (global.pistol && ispeppino)  
                sprite_index = spr_player_pistoljump2  
            image_index = 0  
            jumpAnim = 0  
        }  
        else  
            jumpAnim = 1  
        state = states.jump
    }  
    if (abs(hsp) >= machSpeed && key_attack && skateboarding == 0)  
    {  
        sprite_index = spr_mach4  
        state = states.mach3
        particle_set_scale(particletypes.jumpdust, xscale, 1)  
        create_particle(x, y, particletypes.jumpdust, 0)  
        return;  
    }  
    if (input_buffer_shoot > 0)  
    {  
        if shotgunAnim  
            scr_shotgunshoot()  
        else if global.pistol  
            scr_pistolshoot(states.normal)  
    }  
    scr_wm_dokatana()  
    if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && xscale == move && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && key_attack)  
    {  
        var _climb = ledge_bump(40)  
        if _climb  
        {  
            if ledge_bump((vsp >= 0 ? 32 : 22))  
            {  
                if (abs(hsp) > 8)  
                    vsp = (abs(hsp * 1.2)) * -1  
                if place_meeting(x, (y + 1), obj_slope)  
                    vsp -= 8  
                movespeed = 0  
                if (brick == 1)  
                {  
                    with (instance_create(x, y, obj_mango_companion))  
                        wait = 1  
                    brick = 0  
                }  
                state = states.climbwall 
                return;  
            }  
            return;  
        }  
    }  
    scr_wm_doyosh()  
    scr_dotaunt()  
    if (sprite_index == spr_shotgunshoot)  
    {  
        landAnim = 0  
        machslideAnim = 0  
        image_speed = 0.45  
    }  
}