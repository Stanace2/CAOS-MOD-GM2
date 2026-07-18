Pretty long function, may create a new script for recursive events
~~~js
function scr_chaoschaser_collision_manager() //gml_Script_scr_chaoschaser_collision_manager  
{  
    var relhitlag = 40  
    if (state != (3 << 0) && state != (5 << 0) && awake && (place_meeting(x, y, targetplayer) || place_meeting(x, y, obj_parryhitbox)) && (!targetplayer.cutscene) && targetplayer.state != (146 << 0) && (!instance_exists(obj_fadeout)) && (!instance_exists(obj_endlevelfade)) && image_alpha >= 1)  
    {  
        var transhit = ((targetplayer.state == (47 << 0) && targetplayer.sprite_index == targetplayer.spr_knightpepdowntrust) || (targetplayer.state == (10 << 0) && targetplayer.sprite_index == targetplayer.spr_firemouthdash) || targetplayer.state == (116 << 0) || targetplayer.state == (34 << 0) || targetplayer.state == (21 << 0))  
        if ((targetplayer.state == (79 << 0) && targetplayer.sprite_index == targetplayer.spr_swingding) || targetplayer.state == (76 << 0) || targetplayer.state == (38 << 0) || transhit || targetplayer.state == (254 << 0) || global.noisejetpack || targetplayer.state == (197 << 0) || targetplayer.sprite_index == spr_lonegustavo_mach3 || targetplayer.sprite_index == spr_wethamslash2 || targetplayer.sprite_index == spr_wethamslash || targetplayer.sprite_index == spr_lonegustavo_dashjump || targetplayer.sprite_index == spr_lonegustavo_kick)  
        {  
            if ((!transhit) && (!global.noisejetpack) && (!targetplayer.isgustavo))  
                global.combotime = 60  
            if (targetplayer.state == (76 << 0) && targetplayer.key_jump)  
                targetplayer.vsp = -11  
            fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
            if (targetplayer.state != (254 << 0))  
                fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
            repeat (3)  
            {  
                with (create_debris(x, y, 1646))  
                {  
                    hsp = random_range(-5, 5)  
                    vsp = random_range(-10, 10)  
                }  
            }  
            instance_create(x, y, obj_bangeffect)  
            image_alpha = 1  
            state = (3 << 0)  
            hitLagX = other.x  
            hitLagY = other.y  
            if (!global.noisejetpack)  
            {  
                hitlag = relhitlag  
                alarm[4] = 100  
            }  
            else  
            {  
                hitlag = relhitlag / 2  
                alarm[4] = 75  
            }  
            ragebuffer = 0  
            return;  
        }  
    }  
    if (sprite_index == spr_caos_hauntloop && (!iframes) && state != (3 << 0) && state != (5 << 0) && awake && (place_meeting(x, y, targetplayer) || place_meeting(x, y, obj_parryhitbox)) && (!targetplayer.cutscene) && targetplayer.state != (146 << 0) && (!instance_exists(obj_fadeout)) && (!instance_exists(obj_endlevelfade)) && image_alpha >= 1)  
    {  
        if hasmort  
        {  
            scr_hurtplayer(targetplayer)  
            fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
            fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
            state = (5 << 0)  
            ragebuffer += 50  
            movespeed = -8  
            return;  
        }  
        var transfo = (targetplayer.state == (47 << 0) || targetplayer.state == (38 << 0) || targetplayer.state == (49 << 0) || targetplayer.state == (61 << 0) || targetplayer.state == (10 << 0) || targetplayer.state == (16 << 0) || targetplayer.state == (31 << 0) || targetplayer.state == (113 << 0) || targetplayer.state == (114 << 0) || targetplayer.state == (115 << 0) || targetplayer.state == (116 << 0) || targetplayer.state == (33 << 0) || targetplayer.state == (34 << 0) || targetplayer.state == (35 << 0))  
        if ((targetplayer.state == (84 << 0) || place_meeting(x, y, obj_parryhitbox) || targetplayer.supercharged) && (!transfo))  
        {  
            state = (5 << 0)  
            with (targetplayer)  
            {  
                if (state == (184 << 0) || state == (185 << 0))  
                {  
                    with (instance_create(x, (y + 12), obj_rocketdead))  
                    {  
                        hsp = other.xscale * 6  
                        vsp = 5  
                        image_xscale = sign(hsp)  
                    }  
                }  
                if (state != (84 << 0))  
                {  
                    with (obj_baddie)  
                    {  
                        if (point_in_camera(x, y, view_camera[0]) && supertauntable)  
                        {  
                            hp = -99  
                            state = (137 << 0)  
                            hitLag = 20  
                            hitX = x  
                            hitY = y  
                            if elite  
                            {  
                                elitehit = -1  
                                mach3destroy = 1  
                            }  
                            instance_create(x, y, obj_parryeffect)  
                            alarm[3] = 3  
                            instance_create(x, y, obj_slapstar)  
                            instance_create(x, y, obj_slapstar)  
                            instance_create(x, y, obj_slapstar)  
                            instance_create(x, y, obj_baddiegibs)  
                            instance_create(x, y, obj_baddiegibs)  
                            instance_create(x, y, obj_baddiegibs)  
                            with (obj_camera)  
                            {  
                                shake_mag = 3  
                                shake_mag_acc = 3 / room_speed  
                            }  
                        }  
                    }  
                    other.movespeed = -14  
                    fmod_event_one_shot_3d("event:/sfx/pep/supertaunt", x, y)  
                    supercharged = 0  
                    supercharge = 0  
                    with (obj_camera)  
                    {  
                        shake_mag = 10  
                        shake_mag_acc = 30 / room_speed  
                    }  
                    other.ragebuffer = 0  
                }  
                else  
                {  
                    other.ragebuffer += 50  
                    other.movespeed = -8  
                }  
                parry_lethal = 0  
                if (state != (147 << 0))  
                    fmod_event_one_shot_3d("event:/sfx/pep/parry", x, y)  
                if isgustavo  
                    tauntstoredisgustavo = 1  
                state = (147 << 0)  
                if (!isgustavo)  
                    sprite_index = choose(spr_parry1, spr_parry2, spr_parry3)  
                else if brick  
                    sprite_index = spr_player_ratmountspit  
                else  
                    sprite_index = spr_lonewetham_parry  
                image_index = 0  
                image_speed = 0.35  
                taunttimer = 20  
                movespeed = 8  
                parry_inst = -4  
                parry_count = parry_max  
                with (instance_create(x, y, obj_parryeffect))  
                    image_xscale = other.xscale  
                flash = 1  
            }  
            return;  
        }  
        if targetplayer.isgustavo  
        {  
            if (instance_exists(obj_brickball) || instance_exists(obj_ratmountgroundpound) || instance_exists(obj_brickcomeback))  
            {  
                targetplayer.visible = 0  
                visible = 0  
                if instance_exists(obj_brickball)  
                    obj_brickball.visible = 0  
                if instance_exists(obj_ratmountgroundpound)  
                    obj_ratmountgroundpound.visible = 0  
                if instance_exists(obj_brickcomeback)  
                    obj_brickcomeback.visible = 0  
                if (!visible)  
                    instance_create(x, y, obj_savethepresident)  
                return;  
            }  
            if targetplayer.brick  
            {  
                fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
                fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
                with (obj_player1)  
                {  
                    brick = 0  
                    state = (192 << 0)  
                    vsp = -14  
                    jumpAnim = 1  
                    ratmount_fallingspeed = 0  
                    ratmount_movespeed = 10  
                    movespeed = xscale * ratmount_movespeed  
                    fmod_event_one_shot_3d("event:/sfx/ratmount/walljump2", x, y)  
                    sprite_index = spr_wethamwalljump  
                }  
                state = (5 << 0)  
                ragebuffer += 50  
                movespeed = -8  
                with (instance_create(obj_player1.x, obj_player1.y, obj_sausageman_dead))  
                {  
                    hsp = irandom_range(-5, 5)  
                    vsp = (-(irandom_range(6, 11)))  
                    usepalette = 1  
                    sprite_index = spr_mango_dead  
                    spr_palette = 3365  
                    paletteselect = obj_player1.paletteselect  
                    oldpalettetexture = global.palettetexture  
                }  
                instance_create(x, y, obj_mangoghost)  
                return;  
            }  
        }  
        trstored = targetplayer.state  
        with (targetplayer)  
        {  
            if (state == (31 << 0))  
            {  
                with (instance_create(x, y, obj_weeniemount))  
                {  
                    buffer = 30  
                    depth = -2  
                    image_xscale = other.xscale  
                }  
            }  
            if (state == (184 << 0) || state == (185 << 0))  
            {  
                with (instance_create(x, (y + 12), obj_rocketdead))  
                {  
                    hsp = other.xscale * 6  
                    vsp = 5  
                    image_xscale = sign(hsp)  
                }  
            }  
            if instance_exists(obj_mangoghost)  
            {  
                with (obj_mangoghost)  
                {  
                    create_particle(x, y, (9 << 0))  
                    state = (0 << 0)  
                    image_alpha = 0  
                }  
            }  
            vsp = 0  
            hsp = 0  
            movespeed = 0  
            state = (8 << 0)  
            visible = 0  
        }  
        image_alpha = 1  
        image_index = 0  
        sprite_index = spr_caos_munch  
        state = (6 << 0)  
    }  
    if (state != (3 << 0) && state != (5 << 0) && awake && place_meeting(x, y, obj_baddie))  
    {  
        global.combotime = 60  
        with (obj_baddie)  
        {  
            if (thrown && linethrown && place_meeting(x, y, obj_chaoschaser))  
            {  
                other.image_alpha = 1  
                other.state = (3 << 0)  
                other.hitLagX = other.x  
                other.hitLagY = other.y  
                other.hitlag = relhitlag  
                other.alarm[4] = 150  
                other.ragebuffer = 0  
                if (((!elite) || elitehit <= 0) && elitehurt && destroyable)  
                    instance_destroy()  
                thrown = 0  
                fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
                fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
                repeat (3)  
                {  
                    with (create_debris(x, y, 1646))  
                    {  
                        hsp = random_range(-5, 5)  
                        vsp = random_range(-10, 10)  
                    }  
                }  
                instance_create(x, y, obj_bangeffect)  
                return;  
            }  
            var checkBaddie = (invincible || (!instantkillable))  
            var instakill = 1  
            if (other.targetplayer.baddiegrabbedID == id && (other.targetplayer.state == (6 << 0) || other.targetplayer.state == (79 << 0) || other.targetplayer.sprite_index == other.targetplayer.spr_swingding))  
                instakill = 0  
            var ex = (object_index == obj_pizzaball || object_index == obj_bigcheese)  
            if (place_meeting(x, y, obj_chaoschaser) && instakill && (!ex) && (!checkBaddie))  
            {  
                other.movespeed = 0  
                other.accel = 0.01  
                instance_destroy()  
            }  
        }  
    }  
    if ((place_meeting(x, y, obj_pizzard_bolt) || place_meeting(x, y, obj_robotknife) || place_meeting(x, y, obj_slugbullet) || place_meeting(x, y, obj_smokingprojectile) || place_meeting(x, y, obj_ufobullet) || place_meeting(x, y, obj_noisegoblin_arrow) || place_meeting(x, y, obj_canongoblinbomb) || place_meeting(x, y, obj_rancher_bullet) || place_meeting(x, y, obj_canonexplosion) || place_meeting(x, y, obj_arcprojectile) || place_meeting(x, y, obj_spitcheesespike) || place_meeting(x, y, obj_whoophand) || place_meeting(x, y, obj_slashhitbox) || place_meeting(x, y, obj_ratmountgroundpound) || place_meeting(x, y, obj_brickball) || place_meeting(x, y, obj_hamkuffattack) || place_meeting(x, y, obj_farmerbaddie3_projectile) || place_meeting(x, y, obj_farmerbaddie2_projectile)) && state != (3 << 0) && state != (5 << 0))  
    {  
        global.combotime += 30  
        with (obj_canongoblinbomb)  
        {  
            if place_meeting(x, y, obj_chaoschaser)  
                instance_destroy()  
        }  
        fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
        repeat (3)  
        {  
            with (create_debris(x, y, 1646))  
            {  
                hsp = random_range(-5, 5)  
                vsp = random_range(-10, 10)  
            }  
        }  
        instance_create(x, y, obj_bangeffect)  
        image_alpha = 1  
        state = (3 << 0)  
        hitLagX = other.x  
        hitLagY = other.y  
        hitlag = relhitlag / 2  
        alarm[4] = 75  
        ragebuffer = 0  
        return;  
    }  
    if place_meeting(x, y, obj_horsey)  
    {  
        with (obj_horsey)  
        {  
            other.movespeed = 0  
            other.accel = 0.01  
            var t = other.id  
            fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
            fmod_event_one_shot_3d("event:/sfx/playerN/horseydead", x, y)  
            notification_push((2 << 0), [room, id, object_index])  
            global.combotime = 60  
            instance_create(x, y, obj_bangeffect)  
            instance_create(x, y, obj_genericpoofeffect)  
            with (instance_create(x, y, obj_sausageman_dead))  
            {  
                image_xscale = (-t.image_xscale)  
                sprite_index = spr_horsey_lose  
                hsp = t.image_xscale * 10  
            }  
            instance_destroy()  
            instance_destroy(obj_horseyblock)  
        }  
    }  
    if place_meeting(x, y, obj_pizzagoblinbomb)  
    {  
        with (obj_pizzagoblinbomb)  
        {  
            if place_meeting(x, y, obj_chaoschaser)  
            {  
                global.combotime = 60  
                other.image_alpha = 1  
                other.state = (3 << 0)  
                other.hitLagX = other.x  
                other.hitLagY = other.y  
                other.hitlag = relhitlag  
                other.alarm[4] = 240  
                other.ragebuffer = 0  
                fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
                repeat (3)  
                {  
                    with (create_debris(x, y, 1646))  
                    {  
                        hsp = random_range(-5, 5)  
                        vsp = random_range(-10, 10)  
                    }  
                }  
                instance_create(x, y, obj_bangeffect)  
                instance_destroy()  
                return;  
            }  
        }  
    }  
    if (place_meeting(x, y, obj_morthitbox) && state != (3 << 0) && state != (5 << 0))  
    {  
        fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y)  
        fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)  
        fmod_event_one_shot_3d("event:/sfx/mort/mortslap", x, y)  
        repeat (3)  
        {  
            with (create_debris(x, y, 1646))  
            {  
                hsp = random_range(-5, 5)  
                vsp = random_range(-10, 10)  
            }  
        }  
        with (place_meeting(x, y, obj_morthitbox))  
        {  
            if place_meeting(x, y, obj_chaoschaser)  
            {  
                with (playerid)  
                {  
                    hsp += (5 * xscale)  
                    vsp = -11  
                }  
            }  
        }  
        instance_create(x, y, obj_bangeffect)  
        image_alpha = 1  
        state = (3 << 0)  
        hitLagX = other.x  
        hitLagY = other.y  
        hitlag = relhitlag / 2  
        alarm[4] = 75  
        ragebuffer = 0  
        return;  
    }  
}
~~~