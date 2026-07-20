if display
{
    var pep = 0
    if (!ispeppino)
        pep = 1
    var actors = actor_array[pep]
    scr_menu_getinput()
    ad = Approach(ad, 1, 0.1)
    if key_back
    {
        obj_dresserbg.die = 1
        obj_dresseractor.die = 1
        display = 0
        obj_player1.state = states.normal
    }
    if (key_jump && actors[scolumn][srow][1])
    {
        with (instance_create(x, y, obj_sausageman_dead))
        {
            fmod_event_one_shot_3d("event:/sfx/misc/clotheswitch", x, y)
            hsp = irandom_range(-5, 5)
            vsp = (-(irandom_range(6, 11)))
            usepalette = 1
            sprite_index = spr_palettedresserdebris
            if (!obj_player1.ispeppino)
                sprite_index = spr_palettedresserdebrisN
            spr_palette = obj_player1.spr_palette
            paletteselect = obj_player1.paletteselect
            oldpalettetexture = global.palettetexture
        }
        obj_player1.player_paletteselect[obj_player1.player_paletteindex] = actors[scolumn][srow][2]
        var pattern = noone
        if (array_length(actors[scolumn][srow]) > 3)
            pattern = actors[scolumn][srow][3]
        obj_player1.player_patterntexture[obj_player1.player_paletteindex] = pattern
        trace(obj_player1.player_paletteselect, " pal")
        trace(obj_player1.player_patterntexture, " texture")
        ini_open_from_string(obj_savesystem.ini_str)
        ini_write_real("Game", "palette", obj_player1.player_paletteselect[0])
        ini_write_real("Game", "palette_player2", obj_player1.player_paletteselect[1])
        ini_write_string("Game", "palettetexture", scr_get_texture_name(obj_player1.player_patterntexture[0]))
        ini_write_string("Game", "palettetexture_player2", scr_get_texture_name(obj_player1.player_patterntexture[1]))
        obj_savesystem.ini_str = ini_close()
        obj_dresserbg.die = true
        obj_dresseractor.die = true
        display = 0
        obj_player1.image_index = 0
        obj_player1.sprite_index = obj_player1.spr_dressup
        obj_player1.jumpAnim = true
        obj_player1.landAnim = false
        with (obj_player1)
        {
			/*
            if ispeppino
            {
                if (actors[other.scolumn][other.srow][0] == "pp")
                {
                    spr_suplexdash = spr_player_suplexdashALT
                    spr_suplexdashjumpstart = spr_player_suplexgrabjumpstartALT
                    spr_suplexdashjump = spr_player_suplexgrabjumpALT
                    spr_longjump = spr_player_longjumpALT
                    spr_longjumpend = spr_player_longjumpendALT
                }
                else if dos
                {
                    spr_suplexdash = spr_player_suplexdash
                    spr_suplexdashjumpstart = spr_player_suplexgrabjumpstart
                    spr_suplexdashjump = spr_player_suplexgrabjump
                    spr_longjump = spr_player_longjump
                    spr_longjumpend = spr_player_longjumpend
                }
            }
			*/
        }
    }
    if (key_jump && (!actors[scolumn][srow][1]))
        fmod_event_one_shot_3d("event:/sfx/ui/switchchardown", x, y)
    palettetitle = lang_get_value(concat("dresser_", actors[scolumn][srow][0], "title"))
    palettedesc = lang_get_value_newline(concat("dresser_", actors[scolumn][srow][0]))
}
else
    ad = Approach(ad, 0, 0.1)
if (usebuffer < 1 && display)
{
    if (-key_left2)
    {
        if (scolumn != 0)
        {
            with (obj_dresseractor)
                relx += 100
            scolumn -= 1
        }
        else if (srow > ((array_length(actors[(array_length(actors) - 1)])) - 1))
        {
            with (obj_dresseractor)
                relx -= (100 * (array_length(actors) - 2))
            scolumn = array_length(actors) - 2
        }
        else
        {
            with (obj_dresseractor)
                relx -= (100 * (array_length(actors) - 1))
            scolumn = array_length(actors) - 1
        }
    }
    if key_right2
    {
        if (scolumn != (array_length(actors) - 1))
        {
            if (srow > ((array_length(actors[(scolumn + 1)])) - 1))
            {
                with (obj_dresseractor)
                    relx += (100 * (array_length(actors) - 2))
                scolumn = 0
            }
            else
            {
                with (obj_dresseractor)
                    relx -= 100
                scolumn += 1
            }
        }
        else
        {
            with (obj_dresseractor)
                relx += (100 * (array_length(actors) - 1))
            scolumn = 0
        }
    }
    if key_up2
    {
        if (srow != 0)
        {
            with (obj_dresseractor)
                rely += 100
            srow -= 1
        }
        else
        {
            with (obj_dresseractor)
                rely -= (100 * (array_length(actors[other.scolumn]) - 1))
            srow = array_length(actors[scolumn]) - 1
        }
    }
    if key_down2
    {
        if (srow != (array_length(actors[scolumn]) - 1))
        {
            with (obj_dresseractor)
                rely -= 100
            srow += 1
        }
        else
        {
            with (obj_dresseractor)
                rely += (100 * (array_length(actors[other.scolumn]) - 1))
            srow = 0
        }
    }
}
if (usebuffer > 0)
    usebuffer--



