function scr_wmp_jump()
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
                create_debris(x, y, spr_feather)  
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
        state = states.jump
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
        particle_set_scale(particletypes.highjumpcloud2, xscale, 1)  
        create_particle(x, y, particletypes.highjumpcloud2, 0)  
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
        state = states.normal 
        jumpAnim = 1  
        jumpstop = 0  
        freefallstart = 0  
        create_particle(x, y, particletypes.landcloud, 0)  
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
            state = states.freefall
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
            state = states.freefall 
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
            notification_push(notifications.shotgun_shot, [room])  
            state = states.shotgunshoot
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
        state = states.freefallland
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
            scr_pistolshoot(states.jump)  
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
                state = states.pistol
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
        state = states.crouch
        landAnim = 0  
        crouchAnim = 1  
        image_index = 0  
        idle = 0  
    }  
}