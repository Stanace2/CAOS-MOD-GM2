function scr_wm_katanapulse(lineal = false)
{
    if (state == (37 << 0) || movespeed >= 16)
        return;
    if (allowkpulse && (!grounded))
    {
        allowkpulse = 0
        if lineal
        {
            if (movespeed < 17)
                movespeed = 17
        }
        else
        {
            if (movespeed < 12)
                kpulsebuffer = 10
            else
                kpulsebuffer = 10 * (exp(-0.478 * (movespeed - 12)))
            fakehsp = movespeed
            katanaxscale = xscale
            movespeed = fakehsp + kpulsebuffer
        }
    }
}