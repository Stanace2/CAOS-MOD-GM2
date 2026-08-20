if (!instance_exists(obj_parryeffect))
    fmod_event_one_shot_3d("event:/chaos-sfx/wm/wetham/parry", x, y)
var myplayer = obj_player1.id
if (player_id == 2)
    myplayer = obj_player2.id
with (myplayer)
{
    parry_lethal = other.lethal
    with (instance_create(x, y, obj_parryeffect))
        image_xscale = other.xscale
    flash = 1
}
alarm[0] = 0
collisioned = 1