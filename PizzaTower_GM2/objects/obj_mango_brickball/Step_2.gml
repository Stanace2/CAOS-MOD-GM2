if (obj_player1.state == states.secretportal)
{
    instance_destroy()
    instance_create(x, y, obj_genericpoofeffect)
}
var exc = (place_meeting((x + hsp), y, obj_destructibles) || place_meeting((x + hsp), y, obj_metalblock))
if exc
{
    instance_destroy(instance_place((x + hsp), y, obj_destructibles))
    instance_destroy(instance_place((x + hsp), y, obj_metalblock))
}
if (flash && alarm[1] == -1)
    alarm[1] = 10
if (state == mbstates.verticalhallway)
    return;
toppins = instance_place(x, y, pizzakin)
if (toppins != noone)
{
    with (obj_player)
        other.toppins.force = 1
}
var box = 50;
for (var i = 0; i < array_length(collect); i++)
{
	var _list = ds_list_create()  
	collectibles = collision_rectangle_list(x - box, y - box, x + box, y + box, collect[i], 0, 0, _list, 0)  
	if (collectibles > 0)  
	{  
	    for (var i = 0; i < collectibles; i++)  
	    {  
			with (obj_player)
	        {
	            with (ds_list_find_value(_list, i))
	                event_perform(ev_collision, obj_player)
	        }
	    }  
	}  
	ds_list_destroy(_list)
}
var banan = instance_place(x, y, obj_slipnslide)
if (banan != noone)
{
    with (instance_create(x, y, obj_mango_flee))
    {
        image_xscale = other.image_xscale
        launchforce = abs(other.hsp) + 4
        fmod_event_one_shot_3d("event:/sfx/pep/slip", x, y)
        vsp = -11
        state = mfstates.slip
        launchbuffer = 5
        sprite_index = spr_mango_slip
        image_index = 0
    }
    instance_destroy(banan)
    instance_destroy()
    return;
}
if (grounded)
{
	if (!fmod_event_instance_is_playing(m_rollingsound))
		fmod_event_instance_play(m_rollingsound);
	fmod_event_instance_set_3d_attributes(m_rollingsound, x, y)
}
else
	fmod_event_instance_stop(m_rollingsound, true);