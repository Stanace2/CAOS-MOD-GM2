## obj_tv
### Draw
~~~js
// Inside the draw method for obj_tv, some changes to the combo bar were made for the caos challenge
combofill_x = lerp(combofill_x, (_minX + (_maxX - _minX) * _perc), 0.5)  
combofill_y = _cy  
// H e r e
var _chaosaddon = ""  
if global.caoschase  
    _chaosaddon = "_chaosless"  
shader_set(global.Pal_Shader)  
pal_swap_set(spr_tv_combofillpalette, (((!global.combodropped) && global.prank_enemykilled) ? 2 : 1), 0)  
draw_sprite(asset_get_index(concat("spr_tv_combobubblefill", _chaosaddon)), combofill_index, combofill_x, combofill_y)  
pal_swap_set(spr_tv_combopalette, ((obj_player1.ispeppino && (!global.swapmode)) ? 0 : 1), 0)  
// This one is an old call, due to the mod being done before the lang update
draw_sprite(asset_get_index(concat("spr_tv_combobubble", _chaosaddon)), -1, _cx, _cy)  
if (!global.caoschase)  
    draw_set_font(global.combofont2)  
else  
    draw_set_font(global.combofontchaosless)
~~~