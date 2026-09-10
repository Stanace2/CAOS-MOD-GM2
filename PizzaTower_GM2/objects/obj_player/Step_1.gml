if ((!((global.caoschase && global.ikframes && (!global.iexception)))) && (
	string_copy(sprite_get_name(sprite_index), 1, 16) == "spr_m_lastbreath" || 
	sprite_index == spr_w_spinkick || 
	sprite_index == spr_wethamroll || 
	sprite_index == spr_lonewetham_tumble
	))
{
    kickiw = true
    iwalpha = 0.66
    with (scr_windafterimage(x, y, sprite_index, image_index, xscale))
        playerid = other.id
}
else
{
    kickiw = false
    iwalpha = Approach(iwalpha, 0, 0.075)
}