switch (sprite_index)
{
	case spr_ratdummy_bump:
	case spr_ratdummy_inflate:
		sprite_index = spr_ratdummy_idle;
		break;
	case spr_ratblock1_bump:
		sprite_index = spr_ratblock;
		break;
	case spr_ratblock6_bump:
		sprite_index = spr_ratblock6;
		break;
	case spr_rattumbleblock_bump:
		sprite_index = spr_rattumbleblock;
		break;
	case spr_rattumbleblock_big_bump:
		sprite_index = spr_rattumbleblock_big;
		break;
}
