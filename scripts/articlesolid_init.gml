if "phone" not in player_id{
	// this code turns the "solid article" into a "phone article", so that, for
	// all intents and purposes, it won't interact with any solid article code.
	// instead, it can now draw the phone's big screen while the phone is in
	// sleep mode.
	sprite_index = asset_get("empty_sprite");
	mask_index = asset_get("empty_sprite");
	uses_shader = false;
	orig_player_id = player_id;
	player_id = noone;
	num = "phone";
	depth = 7;
	x = 0;
	y = 10000;
	exit;
}

// your solid article code can go here!