x = Approach(x, relx, 25)
y = Approach(y, rely, 25)
if (!die)
    alpha = Approach(alpha, amax, 0.1)
else
    alpha = Approach(alpha, 0, 0.1)
if (alpha == 0 && die)
    instance_destroy()
with (obj_palettedresser)
{
    var pep = 0
    if (!ispeppino)
        pep = 1
    var actors = actor_array[pep]
    if ((actors[scolumn][srow][2] == other.paletteindex && array_length(actors[scolumn][srow]) <= 3) || (array_length(actors[scolumn][srow]) > 3 && actors[scolumn][srow][3] == other.palettetexture))
        other.amax = 1
    else
        other.amax = 0.3
}
