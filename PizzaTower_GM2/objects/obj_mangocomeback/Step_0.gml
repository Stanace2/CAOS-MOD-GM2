if trapped
    sprite_index = spr_mango_cries
if stunned
    return;
if obj_player.callstored
{
    comeback = 1
    wait = 0
}
if (!trapped)
{
    depth = obj_player1.depth + 1
    x = Approach(x, obj_player1.x, cbspeed)
    y = Approach(y, obj_player1.y, cbspeed)
    cbspeed = Approach(cbspeed, 45, comebackaccel)
    if (sprite_index != spr_m_comeback && sprite_index != spr_m_flykicked)
        sprite_index = spr_m_comeback
}
if (comebackaccel < 5)
    comebackaccel += 0.1
else if (baddieID == noone)
{
    vsp = -10
    if ((y + vsp) < 80 || scr_solid(x, (y - 78)))
        vsp = 0
    y += vsp
}
else if (!instance_exists(baddieID))
    trapped = 0
