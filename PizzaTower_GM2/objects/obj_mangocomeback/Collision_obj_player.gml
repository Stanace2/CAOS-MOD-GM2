if (!trapped)
{
    if (comeback == 1 
		&& obj_player1.sprite_index != spr_w_spinkick 
		&& obj_player1.state != states.dynamite
		&& obj_player1.sprite_index != spr_w_hurt 
		&& obj_player1.state != states.freefall
		&& obj_player1.state != states.freefallland
		&& obj_player1.state != states.ratmountgrind
		&& obj_player1.sprite_index != spr_wetham_bd 
		&& obj_player1.sprite_index != spr_wethamwalljump 
		&& obj_player1.state != states.climbwall
		&& obj_player1.state != states.ladder
		&& obj_player1.state != states.crouch
		&& obj_player1.state != states.tumble
		&& obj_player1.sprite_index != spr_wetham_longjump 
		&& obj_player1.sprite_index != spr_wetham_longjump_loop)
    {
        other.brick = 1
        instance_create(other.x, other.y, obj_genericpoofeffect)
        instance_destroy()
    }
    else
    {
        with (instance_create(x, y, obj_mango_companion))
            wait = 1
        instance_destroy()
    }
}
else if (other.state == states.ratmountpunch && baddieID == -4)
{
    fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y)
    vsp = -6
    hsp = other.xscale * 8
    trapped = 0
    wait = 1
    comeback = 0
    alarm[0] = 30
}
