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
for (var i = 0; i < array_length(collect); i++)
{
    collectibles = instance_place(x, y, collect[i])
    if (collectibles != noone)
    {
        with (obj_player)
        {
            with (other.collectibles)
                event_perform(ev_collision, obj_player)
        }
    }
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
