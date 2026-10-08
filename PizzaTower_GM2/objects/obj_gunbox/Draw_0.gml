draw_self();
var _todraw = spr_gunbox_shotgundecal;
switch (content) {
	case "revolver":
		_todraw = spr_gunbox_pistoldecal;
		break;
}
draw_sprite_ext(_todraw, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);