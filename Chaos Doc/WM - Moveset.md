#states
All of these are "managed" by controllers inside the movement scripts of the player [[Moveset controllers]]
## Behaviour scripts

### scr_wmp_normal()

~~~js
function scr_wmp_normal() //gml_Script_scr_wmp_normal  
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
            notification_push((68 << 0), [])  
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
                state = (105 << 0)  
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
                    create_particle(x, (y + 43), (1 << 0), 0)  
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
                    if (((!global.pistol) || (!ispeppino)) && sprite_index != spr_player_snapnailit && sprite_index != spr_player_judge && sprite_index != spr_player_freezeridle && sprite_index != spr_donisha_scared && (!shotgunAnim) && sprite_index != spr_idle1 && sprite_index != spr_idle2 && sprite_index != spr_idle3 && sprite_index != spr_idle4 && sprite_index != spr_idle5 && sprite_index != spr_idle6)  
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
                    if (sprite_index == spr_player_snapnailit)  
                    {  
                    }  
                    else if shoot  
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
            case spr_player_snapnailit:  
                image_index = 0  
                sprite_index = idlespr  
                if shotgunAnim  
                    sprite_index = spr_shotgunidle  
                break  
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
            particle_set_scale((4 << 0), xscale, 1)  
            create_particle(x, y, (4 << 0), 0)  
            vsp = jumpspeed  
            state = (92 << 0)  
            jumpAnim = 1  
            jumpstop = 0  
            if place_meeting(x, (y + 1), obj_railparent)  
                railmomentum = 1  
            freefallstart = 0  
        }  
        if (key_down || (grounded && vsp > 0 && scr_solid(x, (y - 3)) && scr_solid(x, y)) || place_meeting(x, y, obj_solid))  
        {  
            state = (100 << 0)  
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
        state = (92 << 0)  
    }  
    if (abs(hsp) >= machSpeed && key_attack && skateboarding == 0)  
    {  
        sprite_index = spr_mach4  
        state = (121 << 0)  
        particle_set_scale((5 << 0), xscale, 1)  
        create_particle(x, y, (5 << 0), 0)  
        return;  
    }  
    if (input_buffer_shoot > 0)  
    {  
        if shotgunAnim  
            scr_shotgunshoot()  
        else if global.pistol  
            scr_pistolshoot((0 << 0))  
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
                state = (37 << 0)  
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
~~~
### scr_wmp_jump()

~~~js
function scr_wmp_jump() //gml_Script_scr_wmp_jump  
{  
    var maxmovespeed = 8  
    var maxmovespeed2 = 6  
    var turnmovespeed = 2  
    var accel = 0.5  
    var deccel = 0.1  
    var jumpspeed = -11  
    var machspeed = 6  
    move = key_left + key_right  
    landAnim = 1  
    if (!momemtum)  
        hsp = Approach(hsp, (move * movespeed), accel)  
    else  
        hsp = Approach(hsp, (xscale * movespeed), accel)  
    hsp += (railmovespeed * raildir)  
    if key_taunt2  
    {  
        input_finisher_buffer = 60  
        input_attack_buffer = 0  
        input_up_buffer = 0  
        input_down_buffefr = 0  
    }  
    if (move != xscale)  
        movespeed = turnmovespeed  
    if (movespeed < maxmovespeed && move != 0)  
        movespeed += 0.5  
    if (movespeed == 0)  
        momemtum = 0  
    if place_meeting((x + hsp), y, obj_solid)  
    {  
        movespeed = 0  
        mach2 = 0  
    }  
    if (move != 0)  
    {  
        xscale = move  
        if (place_meeting((x + xscale), y, obj_solid) && move == xscale)  
            movespeed = 0  
    }  
    if (ladderbuffer > 0)  
        ladderbuffer--  
    if (!jumpstop)  
    {  
        if ((!key_jump2) && vsp < 0.5 && (!stompAnim))  
        {  
            vsp /= 20  
            jumpstop = 1  
        }  
        else if (scr_solid(x, (y - 1)) && (!jumpAnim))  
        {  
            vsp = grav  
            jumpstop = 1  
        }  
    }  
    if (floor(image_index) == (image_number - 1))  
        jumpAnim = 0  
    if (global.mort && (sprite_index == spr_mortdoublejump || sprite_index == spr_mortdoublejumpstart))  
    {  
        if (vsp > 6)  
            vsp = 6  
        if (!key_jump2)  
        {  
            grav = 0.5  
            sprite_index = spr_fall  
        }  
    }  
    if key_jump  
    {  
        if (global.mort && sprite_index != spr_mortdoublejump)  
        {  
            repeat (6)  
                create_debris(x, y, 1657)  
            sprite_index = spr_mortdoublejump  
            image_index = 0  
            jumpstop = 0  
            grav = 0.25  
            mort = 1  
        }  
    }  
    if (can_jump && input_buffer_jump > 0 && (!key_down) && (!key_attack) && vsp > 0 && (!((sprite_index == spr_facestomp || sprite_index == spr_freefall))))  
    {  
        input_buffer_jump = 0  
        scr_fmod_soundeffect(jumpsnd, x, y)  
        stompAnim = 0  
        vsp = jumpspeed  
        state = (92 << 0)  
        jumpAnim = 1  
        jumpstop = 0  
        freefallstart = 0  
        railmomentum = 0  
        if place_meeting(x, (y + 1), obj_railparent)  
            railmomentum = 1  
        if (sprite_index != spr_shotgunshoot)  
        {  
            sprite_index = spr_jump  
            if shotgunAnim  
                sprite_index = spr_shotgunjump  
            if (global.pistol && ispeppino)  
                sprite_index = spr_player_pistoljump1  
            image_index = 0  
        }  
        particle_set_scale((4 << 0), xscale, 1)  
        create_particle(x, y, (4 << 0), 0)  
    }  
    if ((!can_jump) && character == "P" && (!ispeppino) && key_up && noisedoublejump && input_buffer_jump > 0 && (!key_down) && (!key_attack))  
    {  
        freefallstart = 0  
        railmomentum = 0  
        if place_meeting(x, (y + 1), obj_railparent)  
            railmomentum = 1  
        scr_player_do_noisecrusher()  
    }  
    if (grounded && vsp > 0)  
    {  
        fmod_event_one_shot_3d("event:/sfx/pep/step", x, y)  
        if (key_attack || sprite_index == spr_shotgunshoot)  
            landAnim = 0  
        if (sprite_index == spr_mortdoublejump || sprite_index == spr_mortdoublejumpstart)  
            sprite_index = spr_player_mortland  
        if (sprite_index != spr_shotgunshoot)  
            image_index = 0  
        if (global.pistol && ispeppino)  
            sprite_index = spr_player_pistolland  
        input_buffer_secondjump = 0  
        state = (0 << 0)  
        jumpAnim = 1  
        jumpstop = 0  
        freefallstart = 0  
        create_particle(x, y, (12 << 0), 0)  
        return;  
    }  
    var fw = (place_meeting((x + xscale), y, obj_solid) || place_meeting((x + hsp), y, obj_solid))  
    if (fw && xscale == move && key_attack)  
    {  
        var _climb = ledge_bump(40)  
        if _climb  
        {  
            if ledge_bump((vsp >= 0 ? 32 : 22))  
            {  
                scr_wm_dowallcling()  
                return;  
            }  
            return;  
        }  
    }  
    if (vsp > 5 && sprite_index != spr_mortdoublejump)  
        fallinganimation++  
    if (fallinganimation >= 40 && fallinganimation < 80)  
        sprite_index = spr_facestomp  
    else if (fallinganimation >= 80)  
        sprite_index = spr_freefall  
    if (!stompAnim)  
    {  
        if (!jumpAnim)  
        {  
            switch sprite_index  
            {  
                case spr_wethamcansh:  
                    sprite_index = spr_fall  
                    break  
                case spr_walljumpstart:  
                    sprite_index = spr_fall  
                    break  
                case spr_mortdoublejumpstart:  
                    sprite_index = spr_mortdoublejump  
                    break  
                case spr_suplexland:  
                    sprite_index = spr_fall  
                    break  
                case 1571:  
                    sprite_index = spr_playerN_doublejumpfall  
                    break  
                case spr_airdash1:  
                    sprite_index = spr_airdash2  
                    break  
                case 2224:  
                    sprite_index = spr_player_pistoljump2  
                    break  
                case spr_shotgunjump:  
                    sprite_index = spr_shotgunfall  
                    break  
                case 3345:  
                    sprite_index = spr_playerV_fall  
                    break  
                case spr_jump:  
                    sprite_index = spr_fall  
                    break  
                case 3753:  
                    sprite_index = spr_player_pistoljump2  
                    break  
                case 4672:  
                case spr_suplexcancel:  
                    sprite_index = spr_fall  
                    break  
                case 1258:  
                    sprite_index = spr_fall  
                    break  
                case 1004:  
                    sprite_index = spr_player_Sjump  
                    break  
                case 736:  
                    sprite_index = spr_player_shotgunjump2  
                    break  
                case 718:  
                    sprite_index = spr_shotgunfall  
                    break  
                case spr_shotgunshoot:  
                    sprite_index = spr_shotgunfall  
                    break  
                case spr_stompprep:  
                    sprite_index = spr_stomp  
                    break  
                case 4229:  
                    sprite_index = spr_fall  
                    break  
                case spr_w_lonjump:  
                    sprite_index = spr_w_lonjump_end  
                    break  
            }  
  
        }  
    }  
    else if (sprite_index == spr_stompprep && floor(image_index) == (image_number - 1))  
        sprite_index = spr_stomp  
    if ((scr_check_groundpound() || key_down) && (!global.kungfu))  
    {  
        input_buffer_slap = 0  
        if (!shotgunAnim)  
        {  
            clingexitspeed = movespeed  
            sprite_index = spr_bodyslamstart  
            image_index = 0  
            state = (108 << 0)  
            hsp = 0  
            pistolanim = -4  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
            return;  
        }  
        else if ispeppino  
        {  
            fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y)  
            sprite_index = spr_shotgunjump1  
            image_index = 0  
            state = (108 << 0)  
            vsp = -11  
            with (instance_create(x, y, obj_shotgunblast))  
            {  
                sprite_index = spr_shotgunblastdown  
                with (bulletID)  
                {  
                    sprite_index = other.sprite_index  
                    mask_index = other.mask_index  
                }  
            }  
        }  
        else  
        {  
            notification_push((44 << 0), [room])  
            state = (69 << 0)  
            minigunshot = 3  
            minigunbuffer = 0  
            sprite_index = spr_playerN_minigundown  
            image_index = 0  
        }  
    }  
    if (sprite_index == spr_player_suplexcancel)  
        image_speed = 0.4  
    else if (sprite_index == spr_wethamcansh)  
        image_speed = 0.66  
    else  
        image_speed = 0.35  
    if (grounded && (sprite_index == spr_facestomp || sprite_index == spr_freefall))  
    {  
        fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
        image_index = 0  
        sprite_index = spr_bodyslamland  
        state = (111 << 0)  
        with (obj_baddie)  
        {  
            if (shakestun && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0)  
            {  
                vsp = -7  
                hsp = 0  
            }  
        }  
        with (obj_camera)  
        {  
            shake_mag = 10  
            shake_mag_acc = 30 / room_speed  
        }  
    }  
    if (input_buffer_shoot > 0)  
    {  
        if shotgunAnim  
            scr_shotgunshoot()  
        else if global.pistol  
            scr_pistolshoot((92 << 0))  
    }  
    if (key_slap2 && shoot)  
    {  
        if (!shotgunAnim)  
        {  
            flash = 1  
            if ((!instance_exists(parry_inst)) && flash == 1)  
            {  
                parry_inst = instance_create(x, y, obj_parryhitbox)  
                var _playerid = 1  
                if (object_index == obj_player2)  
                    _playerid = 2  
                with (parry_inst)  
                {  
                    player_id = _playerid  
                    image_xscale = other.xscale  
                }  
            }  
            if global.mort  
            {  
                with (instance_create((x + xscale * 20), y, obj_shotgunbullet))  
                {  
                    image_xscale = other.xscale  
                    sprite_index = spr_mortprojectile  
                }  
                sprite_index = spr_mortthrow  
                image_index = 0  
                state = (72 << 0)  
                mort = 1  
                with (obj_camera)  
                {  
                    shake_mag = 3  
                    shake_mag_acc = 3 / room_speed  
                }  
            }  
        }  
    }  
    if ((!key_attack) || move != xscale)  
        mach2 = 0  
    if (sprite_index == spr_playerN_ratballoonbounce && floor(image_index) == (image_number - 1))  
        image_index = image_number - 1  
    scr_wm_dokatana()  
    scr_wm_dodoublejump()  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doyosh()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    if (sprite_index == spr_shotgunshoot)  
    {  
        landAnim = 0  
        machslideAnim = 0  
        image_speed = 0.45  
        if (image_index > (image_number - 1))  
            sprite_index = spr_shotgunfall  
    }  
    if place_meeting(x, y, obj_solid)  
    {  
        state = (100 << 0)  
        landAnim = 0  
        crouchAnim = 1  
        image_index = 0  
        idle = 0  
    }  
}
~~~
### scr_wmp_skid()

~~~js
function scr_wmp_skid() //gml_Script_scr_wmp_skid  
{  
    if scr_wm_lastbreath()  
        return;  
    if (!(place_meeting(x, (y + 1), obj_railparent)))  
        hsp = xscale * (-movespeed)  
    else  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        hsp = xscale * movespeed + _railinst.movespeed * _railinst.dir  
    }  
    move = key_right + key_left  
    movespeed = Approach(movespeed, 0, 0.8)  
    if (movespeed <= 0)  
    {  
        hsp = 0  
        movespeed = 0  
        if grounded  
            state = (0 << 0)  
        else  
        {  
            sprite_index = spr_fall  
            state = (92 << 0)  
            if key_down  
            {  
                clingexitspeed = movespeed  
                sprite_index = spr_bodyslamstart  
                image_index = 0  
                state = (108 << 0)  
                return;  
            }  
        }  
        return;  
    }  
    image_speed = 0.35  
    landAnim = 0  
    if brick  
        sprite_index = spr_mach3boost  
    else  
        sprite_index = spr_lonegustavo_skid  
    scr_wm_doyosh()  
    scr_wm_dokatana()  
    if (input_buffer_shoot > 0)  
    {  
        if shotgunAnim  
        {  
            if (move != 0)  
                xscale = move  
            scr_shotgunshoot()  
        }  
        else if global.pistol  
            scr_pistolshoot((0 << 0))  
    }  
    if ((!instance_exists(dashcloudid)) && grounded && (!(place_meeting(x, (y + 1), obj_water))))  
    {  
        with (instance_create(x, y, obj_dashcloud2))  
        {  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
    if ((!instance_exists(dashcloudid)) && grounded && place_meeting(x, (y + 1), obj_water))  
    {  
        with (instance_create(x, y, obj_dashcloud2))  
        {  
            sprite_index = spr_watereffect  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
}
~~~
### scr_wmp_mach3()

~~~js
function scr_wmp_mach3() //gml_Script_scr_wmp_mach3  
{  
    if scr_wm_lastbreath()  
        return;  
    if (sprite_index == spr_fightball)  
    {  
        scr_player_fightball()  
        return;  
    }  
    if (sprite_index == spr_wm_djump || sprite_index == spr_wm_airspin)  
    {  
        scr_wmp_doublejump()  
        return;  
    }  
    if (sprite_index == spr_wm_katanaboost || sprite_index == spr_wm_katanaboost_loop)  
    {  
        scr_wmp_jaws()  
        return;  
    }  
    if (sprite_index == spr_w_spinkick)  
    {  
        move = key_left + key_right  
        hsp = xscale * movespeed  
        if (jawsbuffer > 0)  
        {  
            jawsbuffer--  
            if (vsp > -0.5)  
                vsp = 0  
        }  
        if (grounded && vsp >= 0)  
        {  
            image_index = 0  
            sprite_index = spr_mach4  
        }  
        if scr_mach_check_dive()  
        {  
            jawsbuffer = 0  
            if (vsp < 10)  
                vsp = 10  
        }  
        scr_wm_dokatana()  
        if key_jump  
        {  
            with (instance_create(x, y, obj_wethamtornado))  
            {  
                state = (0 << 0)  
                image_xscale = 1.5  
                image_yscale = 1.5  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windspin  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
            image_index = 2  
            state = (104 << 0)  
            vsp = -11  
            jumpAnim = 1  
            sprite_index = spr_wethamwalljump  
            return;  
        }  
        if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
        {  
            slashstored = 0  
            with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
            {  
                state = (0 << 0)  
                image_xscale = other.xscale * 1.5  
                image_yscale = 1.5  
                image_index = 0  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_wallcurrent  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
            if (movespeed < 16)  
                movespeed = 16  
            wallclingpulse = 45  
            if (place_meeting((x + hsp), y, obj_solid) && place_meeting((x + hsp), y, obj_slope))  
                ledge_bump(40)  
            scr_wm_dowallcling()  
            vsp = -18.4  
            return;  
        }  
        image_speed = 0.65  
        return;  
    }  
    switch character  
    {  
        case "P":  
            var slopeaccel = 0.1  
            var slopedeccel = 0.2  
            var mach4movespeed = 20  
            var mach3movespeed = 16  
            var accel = 0.09  
            var mach4accel = 0.1  
            var jumpspeed = -11  
            var machrollspeed = 10  
            var speedCap = 12  
            if brick  
                speedCap = 16  
            var mach3_spr = spr_mach4  
            var mach3jump_spr = spr_mach3jump  
            if (global.swapmode && key_attack && key_fightball && (!instance_exists(obj_swapmodegrab)) && (!instance_exists(obj_swapdeatheffect)) && (!instance_exists(obj_noiseanimatroniceffect)) && obj_swapmodefollow.animatronic <= 0)  
            {  
                sprite_index = spr_fightball  
                jump_p2 = 0  
                if noisecrusher  
                    instance_create_unique(x, y, 158)  
                return;  
            }  
            if ((!ispeppino) && grounded && vsp > 0)  
            {  
                if (sprite_index == spr_mach4 && place_meeting(x, (y + 1), obj_water))  
                    sprite_index = spr_playerN_mach3water  
                else if (sprite_index == spr_playerN_mach3water && (!(place_meeting(x, (y + 1), obj_water))))  
                    sprite_index = spr_mach4  
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
            if (move == xscale && grounded && movespeed < speedCap)  
                movespeed += accel  
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
            crouchslideAnim = 1  
            if ((!key_jump2) && jumpstop == 0 && vsp < 0.5)  
            {  
                vsp /= 20  
                jumpstop = 1  
            }  
            if (grounded && vsp > 0)  
                jumpstop = 0  
            if (input_buffer_jump > 0 && sprite_index != mach3jump_spr && can_jump && (!((move == 1 && xscale == -1))) && (!((move == -1 && xscale == 1))))  
            {  
                input_buffer_jump = 0  
                scr_fmod_soundeffect(jumpsnd, x, y)  
                particle_set_scale((5 << 0), xscale, 1)  
                create_particle(x, y, (5 << 0), 0)  
                if (sprite_index != spr_fightball)  
                {  
                    image_index = 0  
                    sprite_index = mach3jump_spr  
                }  
                if (character == "P")  
                    vsp = jumpspeed  
                else  
                    vsp = -13  
            }  
            if (fightball == 0 && sprite_index != spr_wm_airspin && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop && sprite_index != spr_wm_katanaboost_recover)  
            {  
                if (grounded && vsp >= 0)  
                    sprite_index = mach3_spr  
                else  
                    sprite_index = mach3jump_spr  
            }  
            if (sprite_index == spr_wm_katanaboost_recover)  
            {  
                if (floor(image_index) == (image_number - 1) || (!((grounded && vsp >= 0))))  
                    sprite_index = mach3_spr  
            }  
            if (sprite_index == spr_wm_airspin && grounded && vsp >= 0)  
                sprite_index = mach3_spr  
            if (sprite_index == spr_crazyrun && (!instance_exists(crazyruneffectid)))  
            {  
                with (instance_create(x, y, obj_crazyrunothereffect))  
                {  
                    playerid = other.object_index  
                    other.crazyruneffectid = id  
                }  
            }  
            if (sprite_index == mach3_spr || sprite_index == spr_fightball)  
                image_speed = 0.4  
            else if (sprite_index == spr_crazyrun)  
                image_speed = 0.75  
            else if (sprite_index == spr_rollgetup || sprite_index == spr_mach3hit || sprite_index == spr_dashpadmach)  
                image_speed = 0.4  
            else  
                image_speed = 0.4  
            if (((!key_attack) && fightball == 0 && (!launched) && sprite_index != spr_dashpadmach && grounded && vsp > 0 && (character == "P" || character == "N")) || (character == "S" && (move == 0 || move != xscale) && grounded && fightball == 0))  
            {  
                sprite_index = spr_move  
                state = (0 << 0)  
                image_index = 0  
                movespeed = 8  
                hsp = movespeed * xscale  
                return;  
            }  
            if (move == (-xscale) && grounded && vsp > 0 && (!launched) && (character == "P" || character == "N") && fightball == 0 && sprite_index != spr_dashpadmach)  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/backslide", x, y)  
                sprite_index = spr_mach3boost  
                state = (105 << 0)  
                image_index = 0  
                xscale *= -1  
                return;  
            }  
            if (move == (-xscale) && (!grounded) && sprite_index != spr_dashpadmach)  
            {  
                movespeed = 2  
                state = (92 << 0)  
                return;  
            }  
            if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))) && (!(place_meeting((x + sign(hsp)), y, obj_metalblock))))  
            {  
                var _climb = ledge_bump(40)  
                if _climb  
                {  
                    if ledge_bump((vsp >= 0 ? 32 : 22))  
                    {  
                        wallclingpulse = 15  
                        scr_wm_dowallcling()  
                        return;  
                    }  
                    return;  
                }  
            }  
            scr_wm_dokatana()  
            if (input_buffer_shoot > 0 && sprite_index != spr_dashpadmach)  
            {  
                if shotgunAnim  
                    scr_shotgunshoot()  
                else if global.pistol  
                    scr_pistolshoot((121 << 0))  
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
                        state = (106 << 0)  
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
                            state = (106 << 0)  
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
        if (state == (206 << 0) && playerid == other.id)  
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
    if grounded  
        scr_wm_doroll()  
    else if key_down  
    {  
        input_buffer_down = 0  
        state = (5 << 0)  
        sprite_index = spr_dive  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        fmod_event_instance_play(snd_crouchslide)  
        return;  
    }  
    scr_wm_doyosh()  
    scr_wm_dodoublejump()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    if (!instance_exists(chargeeffectid))  
    {  
        with (instance_create(x, y, obj_chargeeffect))  
        {  
            playerid = other.object_index  
            other.chargeeffectid = id  
        }  
    }  
    if (global.attackstyle == 2 && key_slap2)  
    {  
        randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, 801, 800, 797, spr_punch])  
        image_index = 0  
        state = (43 << 0)  
    }  
    if (movespeed < 11)  
        movespeed = 11  
}
~~~
### scr_wmp_tumble()

~~~js
function scr_wmp_tumble() //gml_Script_scr_wmp_tumble  
{  
    if place_meeting(x, (y + 1), obj_railparent)  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        railmovespeed = _railinst.movespeed  
        raildir = _railinst.dir  
    }  
    if (sprite_index == spr_wm_pounce_slide || sprite_index == spr_wm_pounce_dive)  
    {  
        scr_wmp_jaws()  
        return;  
    }  
    hsp = xscale * movespeed + railmovespeed * raildir  
    move = key_right + key_left  
    if (wrollbuffer > 0)  
        wrollbuffer--  
    mask_index = spr_crouchmask  
    if (sprite_index == spr_tumblestart)  
        movespeed = 6  
    if ((!grounded) && (sprite_index == spr_crouchslip || sprite_index == spr_machroll || sprite_index == spr_mach2jump || sprite_index == spr_backslide || sprite_index == spr_backslideland))  
    {  
        vsp = 10  
        sprite_index = spr_dive  
        fmod_event_instance_play(snd_dive)  
    }  
    if (sprite_index == spr_tumble && grounded)  
    {  
        if (move == xscale)  
            movespeed = Approach(movespeed, 12, 0.25)  
        else if (move == (-xscale))  
            movespeed = Approach(movespeed, 8, 0.25)  
        else  
            movespeed = Approach(movespeed, 10, 0.25)  
    }  
    if (movespeed <= 2 && sprite_index != spr_tumble && sprite_index != spr_breakdance)  
        state = (0 << 0)  
    if ((!scr_slope()) && sprite_index == spr_tumblestart && floor(image_index) < 11)  
        image_index = 11  
    if (sprite_index == spr_dive)  
    {  
        if grounded  
        {  
            if key_down  
            {  
                if (brick == 1)  
                {  
                    with (instance_create(x, y, obj_mango_companion))  
                        wait = 1  
                    brick = 0  
                }  
                image_index = 2  
                sprite_index = spr_wm_roll  
                state = (100 << 0)  
            }  
            else  
            {  
                state = (121 << 0)  
                flash = 1  
            }  
            return;  
        }  
        if key_jump  
        {  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
            with (instance_create(x, y, obj_wethamtornado))  
            {  
                state = (0 << 0)  
                image_xscale = 1.5  
                image_yscale = 1.5  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windspin  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
            image_index = 2  
            state = (104 << 0)  
            vsp = -11  
            jumpAnim = 1  
            sprite_index = spr_wethamwalljump  
            if key_down  
            {  
                clingexitspeed = movespeed  
                sprite_index = spr_bodyslamstart  
                image_index = 0  
                state = (108 << 0)  
                pistolanim = -4  
            }  
            return;  
        }  
        if scr_wm_lastbreath()  
            return;  
        scr_wm_doyosh()  
        scr_wm_dodoublejump()  
        scr_wm_dokatana()  
        scr_wm_dobombdive()  
    }  
    if (sprite_index == spr_mach2jump && grounded)  
    {  
        image_index = 0  
        sprite_index = spr_machroll  
    }  
    if (sprite_index == spr_mach2jump && grounded)  
    {  
        image_index = 0  
        sprite_index = spr_machroll  
    }  
    if (sprite_index == spr_crouchslip && (!grounded))  
        sprite_index = spr_player_jumpdive2  
    if (sprite_index == spr_player_Sjumpcancelland && floor(image_index) == (image_number - 1))  
        sprite_index = spr_player_Sjumpcancelslide  
    if (sprite_index == spr_player_jumpdive2 && grounded)  
        sprite_index = spr_crouchslip  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_machroll && movespeed > 12)  
    {  
        sprite_index = spr_backslideland  
        image_index = 0  
    }  
    if (sprite_index == spr_machroll && (!grounded))  
        sprite_index = spr_mach2jump  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_backslideland)  
        sprite_index = spr_backslide  
    if (sprite_index == spr_player_Sjumpcancel && grounded)  
        sprite_index = spr_player_Sjumpcancelland  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancelland)  
        sprite_index = spr_player_Sjumpcancelslide  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_breakdance)  
    {  
        particle_set_scale((5 << 0), xscale, 1)  
        create_particle(x, y, (5 << 0), 0)  
        movespeed = 12  
        sprite_index = spr_breakdancesuper  
    }  
    if (sprite_index == spr_tumblestart && floor(image_index) == (image_number - 1))  
    {  
        sprite_index = spr_tumble  
        movespeed = 14  
    }  
    if ((state != (108 << 0) && (place_meeting((x + xscale), y, obj_solid) || scr_solid_slope((x + xscale), y)) && (!(place_meeting((x + hsp), y, obj_rollblock))) && ((!(place_meeting((x + hsp), y, obj_rattumble))) || sprite_index != spr_tumble) && (!(place_meeting((x + hsp), y, obj_destructibles)))) || place_meeting(x, y, obj_timedgate))  
    {  
        if (sprite_index == spr_tumble || sprite_index == spr_tumblestart)  
        {  
            hsp = 0  
            movespeed = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y)  
            state = (106 << 0)  
            landAnim = 0  
            sprite_index = spr_tumbleend  
            image_index = 0  
            hsp = (-xscale) * 2  
            vsp = -3  
            jumpstop = 1  
        }  
        else if (sprite_index != spr_dive && state != (100 << 0))  
        {  
            hsp = 0  
            movespeed = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            state = (106 << 0)  
            image_index = 0  
            sprite_index = spr_wallsplat  
        }  
        else  
        {  
            vsp = 14  
            movespeed = 0  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
            state = (37 << 0)  
            return;  
        }  
    }  
    if ((!key_jump2) && jumpstop == 0 && vsp < 0.5 && stompAnim == 0)  
    {  
        vsp /= 2  
        jumpstop = 1  
    }  
    if (grounded && vsp > 0 && (!(place_meeting(x, y, obj_bigcheese))))  
        jumpstop = 0  
    if (input_buffer_jump > 0 && can_jump && state != (106 << 0) && hsp != 0 && sprite_index == spr_tumble && (!(place_meeting(x, y, obj_pinballlauncher))) && (!(place_meeting(x, y, obj_bigcheese))))  
    {  
        if (!(scr_solid(x, (y - 16))))  
        {  
            with (instance_create(x, y, obj_highjumpcloud2))  
                image_xscale = other.xscale  
            vsp = -11  
            scr_fmod_soundeffect(jumpsnd, x, y)  
        }  
    }  
    if (crouchslipbuffer > 0)  
        crouchslipbuffer--  
    if ((!key_down) && grounded && vsp > 0 && state != (106 << 0) && sprite_index != spr_tumble && sprite_index != spr_tumbleend && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && sprite_index != spr_breakdance)  
    {  
        if (crouchslipbuffer == 0)  
        {  
            flash = 1  
            state = (121 << 0)  
            return;  
        }  
    }  
    if (sprite_index == spr_crouchslip || sprite_index == spr_breakdancesuper || sprite_index == spr_machroll || sprite_index == spr_tumble || sprite_index == spr_tumblestart || sprite_index == spr_machroll || sprite_index == spr_mach2jump)  
        image_speed = abs(movespeed) / 15  
    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_mach2jump)  
        image_speed = 0  
    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancel)  
        image_speed = 0  
    else  
        image_speed = 0.35  
    if ((!instance_exists(dashcloudid)) && grounded)  
    {  
        with (instance_create(x, y, obj_dashcloud))  
        {  
            image_xscale = other.xscale  
            other.dashcloudid = id  
        }  
    }  
    if (sprite_index == spr_dive && vsp < 10)  
        vsp = 10  
}
~~~
### scr_wmp_crouch()

~~~js
function scr_wmp_crouch() //gml_Script_scr_wmp_crouch  
{  
    if scr_wm_lastbreath()  
        return;  
    move = key_left + key_right  
    if (wcrouchbuffer > 0)  
    {  
        wcrouchbuffer--  
        if (move != 0 || key_attack)  
        {  
            sprite_index = spr_wm_roll  
            image_index = 0  
            wcrouchbuffer = 0  
        }  
    }  
    if (sprite_index == spr_wm_roll)  
    {  
        if (wrollbuffer > 0)  
            wrollbuffer--  
        hsp = xscale * movespeed + railmovespeed * raildir  
        image_speed = 0.35  
        if (movespeed < 11)  
            movespeed = Approach(movespeed, 11, 3)  
        if (wrollbuffer == 0 && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
        {  
            if key_jump2  
            {  
                image_index = 3  
                state = (104 << 0)  
                vsp = -11  
                jumpAnim = 1  
                hsp = movespeed * xscale  
                fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
                sprite_index = spr_w_lonjump  
                return;  
            }  
            scr_wm_dokatana()  
        }  
        if (place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + xscale), y, obj_destructibles))))  
        {  
            if ((!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
            {  
                if place_meeting((x + xscale), y, obj_solid)  
                {  
                    if (place_meeting((x + sign(hsp)), y, obj_metalblock) && movespeed >= 12)  
                    {  
                        state = (121 << 0)  
                        if (movespeed < 12)  
                            movespeed = 12  
                    }  
                    else if place_meeting(x, (y + 1), obj_slope)  
                    {  
                        clingexitspeed = movespeed  
                        scr_wm_dowallcling()  
                        vsp = -18.4  
                        wallclimbbuffer = 20  
                    }  
                    else  
                    {  
                        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                        state = (106 << 0)  
                        image_index = 0  
                        sprite_index = spr_wallsplat  
                    }  
                }  
                else  
                {  
                    state = (121 << 0)  
                    if (movespeed < 12)  
                        movespeed = 12  
                }  
            }  
            else  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
                state = (106 << 0)  
                image_index = 0  
                sprite_index = spr_wallsplat  
            }  
            return;  
        }  
        if (floor(image_index) == (image_number - 1))  
        {  
            if ((!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
            {  
                if key_down  
                {  
                    state = (5 << 0)  
                    image_index = 0  
                    sprite_index = spr_backslideland  
                }  
                else if key_attack  
                {  
                    if (move == xscale || move == 0)  
                    {  
                        state = (121 << 0)  
                        if (movespeed < 12)  
                            movespeed = 12  
                    }  
                    else  
                    {  
                        movespeed = 8  
                        state = (0 << 0)  
                    }  
                }  
                else  
                {  
                    movespeed = 8  
                    state = (0 << 0)  
                }  
            }  
            else  
            {  
                state = (5 << 0)  
                image_index = 0  
                sprite_index = spr_backslideland  
            }  
        }  
        if (!grounded)  
        {  
            state = (5 << 0)  
            sprite_index = spr_dive  
        }  
        return;  
    }  
    if (!(place_meeting(x, (y + 1), obj_railparent)))  
        hsp = move * movespeed  
    else  
    {  
        var _railinst = instance_place(x, (y + 1), obj_railparent)  
        hsp = move * movespeed + _railinst.movespeed * _railinst.dir  
    }  
    movespeed = 4  
    mask_index = spr_crouchmask  
    turning = 0  
    if ((!grounded) && (!key_jump))  
    {  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = (108 << 0)  
        hsp = 0  
        pistolanim = -4  
        return;  
    }  
    if (grounded && (!key_down) && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && (!key_jump))  
    {  
        state = (0 << 0)  
        movespeed = 0  
        crouchAnim = 1  
        jumpAnim = 1  
        image_index = 0  
        mask_index = spr_player_mask  
    }  
    if (crouchAnim == 0)  
    {  
        if (move == 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_crouch  
            else  
                sprite_index = spr_shotgunduck  
        }  
        if (move != 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_crawl  
            else  
                sprite_index = spr_shotguncrawl  
        }  
    }  
    if (crouchAnim == 1)  
    {  
        if (move == 0)  
        {  
            if (shotgunAnim == 0)  
                sprite_index = spr_couchstart  
            else  
                sprite_index = spr_shotgungoduck  
            if (floor(image_index) == (image_number - 1))  
                crouchAnim = 0  
        }  
    }  
    if (move != 0)  
    {  
        xscale = move  
        crouchAnim = 0  
    }  
    image_speed = 0.45  
}
~~~
### scr_wmp_freefall()

~~~js
function scr_wmp_freefall() //gml_Script_scr_wmp_freefall  
{  
    landAnim = 1  
    vsp++  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_bodyslamstart)  
        sprite_index = spr_bodyslamfall  
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_shotgunjump1)  
        sprite_index = spr_shotgunjump3  
    move = key_left + key_right  
    if (!grounded)  
    {  
        if (sprite_index != spr_rockethitwall)  
            hsp = move * movespeed  
        else  
            hsp = 0  
        if (move != xscale && movespeed != 0)  
            movespeed -= 0.5  
        if ((move == 0 && momemtum == 0) || scr_solid((x + hsp), y))  
        {  
            movespeed = 0  
            mach2 = 0  
        }  
        if (move != 0 && movespeed < 7)  
            movespeed += 0.5  
        if ((scr_solid((x + 1), y) && move == 1) || (scr_solid((x - 1), y) && move == -1))  
            movespeed = 0  
    }  
    var blockofpizza = scr_solid(x, (y - 1))  
    while blockofpizza  
    {  
        y++  
        if (!(scr_solid(x, y)))  
            break  
        else  
            continue  
    }  
    if (grounded && (!blockofpizza) && vsp > 0 && (freefallsmash < 10 || (!(place_meeting(x, (y + vsp), obj_metalblock)))) && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + vsp + 6), obj_destructibles))))  
    {  
        if scr_slope()  
        {  
            with (instance_place(x, (y + 1), obj_slope))  
            {  
                other.xscale = (-sign(image_xscale))  
                with (instance_create(other.x, other.y, obj_jumpdust))  
                    image_xscale = (-sign(other.image_xscale))  
                with (other)  
                    scr_wm_doroll(1)  
            }  
        }  
        else  
        {  
            if (move != xscale && move != 0)  
            {  
                movespeed = 0  
                hsp = 0  
                clingexitspeed = 0  
            }  
            fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
            if (sprite_index == spr_player_poundcancel1)  
                sprite_index = spr_player_poundcancel2  
            else if (shotgunAnim == 0)  
                sprite_index = spr_bodyslamland  
            else  
                sprite_index = spr_shotgunjump2  
            image_index = 0  
            state = (111 << 0)  
            jumpAnim = 1  
            jumpstop = 0  
            with (obj_camera)  
            {  
                shake_mag = 5  
                shake_mag_acc = 15 / room_speed  
            }  
            if (freefallsmash >= 10)  
            {  
                with (obj_baddie)  
                {  
                    if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                    {  
                        state = (138 << 0)  
                        if (stunned < 60)  
                            stunned = 60  
                        vsp = -11  
                        image_xscale *= -1  
                        hsp = 0  
                        momentum = 0  
                    }  
                }  
                with (obj_camera)  
                {  
                    shake_mag = 10  
                    shake_mag_acc = 30 / room_speed  
                }  
                combo = 0  
                bounce = 0  
            }  
            create_particle(x, (y + 3), (14 << 0), 0)  
            freefallstart = 0  
        }  
    }  
    image_speed = 0.35  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
}
~~~
### scr_wmp_freefallland()

~~~js
function scr_wmp_freefallland() //gml_Script_scr_wmp_freefallland  
{  
    mach2 = 0  
    jumpAnim = 1  
    dashAnim = 1  
    landAnim = 0  
    moveAnim = 1  
    stopAnim = 1  
    crouchslideAnim = 1  
    crouchAnim = 0  
    machhitAnim = 0  
    facehurt = 1  
    start_running = 1  
    alarm[4] = 14  
    vsp = 0  
    move = key_left + key_right  
    var window = 5  
    if (sprite_index != spr_wm_bombdive_land)  
    {  
        if (move != 0)  
            hsp = movespeed * move  
        else  
            movespeed = Approach(movespeed, 0, 1)  
        if (floor(image_index) == (image_number - 1))  
        {  
            facehurt = 1  
            sprite_index = spr_idle  
            image_index = 0  
            state = (0 << 0)  
            jumpstop = 1  
        }  
        if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        {  
            input_buffer_down = 0  
            image_index = 3  
            state = (104 << 0)  
            vsp = -14  
            jumpAnim = 1  
            if (movespeed < 12)  
                movespeed = 12  
            if (move != 0)  
                hsp = movespeed * move  
            else  
                hsp = movespeed * xscale  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
            sprite_index = spr_walljumpstart  
            return;  
        }  
        scr_wm_dokatana()  
        scr_wm_doroll()  
    }  
    else  
    {  
        if (floor(image_index) < window)  
        {  
            if (key_down && key_jump2 && floor(image_index) > 2)  
            {  
                if scr_wm_dobombdive(1)  
                    return;  
            }  
            if (input_buffer_down < 30 && input_buffer_down != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_down = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                scr_wm_doroll(1)  
                return;  
            }  
            if (input_buffer_chaos < 30 && input_buffer_chaos != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                if key_down  
                {  
                    movespeed = 12  
                    if scr_wm_dobombdive(1)  
                        return;  
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                    instance_create(x, y, obj_highjumpcloud2)  
                    movespeed = clingexitspeed  
                    if (movespeed < 12)  
                        movespeed = 12  
                    if (move != 0)  
                    {  
                        hsp = movespeed * move  
                        xscale = move  
                    }  
                    else  
                        hsp = movespeed * xscale  
                    clingexitspeed = 0  
                    scr_wm_dokatana(1)  
                    return;  
                }  
            }  
            if (input_buffer_slap < 30 && input_buffer_slap != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_slap = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                clingexitspeed = 0  
                scr_wm_dokatana(0, 1)  
                return;  
            }  
            if (input_buffer_jump < 30 && input_buffer_jump != 0)  
            {  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wmpoundparry", x, y)  
                instance_create(x, (y + 25), obj_bangeffect)  
                flash = 1  
                input_buffer_jump = 0  
                GamepadSetVibration(0, 0.8, 0.8, 0.65)  
                instance_create(x, y, obj_highjumpcloud2)  
                sprite_index = spr_wm_airspin  
                image_index = 0  
                image_speed = 0.35  
                hoverspin = 15  
                movespeed = clingexitspeed  
                if (movespeed < 12)  
                    movespeed = 12  
                if (move != 0)  
                {  
                    hsp = movespeed * move  
                    xscale = move  
                }  
                else  
                    hsp = movespeed * xscale  
                clingexitspeed = 0  
                vsp = -11  
                state = (104 << 0)  
                return;  
            }  
        }  
        if (floor(image_index) >= window)  
        {  
            clingexitspeed = 0  
            if key_jump2  
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
                particle_set_scale((4 << 0), xscale, 1)  
                create_particle(x, y, (4 << 0), 0)  
                vsp = -11  
                state = (92 << 0)  
                jumpAnim = 1  
                jumpstop = 0  
                if place_meeting(x, (y + 1), obj_railparent)  
                    railmomentum = 1  
                freefallstart = 0  
            }  
            scr_wm_dokatana()  
            scr_wm_doroll()  
            if (floor(image_index) == (image_number - 1))  
            {  
                facehurt = 1  
                sprite_index = spr_idle  
                image_index = 0  
                state = (0 << 0)  
                jumpstop = 1  
            }  
        }  
    }  
    if (sprite_index == spr_wm_bombdive_land && floor(image_index) >= window && key_up)  
        image_speed = 0.65  
    else  
        image_speed = 0.35  
}
~~~
### scr_wmp_cling()

~~~js
function scr_wmp_cling() //gml_Script_scr_wmp_cling  
{  
    if (wallclingbuffer > 0)  
    {  
        wallclingbuffer--  
        if (input_buffer_slap > 0)  
        {  
            input_buffer_slap = 0  
            wallclingbuffer = 0  
            wallclingpulse = 15  
            clingexitspeed = 16  
            vsp = -13  
            with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
            {  
                state = (0 << 0)  
                image_xscale = other.xscale * 1.5  
                image_yscale = 1.5  
                image_index = 0  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_wallcurrent  
            }  
            katanawalloutbuffer = 10  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
        }  
    }  
    if (wallclingpulse > 0 && clingexitspeed > 8)  
    {  
        wallclingpulse--  
        if (clingexitspeed < 16)  
            vsp = clingexitspeed * -1  
        else  
            vsp = -16  
    }  
    if (wallstick > 0)  
    {  
        wallstick--  
        vsp = 0  
    }  
    if (katanawalloutbuffer > 0)  
    {  
        katanawalloutbuffer--  
        if (move == (xscale * -1))  
        {  
            scr_wm_dokatana(false, true)  
            katanawalloutbuffer = 0  
        }  
    }  
    movespeed = 0  
    hsp = 0  
    clingboost = 0  
    if (wallclimbbuffer > 0)  
        wallclimbbuffer--  
    if (verticalbuffer <= 0 && (!(scr_solid((x + xscale), y))) && (!(place_meeting(x, y, obj_verticalhallway))) && (!(place_meeting(x, (y - 12), obj_verticalhallway))))  
    {  
        if (vsp <= 0)  
        {  
            trace("climbwall out")  
            instance_create(x, y, obj_jumpdust)  
            var old_x = x  
            var old_y = y  
            var i = 0  
            scr_climboutchecker(i, old_x, old_y)  
            grounded = 1  
            wrollbuffer = 10  
            movespeed = clingexitspeed  
            if (movespeed < 8)  
                movespeed = 8  
            hsp = movespeed * xscale  
            vsp = 0  
            flash = 1  
            image_index = 0  
            sprite_index = spr_mach4  
            with (instance_create(x, y, obj_dashcloud))  
            {  
                image_xscale = other.xscale  
                other.dashcloudid = id  
            }  
            state = (121 << 0)  
            return;  
        }  
        else  
        {  
            state = (92 << 0)  
            sprite_index = spr_fall  
        }  
        return;  
    }  
    if (grounded && scr_slope())  
    {  
        with (instance_place(x, (y + 1), obj_slope))  
        {  
            other.xscale = (-sign(image_xscale))  
            other.wrollbuffer = 10  
            other.state = (100 << 0)  
            other.image_index = 0  
            other.sprite_index = other.spr_wm_roll  
            other.movespeed = 12  
            with (instance_create(other.x, other.y, obj_jumpdust))  
                image_xscale = (-sign(other.image_xscale))  
            return;  
        }  
    }  
    if (grounded && wallclimbbuffer == 0 && ispeppino && (!scr_slope()) && vsp > 0 && (!(place_meeting(x, (y + 1), obj_destructibles))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (place_meeting(x, (y + 1), obj_solid) || place_meeting(x, (y + 1), obj_platform)))  
    {  
        var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
        var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
        if (gap == 4 || gap == -4 || (dx != -4 && dx != 4))  
        {  
            mask_index = spr_crouchmask  
            state = (100 << 0)  
            sprite_index = spr_wm_roll  
            image_index = 0  
            fmod_event_instance_play(snd_dive)  
            return;  
        }  
        movespeed = 0  
        hsp = 0  
        wallspeed = 0  
        vsp = 0  
        state = (0 << 0)  
    }  
    image_speed = 0.35  
    if (sprite_index != spr_wm_cling && string_copy(sprite_get_name(sprite_index), 1, 11) != "spr_wm_wall")  
    {  
        sprite_index = spr_wm_cling  
        image_index = 0  
    }  
    if (sprite_index == spr_wm_wallclimb && vsp > 4)  
        sprite_index = spr_wm_wall_losingas  
    if (string_copy(sprite_get_name(sprite_index), 1, 11) == "spr_wm_wall")  
    {  
        if key_jump2  
        {  
            movespeed = clingexitspeed  
            scr_wm_bouncejaws(1)  
            jawsup = 1  
            return;  
        }  
        if key_down  
        {  
            movespeed = clingexitspeed  
            scr_wm_bouncejaws(1)  
            jawsup = 0  
            return;  
        }  
    }  
    if (key_jump && input_buffer_jump_negative <= 0)  
    {  
        state = (104 << 0)  
        xscale *= -1  
        vsp = -14  
        jumpAnim = 1  
        hsp = 10 * xscale  
        movespeed = 10  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        sprite_index = spr_walljumpstart  
        return;  
    }  
    if (key_down && wallclimbbuffer == 0)  
    {  
        if (vsp < 0)  
        {  
            vsp = 0  
            wallclingpulse = 0  
        }  
        if (vsp < 10)  
            vsp += 0.75  
    }  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
}
~~~
### scr_wmp_mach2()

~~~js
function scr_wmp_mach2() //gml_Script_scr_wmp_mach2  
{  
    if (sprite_index == spr_wm_djump)  
    {  
        scr_wmp_doublejump()  
        return;  
    }  
    move = key_left + key_right  
    var accel = 2  
    if (sprite_index != spr_walljumpstart)  
        accel = 0.5  
    if (move != 0)  
        hsp = Approach(hsp, (movespeed * xscale), accel)  
    if (movespeed >= 10)  
        hsp = movespeed * xscale  
    if (move != xscale)  
        movespeed = 8  
    if (move != 0)  
        xscale = move  
    if (floor(image_index) == (image_number - 1))  
    {  
        switch sprite_index  
        {  
            case spr_walljumpstart:  
                sprite_index = spr_fall  
                break  
            case spr_w_lonjump:  
                sprite_index = spr_w_lonjump_end  
                break  
        }  
  
    }  
    if key_down2  
    {  
        input_buffer_down = 0  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = (108 << 0)  
        pistolanim = -4  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        return;  
    }  
    if ((!grounded) && sprite_index != spr_w_spinball && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
    {  
        var _climb = ledge_bump(40)  
        if _climb  
        {  
            if ledge_bump((vsp >= 0 ? 32 : 22))  
            {  
                scr_wm_dowallcling()  
                return;  
            }  
        }  
    }  
    if (grounded && vsp >= 0.5)  
    {  
        if (movespeed < 12)  
            state = (0 << 0)  
        else  
            state = (121 << 0)  
    }  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doyosh()  
    scr_wm_dodoublejump()  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    if (sprite_index == spr_wm_airspin)  
        image_speed = 0.45  
    else  
        image_speed = 0.35  
}
~~~
### scr_wmp_katana()

~~~js
function scr_wmp_katana() //gml_Script_scr_wmp_katana  
{  
    if (floor(image_index) < 4 && (!instance_exists(obj_slashhitbox)))  
    {  
        parry_inst = instance_create(x, y, obj_slashhitbox)  
        var _playerid = 1  
        if (object_index == obj_player2)  
            _playerid = 2  
        with (parry_inst)  
        {  
            player_id = _playerid  
            image_xscale = other.xscale  
        }  
    }  
    if (floor(image_index) >= 4 || sprite_index == spr_wethamclash)  
        instance_destroy(parry_inst)  
    image_speed = 0.35  
    var wall = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_solid, 0, 1)  
    var owb = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_onewaybigblock, 0, 1)  
    var owbc = 0  
    if (owb != noone && owb.id.image_xscale == xscale)  
        owbc = 1  
    var cockblock = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_destructibles, 0, 1)  
    var cockblock2 = collision_line(x, (y + 8), (x + 100 * xscale), (y + 8), obj_slope, 0, 1)  
    var checkclash = ((wall != obj_grindrailslope && wall != noone && (cockblock == -4 || cockblock == 4) && (cockblock2 == -4 || cockblock2 == 4)) || owbc)  
    if (checkclash && floor(image_index) < 2 && sprite_index != spr_wethamclash && grounded && (!(place_meeting(x, (y + 1), obj_slope))))  
    {  
        if (xscale == 1)  
            instance_create(wall.bbox_left, (y - 10), obj_bumpeffect)  
        else  
            instance_create(wall.bbox_right, (y - 10), obj_bumpeffect)  
        hsp = 6 * (-xscale)  
        image_index = 0  
        sprite_index = spr_wethamclash  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/clash", x, y)  
    }  
    if (sprite_index == spr_wethamclash)  
    {  
        if (floor(image_index) == (image_number - 1))  
        {  
            hsp = 0  
            ratmount_speed = 0  
            movespeed = 0  
            if (!grounded)  
            {  
                sprite_index = spr_fall  
                state = (92 << 0)  
            }  
            else  
                state = (0 << 0)  
        }  
        hsp = Approach(hsp, 0, 0.5)  
        katanawallexit = 0  
        return;  
    }  
    if scr_wmp_uppercut()  
        return;  
    move = key_left + key_right  
    if (movespeed < 12)  
        hsp = movespeed * (power(slashstored, -0.3)) * xscale  
    else  
        hsp = movespeed * xscale  
    if (slashstored <= 1 && image_index < 3)  
        vsp = 0  
    if (input_buffer_slap < 30 && input_buffer_slap != 0 && floor(image_index) == (image_number - 1))  
    {  
        input_buffer_slap = 0  
        particle_set_scale((5 << 0), xscale, 1)  
        create_particle(x, y, (5 << 0), 0)  
        image_index = 0  
        slashstored++  
        if (sprite_index != spr_wethamslash)  
        {  
            sprite_index = spr_wethamslash  
            katanatype = 1  
        }  
        else  
        {  
            sprite_index = spr_wethamslash2  
            katanatype = 2  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/slashmiss", x, y)  
    }  
    if (floor(image_index) == (image_number - 1))  
    {  
        if grounded  
            slashstored = 0  
        if (movespeed >= 12)  
            state = (121 << 0)  
        else if grounded  
        {  
            jumpAnim = true  
            landAnim = false  
            state = (0 << 0)  
        }  
        else  
        {  
            sprite_index = spr_fall  
            state = (92 << 0)  
        }  
        scr_wm_doroll()  
        katanawallexit = 0  
    }  
    if (move != xscale && move != 0 && katanawallexit == 0)  
    {  
        if grounded  
            slashstored = 0  
        kpulsebuffer = 0  
        state = (92 << 0)  
        image_index = 0  
        sprite_index = spr_wethamcansh  
        movespeed = 8  
        hsp = 0  
        return;  
    }  
    if (input_buffer_jump < 30 && input_buffer_jump != 0 && (grounded || coyote_time > 0))  
    {  
        slashstored = 0  
        input_buffer_down = 0  
        image_index = 3  
        state = (104 << 0)  
        vsp = -11  
        jumpAnim = 1  
        kpulsebuffer = 0  
        if (movespeed < 12)  
            movespeed = 12  
        if (move != 0)  
            hsp = movespeed * move  
        else  
            hsp = movespeed * xscale  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        sprite_index = spr_w_lonjump  
        katanawallexit = 0  
        return;  
    }  
    scr_wm_dokatana()  
    if (place_meeting((x + hsp), y, obj_solid) && place_meeting((x + hsp), y, obj_slope))  
        ledge_bump(40)  
    if (((!grounded) || place_meeting(x, (y + 1), obj_slope)) && place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + sign(hsp)), y, obj_destructibles))))  
    {  
        slashstored = 0  
        with (instance_create(x, (y - 35 + vsp), obj_wethamtornado))  
        {  
            state = (0 << 0)  
            image_xscale = other.xscale * 1.5  
            image_yscale = 1.5  
            image_index = 0  
            image_speed = 0.45  
            image_alpha = 0.8  
            sprite_index = spr_w_wallcurrent  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/wallcurrent", x, y)  
        if (grounded && movespeed < 16)  
            movespeed = 16  
        if ((fakehsp < 16 || movespeed < 16) && fakehsp != 0)  
            movespeed = 16  
        else if (fakehsp > movespeed)  
            movespeed = fakehsp  
        scr_wm_dowallcling()  
        vsp = -18.4  
        wallclingpulse = 30  
        katanawallexit = 0  
        return;  
    }  
}
~~~
### scr_wmp_doublejump()

~~~js
function scr_wmp_doublejump() //gml_Script_scr_wmp_doublejump  
{  
    if place_meeting((x + move), y, obj_solid)  
    {  
        if (xscale != move)  
            xscale = move  
        scr_wm_dowallcling()  
        jumpstop = 0  
        return;  
    }  
    var hoverSpeed = abs(hsp)  
    var spinspid = 0  
    if (max(abs(hsp), abs(vsp)) < 8)  
        spinspid = 8  
    else  
        spinspid = max(abs(hsp), abs(vsp))  
    hoverspin = Approach(hoverspin, 15, 0.3)  
    image_speed = Approach(image_speed, (spinspid / hoverspin), 1)  
    if (key_jump2 && vsp > 0)  
        vsp = Approach(vsp, 4, 1)  
    if (hoverSpeed < 8)  
        hoverSpeed = 8  
    move = key_left + key_right  
    movespeed = hoverSpeed  
    if (move != 0)  
        hsp = Approach(hsp, (move * hoverSpeed), 1)  
    else if (movespeed < 12)  
        hsp = Approach(hsp, 0, 0.5)  
    if ((!jumpstop) && movespeed >= 12)  
    {  
        if ((!key_jump2) && vsp < 0.5)  
        {  
            vsp /= 10  
            jumpstop = 1  
        }  
    }  
    if (grounded && vsp > -0.5 && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + 15), obj_destructibles))) && (!(place_meeting(x, (y + 15), obj_grindrail))) && brick)  
    {  
        if (sprite_index != spr_lonegustavo_kick)  
        {  
            doublejump = 0  
            create_particle(x, y, (12 << 0), 0)  
            landAnim = 1  
            jumpstop = 0  
            if (move != 0)  
                xscale = move  
            if (movespeed < 12)  
            {  
                sprite_index = spr_idle  
                state = (0 << 0)  
            }  
            else  
            {  
                sprite_index = spr_mach4  
                state = (121 << 0)  
            }  
            fmod_event_one_shot_3d("event:/sfx/mort/down", x, y)  
            fmod_event_one_shot_3d("event:/sfx/moisc/sniffbump", x, y)  
            return;  
        }  
    }  
    if (state != (121 << 0))  
    {  
        if (punch_afterimage > 0)  
            punch_afterimage--  
        else  
            punch_afterimage = 6  
        if (punch_afterimage == 6 && hoverspin < 10)  
        {  
            with (create_mach3effect(x, y, sprite_index, (image_index - 1)))  
            {  
                image_xscale = other.xscale  
                playerid = other.id  
            }  
        }  
    }  
    if (movespeed < 12)  
        state = (104 << 0)  
    if (input_buffer_down < 30 && input_buffer_down != 0)  
    {  
        clingexitspeed = movespeed  
        sprite_index = spr_bodyslamstart  
        image_index = 0  
        state = (108 << 0)  
        hsp = 0  
        pistolanim = -4  
        if (brick == 1)  
        {  
            with (instance_create(x, y, obj_mango_companion))  
                wait = 1  
            brick = 0  
        }  
        return;  
    }  
    if scr_wm_lastbreath()  
        return;  
    scr_wm_doyosh()  
    scr_wm_dokatana()  
    scr_wm_dobombdive()  
    scr_dotaunt()  
    instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    if (!fmod_event_instance_is_playing(wmcopter))  
        fmod_event_instance_play(wmcopter)  
    fmod_event_instance_set_parameter(wmcopter, "speed", ((image_speed - 0.53) * 5 + image_speed / 1.005), 1)  
    fmod_event_instance_set_3d_attributes(wmcopter, x, y)  
}
~~~
### scr_wmp_ballmode()

~~~js
function scr_wmp_ballmode() //gml_Script_scr_wmp_ballmode  
{  
    move = key_left + key_right  
    if (ballspeed > 18)  
        ballspeed = 18  
    if key_jump2  
        jawsup = 1  
    if ((sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl) && (!ballvertical))  
        hsp = ballspeed * xscale  
    if ballvertical  
    {  
        if (move != 0)  
            hsp = Approach(hsp, (move * 8), 1)  
        else  
            hsp = Approach(hsp, 0, 0.5)  
        if (vsp > 0.5)  
            vsp++  
    }  
    var bombspeed = 6  
    if (sprite_index == spr_wm_bombdive)  
    {  
        if (movespeed <= bombspeed)  
        {  
            if (move != 0)  
                hsp = Approach(hsp, (move * bombspeed), 1)  
            else  
                hsp = Approach(hsp, 0, 1)  
        }  
        else  
        {  
            if (move != xscale && move != 0 && movespeed != 12)  
                movespeed = bombspeed  
            hsp = Approach(hsp, (move * movespeed), 1)  
        }  
        if (vsp > 4)  
            vsp++  
        if (vsp > 0)  
            bombdivesmash++  
    }  
    else  
        movespeed = ballspeed  
    if (grounded && sprite_index != spr_player_mangoboost && sprite_index != spr_player_mangoboostend && vsp > 0 && (!(place_meeting(x, (y + vsp + 2), obj_grindrail))) && (!(place_meeting(x, (y + 10), obj_grindrail))) && (!(place_meeting(x, (y + vsp), obj_destructibles))) && (!(place_meeting(x, (y + vsp + 2), obj_destructibles))) && (!(place_meeting(x, (y + 10), obj_destructibles))))  
    {  
        jumpAnim = 1  
        jumpstop = 0  
        if (sprite_index == spr_wm_bombdive || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl)  
        {  
            if (sprite_index == spr_wm_bombdive)  
            {  
                if scr_slope()  
                {  
                    with (instance_place(x, (y + 1), obj_slope))  
                    {  
                        other.xscale = (-sign(image_xscale))  
                        with (instance_create(other.x, other.y, obj_jumpdust))  
                            image_xscale = (-sign(other.image_xscale))  
                        with (other)  
                            scr_wm_doroll(1)  
                        if (other.bombdivesmash > 25)  
                            other.movespeed = 16  
                        else  
                            other.movespeed = 12  
                    }  
                    if (clingexitspeed > movespeed)  
                        movespeed = clingexitspeed  
                    hsp = clingexitspeed * xscale  
                }  
                else  
                {  
                    fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
                    with (obj_camera)  
                    {  
                        shake_mag = 5  
                        shake_mag_acc = 15 / room_speed  
                    }  
                    with (obj_baddie)  
                    {  
                        if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                        {  
                            state = (138 << 0)  
                            if (stunned < 60)  
                                stunned = 60  
                            vsp = -8  
                            image_xscale *= -1  
                            hsp = 0  
                            momentum = 0  
                        }  
                    }  
                    with (obj_camera)  
                    {  
                        shake_mag = 10  
                        shake_mag_acc = 30 / room_speed  
                    }  
                    create_particle(x, (y + 3), (14 << 0), 0)  
                    movespeed = 0  
                    hsp = 0  
                    if (clingexitspeed < 16)  
                    {  
                        if (bombdivesmash > 25)  
                            clingexitspeed = 16  
                        else if (clingexitspeed < 12)  
                            clingexitspeed = 12  
                    }  
                    state = (111 << 0)  
                    image_index = 0  
                    sprite_index = spr_wm_bombdive_land  
                }  
                return;  
            }  
            else  
            {  
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
                with (obj_camera)  
                {  
                    shake_mag = 5  
                    shake_mag_acc = 15 / room_speed  
                }  
                with (obj_baddie)  
                {  
                    if (shakestun && grounded && point_in_camera(x, y, view_camera[0]) && grounded && vsp > 0 && (!invincible) && groundpound)  
                    {  
                        state = (138 << 0)  
                        if (stunned < 60)  
                            stunned = 60  
                        vsp = -8  
                        image_xscale *= -1  
                        hsp = 0  
                        momentum = 0  
                    }  
                }  
                with (obj_camera)  
                {  
                    shake_mag = 10  
                    shake_mag_acc = 30 / room_speed  
                }  
                create_particle(x, (y + 3), (14 << 0), 0)  
            }  
            if (move != 0)  
                xscale = move  
            if (sign(hsp) != move && move != 0)  
                hsp *= -1  
        }  
        image_index = 0  
        state = (121 << 0)  
        scr_wm_doroll()  
        if (key_shoot && (!key_down))  
            scr_wm_dokatana(1)  
    }  
    if (sprite_index == spr_player_mangoboost || sprite_index == spr_player_mangoboostend || sprite_index == spr_player_mangoboostfly || sprite_index == spr_wm_ball_doublejumpl)  
    {  
        if (sign(hsp) != 0)  
            xscale = sign(hsp)  
        if ((!instance_exists(chargeeffectid)) && (!ballvertical))  
        {  
            with (instance_create(x, y, obj_chargeeffect))  
            {  
                playerid = other.object_index  
                other.chargeeffectid = id  
            }  
        }  
        if ((!jumpstop) && vsp < 0.5 && (!key_jump2) && (!jawsup) && (!ballvertical))  
        {  
            vsp /= 10  
            jumpstop = 1  
        }  
        if (sprite_index == spr_player_mangoboostfly && key_jump && (!grounded))  
        {  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
            fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
            sprite_index = spr_wm_ball_doublejumpl  
            jawsup = true  
            vsp = -15  
            if (move != 0)  
                xscale = move  
        }  
        if (sprite_index == spr_player_mangoboostend && (!grounded) && sprite_index != spr_player_mangoboost)  
        {  
            image_index = 0  
            sprite_index = spr_player_mangoboostfly  
        }  
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_mangoboost)  
        {  
            image_index = 2  
            sprite_index = spr_player_mangoboost  
        }  
        if (floor(image_index) == (image_number - 3) && sprite_index == spr_player_mangoboost)  
        {  
            image_index = 0  
            sprite_index = spr_player_mangoboostend  
        }  
        if ((!ballvertical) && place_meeting((x + sign(hsp)), y, obj_solid) && (!(place_meeting((x + hsp), y, obj_metalblock))) && (!(place_meeting((x + hsp), y, obj_destructibles))) && (!(place_meeting((x + hsp), y, obj_mach3solid))))  
        {  
            hoverspin = 15  
            if (ballspeed < 15)  
                ballspeed += 0.5  
            if (vsp < 10)  
                vsp = 10  
            fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
            instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
            xscale *= -1  
            hsp = ballspeed * xscale  
            wethamcombo[4] = 0  
            allowjawsfly = 1  
        }  
        scr_wm_dokatana()  
        if (key_down && (!grounded))  
        {  
            jawsup = false  
            if (vsp < 0)  
                vsp = 0  
            if (vsp < 20)  
                vsp++  
        }  
    }  
    if (hoverspin < 15)  
        hoverspin = 15  
    var spinspid = 0  
    if (max(abs(hsp), abs(vsp)) < 8)  
        spinspid = 8  
    else  
        spinspid = max(abs(hsp), abs(vsp))  
    if (sprite_index == spr_wm_ball_doublejumpl)  
    {  
        hoverspin = Approach(hoverspin, 50, 0.3)  
        image_speed = Approach(image_speed, (spinspid / hoverspin), 1)  
    }  
    else  
    {  
        hoverspin = Approach(hoverspin, 50, 0.1)  
        image_speed = Approach(image_speed, (8 / hoverspin), 1)  
    }  
    if (punch_afterimage > 0)  
        punch_afterimage--  
    else  
    {  
        punch_afterimage = 5  
        with (create_mach3effect(x, y, sprite_index, (image_index - 1)))  
        {  
            image_xscale = other.xscale  
            playerid = other.id  
        }  
    }  
    scr_wm_doyosh()  
    scr_wm_dobombdive()  
    instance_destroy(instance_place(x, (y + vsp), obj_destructibles))  
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))  
    instance_destroy(instance_place(x, (y + vsp), obj_metalblock))  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
}
~~~
### scr_wmp_jaws()

~~~js
function scr_wmp_jaws() //gml_Script_scr_wmp_jaws  
{  
    move = key_left + key_right  
    hsp = xscale * movespeed  
    if (sprite_index != spr_wm_katanaboost)  
    {  
        if (jawsfriction == 0 && grounded)  
        {  
            movespeed = Approach(movespeed, 8, 0.05)  
            if (!instance_exists(obj_jaws_grindeffect))  
                instance_create(x, y, obj_jaws_grindeffect)  
        }  
        else  
            instance_destroy(obj_jaws_grindeffect)  
        if (jawsfriction > 0 && grounded)  
        {  
            jawsfriction--  
            instance_destroy(obj_jaws_grindeffect)  
        }  
    }  
    if scr_wm_dobombdive()  
    {  
        input_buffer_jump = 0  
        return;  
    }  
    if (jawsbuffer > 0)  
    {  
        jawsbuffer--  
        if (vsp > -0.5)  
            vsp = 0  
    }  
    if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        jawsup = 1  
    scr_wm_doroll()  
    if (sprite_index == spr_wm_pounce_slide || sprite_index == spr_wm_pounce_dive)  
    {  
        if (movespeed < 8)  
            movespeed = 8  
        if ((!key_down) && grounded && sprite_index == spr_wm_pounce_slide && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))))  
        {  
            flash = 1  
            sprite_index = spr_wm_pounce  
            if key_shoot  
                image_index = 0  
            else  
            {  
                image_index = 8  
                wmlongjumpbuffer = 1  
            }  
        }  
        if (sprite_index == spr_wm_pounce_dive && grounded)  
        {  
            if (!key_down)  
            {  
                flash = 1  
                sprite_index = spr_wm_pounce  
                if key_shoot  
                    image_index = 0  
                else  
                {  
                    image_index = 8  
                    wmlongjumpbuffer = 1  
                }  
            }  
            else  
                sprite_index = spr_wm_pounce_slide  
        }  
        if ((!grounded) && sprite_index != spr_wm_pounce_dive)  
        {  
            sprite_index = spr_wm_pounce_dive  
            vsp = 10  
        }  
    }  
    if (sprite_index == spr_wm_katanaboost)  
    {  
        if (movespeed < 12)  
            movespeed = 12  
        if (floor(image_index) == (image_number - 1))  
            sprite_index = spr_wm_katanaboost_loop  
        if (floor(image_index) >= 10)  
        {  
            if (grounded && vsp >= 0)  
            {  
                if (move != 0)  
                {  
                    if (xscale != move)  
                        flash = 1  
                    xscale = move  
                }  
                input_buffer_chaos = 0  
                image_index = 0  
                sprite_index = spr_wm_katanaboost_recover  
                state = (121 << 0)  
            }  
        }  
    }  
    if (sprite_index == spr_wm_katanaboost_loop)  
    {  
        if (grounded && vsp >= 0)  
        {  
            if (move != 0)  
            {  
                if (xscale != move)  
                    flash = 1  
                xscale = move  
            }  
            input_buffer_chaos = 0  
            image_index = 0  
            sprite_index = spr_wm_katanaboost_recover  
            state = (121 << 0)  
        }  
    }  
    if (floor(image_index) == (image_number - 1))  
    {  
        if (sprite_index == spr_wm_longjump)  
            sprite_index = spr_wm_longjump_loop  
        if (sprite_index == spr_wm_pounce)  
        {  
            if (movespeed >= 12)  
            {  
                if key_attack  
                {  
                    if (move != 0)  
                    {  
                        if (xscale != move)  
                            flash = 1  
                        xscale = move  
                    }  
                    input_buffer_chaos = 0  
                    sprite_index = spr_mach4  
                    state = (121 << 0)  
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    sprite_index = spr_idle  
                    state = (0 << 0)  
                }  
            }  
            else  
            {  
                input_buffer_chaos = 0  
                state = (0 << 0)  
            }  
        }  
        if (sprite_index == spr_wm_pouncestart_air)  
            sprite_index = spr_wm_pounce_air  
        if (sprite_index == spr_wm_pounce_dj)  
            image_index = image_number - 2  
    }  
    if ((!grounded) && sprite_index != spr_wm_longjump && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_longjump_loop && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop && sprite_index != spr_wm_pouncestart_air && sprite_index != spr_wm_pounce_air && sprite_index != spr_wm_pounce_dj)  
    {  
        image_index = 0  
        sprite_index = spr_wm_pouncestart_air  
    }  
    if ((sprite_index == spr_wm_pouncestart_air || sprite_index == spr_wm_longjump || sprite_index == spr_wm_longjump_loop || sprite_index == spr_wm_pounce_dj || sprite_index == spr_wm_pounce_air) && grounded && vsp > 0.5)  
    {  
        flash = 1  
        sprite_index = spr_wm_pounce  
        if key_shoot  
            image_index = 0  
        else  
        {  
            wmlongjumpbuffer = 1  
            image_index = 8  
        }  
    }  
    scr_wm_doyosh()  
    if (key_jump && (!grounded) && brick && sprite_index != spr_wm_pounce_dj)  
    {  
        input_buffer_jump = 0  
        input_buffer_chaos = 0  
        GamepadSetVibration(0, 0.8, 0.8, 0.65)  
        instance_create(x, y, obj_highjumpcloud2)  
        sprite_index = spr_wm_pounce_dj  
        image_index = 0  
        state = (80 << 0)  
        if key_jump  
            jumpstop = 0  
        else  
            jumpstop = 1  
        if (movespeed < 20)  
        {  
            if (movespeed < 8)  
                movespeed = 8  
            else  
                movespeed += 1  
        }  
        vsp = -11  
    }  
    if scr_wm_lastbreath()  
    {  
        input_buffer_chaos = 0  
        return;  
    }  
    scr_wm_dokatana()  
    if (key_down && (!grounded) && sprite_index != spr_wm_longjump)  
    {  
        jawsup = 0  
        jawsbuffer = 0  
        if (vsp < 0)  
            vsp = 0  
        if (vsp < 20)  
            vsp++  
    }  
    if (place_meeting((x + xscale), y, obj_solid) && (!(place_meeting((x + xscale), y, obj_metalblock))) && (!(place_meeting((x + xscale), y, obj_destructibles))) && jawsbuffer < 23)  
    {  
        if (sprite_index != spr_wm_pounce_dive)  
        {  
            var _climb = ledge_bump(40)  
            if _climb  
            {  
                if ledge_bump((vsp >= 0 ? 32 : 22))  
                    scr_wm_bouncejaws()  
            }  
        }  
        else  
            scr_wm_bouncejaws()  
    }  
    if (grounded && vsp > -0.5 && sprite_index != spr_wm_pounce_slide)  
    {  
        if (input_buffer_jump < 30 && input_buffer_jump != 0)  
        {  
            if wmlongjumpbuffer  
            {  
                if (movespeed >= 12)  
                {  
                    if key_attack  
                    {  
                        if (move != 0)  
                        {  
                            if (xscale != move)  
                                flash = 1  
                            xscale = move  
                        }  
                        input_buffer_chaos = 0  
                        sprite_index = spr_mach4  
                        state = (121 << 0)  
                    }  
                    else  
                    {  
                        input_buffer_chaos = 0  
                        sprite_index = spr_idle  
                        state = (0 << 0)  
                    }  
                }  
                else  
                {  
                    input_buffer_chaos = 0  
                    state = (0 << 0)  
                }  
                wmlongjumpbuffer = 0  
                return;  
            }  
            else  
            {  
                input_buffer_chaos = 0  
                sprite_index = spr_wm_longjump  
                image_index = 0  
                state = (80 << 0)  
                input_buffer_jump = 0  
                if (movespeed < 20)  
                {  
                    if (movespeed < 8)  
                        movespeed = 8  
                }  
                hsp = movespeed * xscale  
                vsp = -11  
                jawsbuffer = 0  
                return;  
            }  
        }  
    }  
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))  
    if (key_shoot && sprite_index == spr_wm_pounce && floor(image_index) > 7 && sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop)  
        image_index = 5  
    if (sprite_index != spr_wm_katanaboost && sprite_index != spr_wm_katanaboost_loop)  
    {  
        if (punch_afterimage > 0)  
            punch_afterimage--  
        else  
        {  
            punch_afterimage = 5  
            with (create_mach3effect(x, y, sprite_index, image_index, 1))  
            {  
                image_xscale = other.xscale  
                playerid = other.id  
            }  
        }  
    }  
    image_speed = 0.35  
}
~~~
### scr_wmp_Sjump()

~~~js
function scr_wmp_Sjump() //gml_Script_scr_wmp_Sjump  
{  
    if (!mangocall)  
    {  
        move = key_left + key_right  
        vsp = tornadospeed  
        if (tornadospeed > -30)  
            tornadospeed -= 0.25  
        if place_meeting(x, (y - 1), obj_solid)  
            hsp = Approach(hsp, (3 * move), 0.25)  
        else  
            hsp = Approach(hsp, (8 * move), 2)  
    }  
    else  
    {  
        hsp = Approach(hsp, 0, 0.1)  
        vsp = Approach(vsp, 0, 3)  
    }  
    if (sprite_index != spr_m_call)  
    {  
        if place_meeting(x, (y - 25), obj_solid)  
        {  
            sprite_index = spr_m_lastbreath_ceiling  
            vsp = -16  
            tornadospeed = vsp  
        }  
        else  
            sprite_index = spr_m_lastbreath  
    }  
    else if (floor(image_index) == (image_number - 1))  
        image_index = image_number - 1  
    if place_meeting(x, y, obj_baddie)  
    {  
        with (obj_baddie)  
        {  
            if place_meeting(x, y, obj_player)  
            {  
                if ((!invincible) && instantkillable)  
                    instance_destroy()  
            }  
        }  
    }  
    if (key_slap2 && (!mangocall))  
    {  
        mangocall = 1  
        image_index = 0  
        sprite_index = spr_m_call  
        instance_create(x, y, obj_wm_note)  
        with (obj_wethamtornado)  
        {  
            if (state == (1 << 0))  
            {  
                sprite_index = spr_tornado_lastbreath_end  
                image_index = 0  
                state = (0 << 0)  
            }  
        }  
        fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/call", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/superjumpcancel", x, y)  
        if instance_exists(obj_wetham_R)  
        {  
            with (obj_wetham_R)  
            {  
                if (!(point_in_camera(x, (y - 30), view_camera[0])))  
                {  
                    y = other.y + 600  
                    while point_in_camera(x, (y - 30), view_camera[0])  
                        y++  
                }  
                image_index = 0  
                sprite_index = spr_w_megaslash  
            }  
        }  
        else  
        {  
            with (instance_create(x, (y + 600), obj_wetham_R))  
            {  
                notfade = 1  
                while point_in_camera(x, (y - 30), view_camera[0])  
                    y++  
                image_index = 0  
                sprite_index = spr_w_megaslash  
            }  
        }  
    }  
    scr_collide_player()  
}
~~~
### scr_wmp_attackprep()

~~~js
function scr_wmp_attackprep() //gml_Script_scr_wmp_attackprep  
{  
    move = key_left + key_right  
    if (sprite_index == spr_wm_balltokatana)  
        hsp = Approach(hsp, 0, 0.5)  
    else if (sprite_index == spr_lonegustavo_kick)  
    {  
        hsp = movespeed * (-xscale)  
        movespeed = Approach(movespeed, 0, 0.25)  
    }  
    else if (sprite_index == spr_wetham_machmango_kick)  
        hsp = movespeed * xscale  
    else  
        hsp = Approach(hsp, 0, 1)  
    if (sprite_index != spr_lonegustavo_kick)  
        vsp = 0  
    if (move != 0)  
        xscale = move  
    if (floor(image_index) == (image_number - 1))  
    {  
        switch sprite_index  
        {  
            case spr_wm_balltokatana:  
                movespeed = clingexitspeed  
                if (movespeed < 15)  
                {  
                    movespeed = 15  
                    with (instance_create(x, y, obj_wethamtornado))  
                    {  
                        state = (0 << 0)  
                        image_xscale = other.xscale  
                        image_speed = 0.45  
                        image_alpha = 0.8  
                        sprite_index = spr_w_windpulse  
                    }  
                    fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
                }  
                if allowjawsfly  
                    jawsbuffer = 25  
                allowjawsfly = 0  
                image_index = 0  
                sprite_index = spr_w_spinkick  
                state = (121 << 0)  
                if grounded  
                    vsp = -4  
                else  
                    vsp = 0  
                if (brick == 1)  
                {  
                    fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", (x + xscale * 32), y)  
                    with (instance_create((x + xscale * 40 * -1), y, obj_mango_companion))  
                    {  
                        vsp = 0  
                        image_xscale = other.xscale  
                        if (other.movespeed > 13)  
                            hsp = image_xscale * other.movespeed * 0.33  
                        state = (3 << 0)  
                        image_index = 0  
                        sprite_index = spr_m_flykick  
                    }  
                    brick = 0  
                }  
                return;  
            case 4971:  
                flash = 1  
                if (move != 0)  
                    xscale = move  
                input_buffer_jump = 0  
                particle_set_scale((4 << 0), xscale, 1)  
                create_particle(x, y, (4 << 0), 0)  
                movespeed = 17  
                hsp = movespeed * move  
                sprite_index = spr_mach4  
                image_index = 0  
                jumpAnim = 1  
                state = (121 << 0)  
                vsp = -4  
                jumpstop = 0  
                if key_down  
                {  
                    input_buffer_down = 0  
                    state = (5 << 0)  
                    sprite_index = spr_dive  
                    if (brick == 1)  
                    {  
                        with (instance_create(x, y, obj_mango_companion))  
                            wait = 1  
                        brick = 0  
                    }  
                }  
                break  
            case 4855:  
                state = (3 << 0)  
                sprite_index = spr_w_lastbreath_travel  
                create_particle(x, (y + 3), (14 << 0), 0)  
                return;  
            case 629:  
                if grounded  
                {  
                    landAnim = 0  
                    state = (0 << 0)  
                }  
                else  
                {  
                    sprite_index = spr_fall  
                    state = (92 << 0)  
                }  
                break  
            case 4984:  
                spr_mach4 = spr_wetham_machslash  
                spr_mach3jump = 4913  
                sprite_index = spr_mach4  
                katanatype = 1  
                state = (121 << 0)  
                break  
        }  
  
    }  
    if (sprite_index == spr_wm_balltochomp)  
    {  
        if (input_buffer_slap < 30 && input_buffer_slap != 0)  
        {  
            flash = 1  
            movespeed = 17  
            hsp = movespeed * move  
            with (instance_create(x, y, obj_wethamtornado))  
            {  
                state = (0 << 0)  
                image_xscale = other.xscale  
                image_speed = 0.45  
                image_alpha = 0.8  
                sprite_index = spr_w_windpulse  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
            if allowjawsfly  
                jawsbuffer = 25  
            allowjawsfly = 0  
            image_index = 0  
            sprite_index = spr_w_spinkick  
            state = (121 << 0)  
            if grounded  
                vsp = -4  
            else  
                vsp = 0  
            if (brick == 1)  
            {  
                fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", (x + xscale * 32), y)  
                with (instance_create((x + xscale * 40 * -1), y, obj_mango_companion))  
                {  
                    vsp = 0  
                    image_xscale = other.xscale  
                    if (other.movespeed > 13)  
                        hsp = image_xscale * other.movespeed * 0.33  
                    state = (3 << 0)  
                    image_index = 0  
                    sprite_index = spr_m_flykick  
                }  
                brick = 0  
            }  
            return;  
        }  
        if (input_buffer_chaos < 30 && input_buffer_chaos != 0)  
        {  
            flash = 1  
            movespeed = 17  
            hsp = movespeed * move  
            scr_wm_dokatana(1)  
            return;  
        }  
    }  
    if ((sprite_index == spr_wm_balltokatana || sprite_index == spr_wm_balltochomp) && key_up && (!wethamcombo[4]))  
    {  
        if (move != 0)  
            xscale = move  
        ballvertical = 1  
        if (movespeed < 14)  
        {  
            ballspeed = 14  
            movespeed = 14  
        }  
        else  
            ballspeed = movespeed  
        input_buffer_chaos = 0  
        jumpstop = 1  
        hsp = 0  
        if grounded  
            vsp = -20  
        else  
            vsp = -15  
        state = (198 << 0)  
        image_index = 0  
        sprite_index = spr_wm_ball_doublejumpl  
        flash = 1  
        fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
        fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/uppercut", x, y)  
        instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
        wethamcombo[4] = 1  
        scr_wmp_ballmode()  
        return;  
    }  
    if (sprite_index == spr_wm_balltokatana && key_down && (!wethamcombo[4]))  
    {  
        scr_wm_dobombdive()  
        return;  
    }  
    if (movespeed >= 15 && sprite_index == spr_wm_balltokatana)  
        image_speed = 0.85  
    else if (sprite_index == spr_wm_balltokatana || sprite_index == spr_wetham_machmango_kick)  
        image_speed = 0.65  
    else  
        image_speed = 0.35  
}
~~~
### scr_wmp_megadash()

~~~js
function scr_wmp_megadash() //gml_Script_scr_wmp_megadash  
{  
    if instance_exists(obj_mango_brickball)  
    {  
        var distance = distance_to_point(obj_mango_brickball.x, obj_mango_brickball.y)  
        angle = point_direction(x, y, obj_mango_brickball.x, obj_mango_brickball.y)  
        var _speed = 95  
        if (distance < 95)  
            _speed = distance  
        x += lengthdir_x(_speed, angle)  
        y += lengthdir_y(_speed, angle)  
        xscale = 1  
        if (distance <= 100)  
        {  
            move = key_left + key_right  
            x = obj_mango_brickball.x  
            y = obj_mango_brickball.y  
            mangocall = 0  
            brick = 1  
            flash = 1  
            state = (23 << 0)  
            sprite_index = spr_wm_balltochomp  
            image_index = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/superjumpcancel", x, y)  
            with (obj_mango_brickball)  
                instance_destroy()  
        }  
    }  
    else  
        state = (0 << 0)  
}
~~~
## Executers
### scr_wm_bouncejaws()
Support function for ease in executing ball bouncing
Referenced in:
- This here moveset
- [[WM - Changes to vainilla game#scr_player_bump()]]
~~~js
function scr_wm_bouncejaws(argument0) //gml_Script_scr_wm_bouncejaws  
{  
    if (argument0 == undefined)  
        argument0 = 0  
    if (((grounded && (!key_jump2) && (!(place_meeting(x, (y + 1), obj_destructibles)))) || sprite_index == spr_wm_pounce_slide) && (!argument0))  
    {  
        xscale *= -1  
        jawsfriction = 50  
        image_index = 0  
    }  
    else  
    {  
        if (movespeed < 14)  
        {  
            ballspeed = 14  
            movespeed = 14  
        }  
        else  
            ballspeed = movespeed  
        input_buffer_chaos = 0  
        jumpstop = 1  
        hsp = 4  
        vsp = 4  
        if (key_jump2 || jawsup)  
            vsp = -4  
        if key_down  
        {  
            vsp = 10  
            jawsup = 0  
        }  
        if ((!jawsup) && argument0)  
            vsp = -6  
        state = (198 << 0)  
        image_index = 0  
        sprite_index = spr_player_mangoboostfly  
        xscale *= -1  
        flash = 1  
        hoverspin = 15  
        wethamcombo[1] = 0  
        allowjawsfly = 1  
        scr_wmp_ballmode()  
    }  
    fmod_event_one_shot_3d("event:/sfx/pep/splat", x, y)  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump1", x, y)  
    instance_create((x + xscale * 10), (y + 20), obj_bumpeffect)  
}
~~~
[^1]: argument0 : *direction change (true) or full ball mode (false)* | boolean
### scr_wm_doroll()

~~~js
function scr_wm_doroll(argument0) //gml_Script_scr_wm_doroll  
{  
    if (argument0 == undefined)  
        argument0 = false  
    var gap = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_solid, 0, 1)  
    var dx = collision_line(x, (y + 20), (x + 50 * xscale), (y + 20), obj_destructibles, 0, 1)  
    var divex = (state == (111 << 0) && key_attack && move != 0)  
    if ((((((move != 0 || key_attack) && key_down) || divex) && (gap == 4 || gap == -4 || (dx != -4 && dx != 4))) || argument0) && grounded && sprite_index != spr_wm_pounce_slide)  
    {  
        input_buffer_chaos = 0  
        if (state != (80 << 0) && state != (198 << 0))  
            input_buffer_down = 0  
        var hasM = (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked))  
        if ((state == (80 << 0) || state == (198 << 0) || (key_shoot && hasM)) && sprite_index != spr_wm_bombdive)  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            if instance_exists(obj_brickcomeback)  
            {  
                with (obj_brickcomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            state = (5 << 0)  
            image_index = 0  
            sprite_index = spr_wm_pounce_slide  
        }  
        else  
        {  
            if (state == (111 << 0))  
                movespeed = clingexitspeed  
            if (move != 0 && (!argument0))  
                xscale = move  
            wrollbuffer = 10  
            image_index = 0  
            sprite_index = spr_wm_roll  
            image_speed = 0.35  
            with (instance_create(x, y, obj_dashcloud))  
            {  
                image_xscale = other.xscale  
                other.dashcloudid = id  
            }  
            state = (100 << 0)  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
        }  
    }  
}
~~~
[^1]: argument0 : *force* | boolean
### scr_wm_dokatanaslash

~~~js
function scr_wm_dokatana(argument0, argument1) //gml_Script_scr_wm_dokatana  
{  
    if (argument0 == undefined)  
        argument0 = false  
    if (argument1 == undefined)  
        argument1 = false  
    var lj_th = -8.5  
    move = key_left + key_right  
    if ((((((input_buffer_chaos < 30 && input_buffer_chaos != 0) || (sprite_index == spr_wethamdivel && key_shoot)) && sprite_index != spr_wm_pounce_dive && sprite_index != spr_wm_pounce_slide && (state != (80 << 0) || sprite_index == spr_wm_longjump || sprite_index == spr_wm_longjump_loop)) || (state == (121 << 0) && grounded && vsp > 0.5 && key_shoot && sprite_index != spr_wm_katanaboost)) && (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked))) || argument0)  
    {  
        if (wethamcombo[1] == 0)  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            if instance_exists(obj_brickcomeback)  
            {  
                with (obj_brickcomeback)  
                    instance_destroy()  
                instance_create(other.x, other.y, obj_genericpoofeffect)  
                flash = 1  
                brick = 1  
            }  
            input_buffer_slap = 0  
            fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
            if (move != 0 && state != (37 << 0))  
                xscale = move  
            if (state != (23 << 0))  
            {  
                if (vsp < -0.5)  
                    jawsup = 1  
                else  
                    jawsup = 0  
            }  
            image_index = 0  
            if (state == (37 << 0))  
            {  
                with (instance_create(x, y, obj_wethamtornado))  
                {  
                    state = (0 << 0)  
                    image_xscale = 1.5  
                    image_yscale = 1.5  
                    image_speed = 0.45  
                    image_alpha = 0.8  
                    sprite_index = spr_w_windspin  
                }  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
                vsp = 0  
                move = 0  
                movespeed = clingexitspeed  
                xscale *= -1  
            }  
            if (allowjawsfly && (!grounded) && vsp > lj_th)  
                jawsbuffer = 25  
            if (movespeed > 18)  
                movespeed = 18  
            if (movespeed < 8)  
                movespeed = 8  
            if (state == (2 << 0) || sprite_index == spr_wethamcansh)  
            {  
                if (sprite_index == spr_w_spinkick)  
                    wethamcombo[3] = 1  
                wethamcombo[1] = 1  
                if (fakehsp != 0)  
                    movespeed = fakehsp  
                if ((fakehsp < 13.5 && kpulsebuffer > 0 && (!grounded)) || (grounded && movespeed < 13.5))  
                {  
                    movespeed = 13.5  
                    with (instance_create(x, y, obj_wethamtornado))  
                    {  
                        state = (0 << 0)  
                        image_xscale = other.xscale  
                        image_speed = 0.45  
                        image_alpha = 0.8  
                        sprite_index = spr_w_windpulse  
                    }  
                    fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
                }  
                kpulsebuffer = 0  
                fakehsp = 0  
            }  
            if ((!grounded) && vsp > lj_th)  
                vsp = 0  
            if (state == (105 << 0))  
                movespeed = 8  
            hsp = movespeed * xscale  
            if (state == (2 << 0) || sprite_index == spr_wethamcansh)  
            {  
                image_index = 0  
                input_buffer_chaos = 0  
                sprite_index = spr_wm_katanaboost  
                state = (121 << 0)  
                return;  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/pounce", x, y)  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/mango/mdash", x, y)  
            jawsfriction = 40  
            state = (80 << 0)  
            if (vsp > lj_th)  
                sprite_index = spr_wm_pounce  
            else  
            {  
                sprite_index = spr_wm_longjump  
                input_buffer_chaos = 0  
            }  
            return;  
        }  
    }  
    var wallbuffer = (state == (37 << 0) && wallclingbuffer > 0 && move != (xscale * -1))  
    var ducking = (scr_solid(x, (y - 16)) && scr_solid(x, (y - 32)) && (state == (5 << 0) || sprite_index == spr_wm_pounce_slide))  
    if ((input_buffer_slap > 0 && state != (108 << 0) && state != (2 << 0) && sprite_index != spr_w_spinkick && (!ducking)) || argument1)  
    {  
        if (wallbuffer && (!argument1))  
            return;  
        if scr_wmp_uppercut()  
            return;  
        if (!wethamcombo[3])  
        {  
            input_buffer_chaos = 0  
            var k = false  
            input_buffer_slap = 0  
            if (movespeed < 8)  
                movespeed = 8  
            particle_set_scale((5 << 0), xscale, 1)  
            create_particle(x, y, (5 << 0), 0)  
            jumpstop = 0  
            input_buffer_slap = 0  
            if (state == (37 << 0))  
            {  
                with (instance_create(x, y, obj_wethamtornado))  
                {  
                    state = (0 << 0)  
                    image_xscale = 1.5  
                    image_yscale = 1.5  
                    image_speed = 0.45  
                    image_alpha = 0.8  
                    sprite_index = spr_w_windspin  
                }  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
                xscale *= -1  
                if place_meeting(x, y, obj_destructibles)  
                    xscale *= -1  
                if (clingexitspeed >= 16)  
                    movespeed = clingexitspeed  
                else  
                    movespeed = 16  
                katanawallexit = 1  
            }  
            else if (move != 0)  
                xscale = move  
            if (state == (80 << 0))  
                wethamcombo[3] = 1  
            if (state == (80 << 0) || (state == (198 << 0) && ballvertical == 0) || (state == (121 << 0) && (sprite_index == spr_wm_katanaboost || sprite_index == spr_wm_katanaboost_loop)))  
            {  
                if (state == (80 << 0) && move != xscale && move != 0)  
                    movespeed = 0  
                else  
                {  
                    state = (23 << 0)  
                    sprite_index = spr_wm_balltokatana  
                    image_index = 0  
                    fmod_event_one_shot_3d("event:/sfx/misc/comboend", x, y)  
                    fmod_event_one_shot_3d("event:/sfx/misc/toppingot", x, y)  
                    return;  
                }  
            }  
            if (state == (198 << 0))  
            {  
                k = true  
                if (movespeed < 17)  
                {  
                    with (instance_create(x, y, obj_wethamtornado))  
                    {  
                        state = (0 << 0)  
                        image_xscale = other.xscale  
                        image_speed = 0.45  
                        image_alpha = 0.8  
                        sprite_index = spr_w_windpulse  
                    }  
                    fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/speedboost", x, y)  
                }  
                with (instance_create(x, y, obj_wethamtornado))  
                {  
                    state = (0 << 0)  
                    image_xscale = 1.5  
                    image_yscale = 1.5  
                    image_speed = 0.45  
                    image_alpha = 0.8  
                    sprite_index = spr_w_windspin  
                }  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/windwhirl", x, y)  
            }  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/slashmiss", x, y)  
            if (state == (105 << 0))  
                movespeed = 8  
            scr_wm_katanapulse(k)  
            state = (2 << 0)  
            image_index = 0  
            if (katanatype == 1)  
            {  
                sprite_index = spr_wethamslash2  
                katanatype = 2  
            }  
            else  
            {  
                sprite_index = spr_wethamslash  
                katanatype = 1  
            }  
            slashstored++  
            if (brick == 1)  
            {  
                with (instance_create(x, y, obj_mango_companion))  
                    wait = 1  
                brick = 0  
            }  
            return;  
        }  
    }  
    if (key_shoot2 && brickcallbuffer > 0)  
    {  
        if wm_mangokick()  
            return;  
    }  
}
~~~
[^1]: argument0 : *force Mango jaws* | boolean
[^2]: argument1 : *force Katana slash* | boolean
### scr_wm_dodoublejump()

~~~js
function scr_wm_dodoublejump() //gml_Script_scr_wm_dodoublejump  
{  
    if (place_meeting(x, (y + 16), obj_solid) || place_meeting(x, (y + 16), obj_slope))  
        return;  
    if (key_jump && (!grounded) && (brick || instance_exists(obj_mango_companion)) && sprite_index != spr_wm_djump)  
    {  
        if (!wethamcombo[0])  
        {  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            input_buffer_jump = 0  
            image_speed = 0.9  
            GamepadSetVibration(0, 0.8, 0.8, 0.65)  
            instance_create(x, y, obj_highjumpcloud2)  
            sprite_index = spr_wm_djump  
            image_index = 0  
            if key_jump  
                jumpstop = 0  
            else  
                jumpstop = 1  
            if (move != 0)  
            {  
                if (movespeed < 20)  
                {  
                    if (movespeed < 8)  
                        movespeed = 8  
                }  
                hsp = movespeed * xscale  
                vsp = -15  
            }  
            else  
            {  
                vsp = -18  
                jumpstop = 1  
            }  
            if (state != (121 << 0))  
                state = (104 << 0)  
            wethamcombo[0] = 1  
            wethamcombo[1] = 0  
            wethamcombo[3] = 0  
            wethamcombo[4] = 0  
            return;  
        }  
        else if key_jump  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    }  
}
~~~
### scr_wmp_doyosh()

~~~js
function scr_wm_doyosh() //gml_Script_scr_wm_doyosh  
{  
    if (key_jump && (brick || instance_exists(obj_mango_companion)) && key_up && (!grounded))  
    {  
        if (!wethamcombo[2])  
        {  
            input_buffer_chaos = 0  
            if instance_exists(obj_mango_companion)  
            {  
                with (obj_mango_companion)  
                    instance_destroy()  
                flash = 1  
                fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
                instance_create(x, y, obj_wm_note)  
                brick = 1  
            }  
            fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
            jumpAnim = 1  
            vsp = -20  
            state = (92 << 0)  
            sprite_index = spr_stompprep  
            image_index = 0  
            image_speed = 0.35  
            gustavokicktimer = 5  
            jumpstop = 0  
            brick = 0  
            with (instance_create(x, (y + 50), obj_ratmountgroundpound))  
            {  
                vsp = 11  
                image_xscale = other.xscale  
                image_index = 0  
            }  
            wethamcombo[0] = 0  
            wethamcombo[1] = 0  
            wethamcombo[2] = 1  
            wethamcombo[3] = 0  
            return;  
        }  
        else  
            fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)  
    }  
    if (key_jump && instance_exists(obj_mangoghost) && key_up)  
    {  
        if (obj_mangoghost.state == (0 << 0) && (!obj_mangoghost.hide))  
        {  
            jumpstop = 0  
            fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
            jumpAnim = 1  
            vsp = -15  
            state = (92 << 0)  
            sprite_index = spr_stompprep  
            image_index = 0  
            image_speed = 0.35  
            gustavokicktimer = 5  
            with (obj_mangoghost)  
            {  
                state = (1 << 0)  
                image_alpha = target_alpha  
                x = obj_player.x  
                y = obj_player.y  
            }  
        }  
        return;  
    }  
}
~~~
### scr_wm_dowallcling()

~~~js
function scr_wm_dowallcling() //gml_Script_scr_wm_dowallcling  
{  
    wallstick = 0  
    input_buffer_chaos = 0  
    clingexitspeed = movespeed  
    if (state == (121 << 0))  
    {  
        if (vsp > -10)  
            vsp = -10  
        if (sprite_index == spr_wm_djump && vsp > 0)  
            vsp = -14  
    }  
    if (state != (92 << 0))  
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
    state = (37 << 0)  
    if (sprite_index != spr_wm_wallclimb)  
        wallclingbuffer = 5  
    kpulsebuffer = 0  
    fakehsp = 0  
}
~~~
### scr_wetham
==Obsolete script, should restructure it. Here is the important stuff==
#### scr_wm_lastbreath()
~~~js
function scr_wm_lastbreath() //gml_Script_scr_wm_lastbreath  
{  
    var g_ex = (place_meeting(x, (y + 20), obj_solid) || place_meeting(x, (y + 20), obj_slope))  
    if (((key_shoot && key_up) || key_superjump) && (grounded || g_ex) && (brick || instance_exists(obj_mango_companion)))  
    {  
        if instance_exists(obj_mango_companion)  
        {  
            with (obj_mango_companion)  
                instance_destroy()  
            flash = 1  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
            instance_create(x, y, obj_wm_note)  
        }  
        brick = 1  
        fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, (y + 50))  
        state = (97 << 0)  
        scr_mango_superjump()  
        sprite_index = spr_m_lastbreath  
        image_index = 0  
        image_speed = 0.35  
        instance_create(x, y, obj_wetham_R)  
        tornadospeed = -16  
        with (instance_create(x, y, obj_wethamtornado))  
        {  
            state = (1 << 0)  
            image_speed = 0.66  
            image_alpha = 0.25  
            sprite_index = spr_tornado_lastbreath  
        }  
        with (instance_create(x, y, obj_wethamtornado))  
        {  
            state = (0 << 0)  
            image_index = 0  
            image_speed = 0.45  
            image_alpha = 0.8  
            sprite_index = spr_R_lastbreath  
        }  
        vsp = -16  
        return 1;  
    }  
    return 0;  
}
~~~
### scr_wm_dobombdive()

~~~js
function scr_wm_dobombdive(argument0) //gml_Script_scr_wm_dobombdive  
{  
    if (argument0 == undefined)  
        argument0 = false  
    move = key_left + key_right  
    var longjumpexec = (sprite_index == spr_wetham_longjump || sprite_index == spr_wetham_longjump_loop)  
    if ((((brick || instance_exists(obj_mango_companion) || (instance_exists(obj_brickcomeback) && obj_brickcomeback.sprite_index == spr_m_flykicked)) && (!grounded) && (key_down || sprite_index == spr_wethamdivel || state == (108 << 0)) && ((key_jump2 && (!longjumpexec)) || (longjumpexec && input_buffer_jump < 30 && input_buffer_jump != 0))) || argument0) && sprite_index != spr_wm_bombdive)  
    {  
        mask_index = spr_player_mask  
        if (movespeed > 18)  
            movespeed = 18  
        ballspeed = movespeed  
        input_buffer_down = 0  
        input_buffer_jump = 0  
        if (state != (111 << 0))  
            clingexitspeed = movespeed  
        if (state != (198 << 0))  
        {  
            state = (198 << 0)  
            scr_wmp_ballmode()  
        }  
        while place_meeting(x, y, obj_solid)  
            y++  
        if instance_exists(obj_mango_companion)  
        {  
            with (obj_mango_companion)  
                instance_destroy()  
            flash = 1  
            fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/call", x, y)  
            instance_create(x, y, obj_wm_note)  
            brick = 1  
        }  
        if instance_exists(obj_brickcomeback)  
        {  
            with (obj_brickcomeback)  
                instance_destroy()  
            instance_create(other.x, other.y, obj_genericpoofeffect)  
            flash = 1  
            brick = 1  
        }  
        fmod_event_one_shot_3d("event:/sfx/pep/grabcancel", x, y)  
        if ((place_meeting(x, y, obj_stairs) || place_meeting(x, y, obj_ladder)) && state == (108 << 0))  
            vsp = 0  
        else  
            vsp = -6  
        bombdivesmash = 0  
        image_index = 0  
        sprite_index = spr_wm_bombdive  
        return 1;  
    }  
    return 0;  
}
~~~
[^1]: argument0 : *force* | boolean