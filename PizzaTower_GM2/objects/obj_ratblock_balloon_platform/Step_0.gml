if (ANIMATION_END) {
	switch (sprite_index) {
		case spr_ratdummyplatform_pop:
			sprite_index = spr_ratdummyplatform_off;
			break
		case spr_ratdummyplatform_inflate:
			if (place_empty(x,y) && place_empty(x,y - 36))
				event_user(0);
			else
				sprite_index = spr_ratdummyplatform_inflate_loop;
			break
		case spr_ratdummyplatform_inflate_success:
			sprite_index = spr_ratdummyplatform_idle;
			break
	}	
}

if (sprite_index == spr_ratdummyplatform_inflate_loop && place_empty(x,y) && place_empty(x,y - 36))
	event_user(0);

if (popped && alarm[0] <= 0) {
	alarm[0] = 80;
}