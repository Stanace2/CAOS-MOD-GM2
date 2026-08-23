function wm_mangokick() //gml_Script_wm_mangokick
{
    if (brick || instance_exists(obj_mango_companion) || (instance_exists(obj_mangocomeback) && obj_mangocomeback.sprite_index == spr_m_flykicked))
    {
        if instance_exists(obj_mango_companion)
        {
            with (obj_mango_companion)
                instance_destroy()
        }
        if instance_exists(obj_mangocomeback)
        {
            with (obj_mangocomeback)
                instance_destroy()
            instance_create(other.x, other.y, obj_genericpoofeffect)
        }
        mkickbuffer = 10
        input_buffer_slap = 0
        with (instance_create((x + image_xscale), y, obj_mango_brickball))
        {
            hover = 25
            image_xscale = other.xscale
            sprite_index = spr_m_bb
            image_index = 0
            if (other.movespeed < 12)
                movespeed = 12
            else
                movespeed = other.movespeed * 1.5
        }
        state = states.slap
        if (abs(hsp) < 12)
        {
            movespeed = 8
            sprite_index = spr_w_kick
        }
        else
            sprite_index = spr_wetham_machmango_kick

        image_index = 0
        brick = false
        return true;
    }
    return false;
}