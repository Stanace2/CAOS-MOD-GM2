# obj_chaoschaser
#states #newstates
One way, or another, IM GONNA WIN YA!
**sprite : spr_caos_chase**
**mask : spr_forknight_mask**
**persistent**
This object is creating in:
- 
Scripts:
- [[scr_chaoschaser_berserk()]]
- [[scr_chaoschaser_secret()]]
- [[scr_chaoschaser_mood_manager()]]
- [[scr_chaoschaser_animation_manager()]]
- [[scr_chaoschaser_collision_manager()]]
- [[scr_chaoschaser_movement_manager()]]
- [[scr_chaosvomit()]]
Objects:
- [[Chaos UI#obj_chaosUI]]
- [[Chaos UI#obj_chaostracker]]
## Create

~~~js
targetplayer = -4  
movespeed = 0  
image_speed = 0.35  
depth = -5  
savedcx = camera_get_view_x(view_camera[0])  
savedcy = camera_get_view_y(view_camera[0])  
savedx = x  
savedy = y  
x = obj_player1.x  
y = obj_player1.y  
alarm[1] = 10  
image_alpha = 0  
supertaunted = 0  
berserk = 0  
br = 200  
ba = 0  
bas = 0.05  
tackledir = -4  
tackletimer = 75  
tackles = 1  
startbuffer = 60  
treasure = 0  
iframes = 0  
awake = 1  
chasedistance = 10  
hasmort = 0  
verticalz = 0  
horizontalz = 0  
snd = fmod_event_create_instance("event:/sfx/pizzaface/moving")  
haunt = 0  
lock = 0  
patience = 0  
ragebuffer = 0  
slakin = 0  
slackfury = 0  
slackfuryspeed = 0  
state = (0 << 0)  
hitLagX = 0  
hitLagY = 0  
hitlag = 0  
relhsp = 0  
relvsp = 0  
relalpha = 1  
chaoscolor = 0  
accel = 0  
hitbreak = 0  
high = 200  
toppins = 0  
secret = 0  
startsecret = 0  
endsecret = 0  
tauntID = -4  
trstored = (0 << 0)  
instance_create(x, y, obj_chaosUI)  
with (instance_create(x, y, obj_chaostracker))  
{  
    visible = 0  
    depth = -999  
    objectID = other.id  
    sprite_index = spr_hazard_caos  
    image_speed = 0.35  
}
~~~
## Destroy

~~~js
with (instance_create(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), obj_shakeanddie))  
    sprite_index = spr_pizzahead_intro1  
fmod_event_one_shot_3d("event:/sfx/misc/explosion", x, y)  
fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y)  
destroy_sounds([snd])  
instance_destroy(obj_chaosUI)  
global.ktoppingoal = 0
~~~
## Alarms
### 1
After image and color cycle?
~~~js
if (!secret)  
    create_red_afterimage(x, y, sprite_index, (image_index - 1), image_xscale)  
chaoscolor++  
if (chaoscolor > 3)  
    chaoscolor = 0  
alarm[1] = 10
~~~
### 2
Reset level
~~~js
audio_stop_all()  
stop_music()  
instance_destroy(obj_chaosUI)  
var rm = global.leveltorestart  
scr_pause_stop_sounds()  
global.levelattempts++  
ds_list_clear(global.saveroom)  
ds_list_clear(global.baddieroom)  
ds_list_clear(global.debris_list)  
ds_list_clear(global.collect_list)  
obj_music.music = -4  
instance_destroy(obj_fadeout)  
global.levelreset = 0  
scr_playerreset()  
global.levelreset = 1  
obj_player1.targetRoom = rm  
obj_player2.targetRoom = rm  
scr_room_goto(rm)  
var _d = "A"  
if (rm == boss_pizzaface)  
    _d = "B"  
obj_player1.targetDoor = _d  
obj_player1.restartbuffer = 15  
obj_player2.restartbuffer = 15  
if instance_exists(obj_player2)  
    obj_player2.targetDoor = _d  
if (rm == 656 || rm == 512 || rm == 510 || rm == 779 || rm == 511)  
    global.bossintro = 1
~~~
### 4

~~~js
state = (4 << 0)  
ragebuffer = 0  
supertaunted = 0
~~~
## BeginStep
Main variables init
~~~js
// Victim tracker
targetplayer = (global.coop ? instance_nearest(x, y, obj_player) : obj_player1)  
if (!instance_exists(targetplayer))  
    return; 
// Inits chaos to be always awake 
awake = 1  
// Math
chasedistance = distance_to_point(targetplayer.x, targetplayer.y)  
with (targetplayer)  
{  
	// Player is going full vertical
    other.verticalz = ((vsp < -10 && state == (306 << 0)) || (abs(vsp) > 9 && (state == (97 << 0) || state == (92 << 0) || state == (37 << 0) || state == (108 << 0))))  
    // Player is mostly horizontal
    other.horizontalz = (abs(hsp) < 12 && (state == (0 << 0) || state == (52 << 0) || state == (92 << 0) || state == (105 << 0) || state == (106 << 0) || state == (104 << 0) || state == (5 << 0) || state == (80 << 0) || (abs(vsp) < 11 && state == (37 << 0)) || state == (123 << 0) || state == (11 << 0) || state == (14 << 0) || state == (12 << 0) || state == (13 << 0) || state == (101 << 0) || state == (100 << 0) || state == (42 << 0) || state == (99 << 0) || state == (79 << 0) || isgustavo))  
}  
// Player has the mort tranfo
hasmort = (targetplayer.state == (11 << 0) || targetplayer.state == (14 << 0) || targetplayer.state == (12 << 0) || targetplayer.state == (13 << 0))  
// Player has iframes REBUILD THIS CRAP
iframes = (((targetplayer.sprite_index == spr_player_ratmountwalljump && targetplayer.hoverspin < 10) || targetplayer.sprite_index == spr_player_mangodive || targetplayer.sprite_index == spr_player_mangoboostend || targetplayer.sprite_index == spr_player_mangoboostfly || targetplayer.sprite_index == spr_player_mangoboost || targetplayer.sprite_index == spr_player_Sjump || targetplayer.sprite_index == spr_player_rolljump || targetplayer.sprite_index == spr_player_poundcancel || targetplayer.sprite_index == spr_player_crazyrun || targetplayer.sprite_index == spr_player_poundcancelstart || targetplayer.sprite_index == spr_player_poundcancelstart || targetplayer.sprite_index == spr_player_poundcanceldive || targetplayer.sprite_index == spr_wethamroll || targetplayer.sprite_index == spr_player_snapjumpstart || string_copy(sprite_get_name(targetplayer.sprite_index), 1, 16) == "spr_m_lastbreath" || targetplayer.sprite_index == spr_m_call || targetplayer.sprite_index == spr_player_snapjumpinter || targetplayer.sprite_index == spr_player_snapjump || targetplayer.sprite_index == spr_player_snaphighjump || targetplayer.sprite_index == spr_player_spinkf || targetplayer.sprite_index == spr_player_Sjumpcancel || sprite_index == spr_wethamdivel) && global.ikframes && (!global.iexception))  
// Room is a secret
if instance_exists(obj_secretportal)  
{  
    if obj_secretportal.secret  
        secret = 1  
    else  
        secret = 0  
}  
else  
    secret = 0  
// Restart when exiting secret | This can be used for end anims like toss the cig
if endsecret  
{  
    if (!secret)  
    {  
        endsecret = 0  
        startsecret = 0  
        obj_chaosUI.hide = 0  
    }  
    else  
        obj_chaosUI.hide = 1  
}  
// Make player visible after puking it
if (targetplayer.state == (107 << 0) && (!targetplayer.visible))  
    targetplayer.visible = 1  
if (targetplayer.state == (148 << 0) && (state == (0 << 0) || state == (1 << 0)))  
    secret = 1
~~~
## Step

~~~js
// Main Skeleton | pretty self explanatory
global.caoschase = 1  
if (!instance_exists(targetplayer))  
    return;  
if berserk  
{  
    scr_chaoschaser_berserk()  
    return;  
}  
if secret  
{  
    scr_chaoschaser_secret()  
    return;  
}  
// Manages some variables, decides whether she has enough or not
scr_chaoschaser_mood_manager()  
// Sprite manager
scr_chaoschaser_animation_manager()  
// Detection of collisions, to prevent making a fucking piñata of collision methods, all is managed here
scr_chaoschaser_collision_manager()  
// Movement and state machine
scr_chaoschaser_movement_manager()
~~~
## EndStep

~~~js
// Cleaner, manages variables after being processed in Step
if (!instance_exists(targetplayer))  
    return;  
if (ragebuffer > 100)  
    ragebuffer = 100  
if (ragebuffer != 0)  
{  
    if (ragebuffer < 25)  
        ragebuffer = Approach(ragebuffer, 0, 0.05)  
    else  
        ragebuffer = Approach(ragebuffer, 0, 0.3)  
}  
if (patience > 0)  
    patience--  
if (patience < 0)  
    patience = 0  
if (startbuffer > 0)  
    startbuffer--  
// What is the relative speed of caos, it's not managed in movement manager
relhsp = x - xprevious  
relvsp = y - yprevious  
var _accel = 0  
if (abs(relhsp) < 4)  
    _accel = 0.05  
else if (abs(relhsp) < 8)  
    _accel = 0.1  
else if (abs(relhsp) < 10)  
    _accel = 0.5  
else  
    _accel = 1  
if hitbreak  
    accel = 3  
else  
    accel = _accel  
if slackfury  
    slackfuryspeed = Approach(slackfuryspeed, 6, 0.075)  
else  
    slackfuryspeed = 0  
// Update tracker
if instance_exists(obj_objecticontracker)  
{  
    with (obj_objecticontracker)  
    {  
        if (objectID == other.id)  
        {  
            if (other.state == (3 << 0) || other.state == (5 << 0))  
                sprite_index = spr_hazarddizzy_caos  
            else  
                sprite_index = spr_hazard_caos  
        }  
    }  
}  
// Did some last second changes here, now it makes sense
// The sound is a placeholder for the chaosbar being filled
// This should be completely manage by the UI so... REBUILD
if instance_exists(obj_chaosUI)  
{  
    if obj_chaosUI.barxpatience  
    {  
        fmod_event_instance_set_3d_attributes(snd, x, y)  
        if (!fmod_event_instance_is_playing(snd))  
            fmod_event_instance_play(snd)  
    }  
    else  
        fmod_event_instance_stop(snd)  
}
~~~
## RoomStart

~~~js
if (state != (8 << 0))  
{  
    image_alpha = 0  
    if berserk  
    {  
        berserk = 0  
        state = (0 << 0)  
    }  
    ba = 0  
    bas = 0.05  
    tackletimer = 75  
    tackles = 1  
}  
haunt = 0  
savedx = x  
savedy = y  
savedcx = camera_get_view_x(view_camera[0])  
savedcy = camera_get_view_y(view_camera[0])  
if instance_exists(obj_player1)  
{  
    x = obj_player1.x  
    y = obj_player1.y  
}  
if instance_exists(obj_treasure)  
    treasure = 1  
else  
    treasure = 0  
if (room == rank_room)  
    instance_destroy()  
startbuffer = 60  
with (instance_create(x, y, obj_chaostracker))  
{  
    depth = -999  
    objectID = other.id  
    sprite_index = spr_hazard_caos  
    image_speed = 0.35  
}
~~~
## Draw

~~~js
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha)
~~~
