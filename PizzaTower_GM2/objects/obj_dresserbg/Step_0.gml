bg_x += 1
bg_y += 1
if (!die)
{
    bgalpha = Approach(bgalpha, 1, 0.1)
    cursoralpha = Approach(cursoralpha, 1, 0.1)
}
else
{
    bgalpha = Approach(bgalpha, 0, 0.1)
    cursoralpha = Approach(cursoralpha, 0, 0.1)
}
if (bgalpha == 0 && die)
    instance_destroy()
