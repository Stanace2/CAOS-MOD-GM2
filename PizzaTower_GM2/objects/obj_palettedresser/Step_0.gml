if (obj_player1.ispeppino != ispeppino)
{
    ispeppino = obj_player1.ispeppino
    if obj_player1.ispeppino
        palettes = player_palettes[0]
    else
        palettes = player_palettes[1]
}
showtext = place_meeting(x, y, obj_player)
if instance_exists(obj_transfotip)
    showtext = 0
if showtext
    alpha = Approach(alpha, 1, 0.1)
else
    alpha = Approach(alpha, 0, 0.1)
