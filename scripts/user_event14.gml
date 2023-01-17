// phone - backend

draw_set_valign(fa_top)

switch(muno_event_type){
	case 0: // init
		CORE_init();
		break;
	case 1: // update
		CORE_update();
		break;
	case 2: // set attack
		CORE_set_attack();
		break;
	case 3: // pre draw
		if phone.state{
			break;
		}
		CORE_big_screen(0);
		break;
	case 4: // post draw
		CORE_post_draw();
		break;
	case 5: // draw hud
		if phone.state{
			CORE_big_screen(1);
		}
		CORE_draw_hud();
		break;
	case 6: // css draw
		CORE_css_draw();
		break;
}

muno_event_type = -1;



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Init																		║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_init

// character identity info
muno_char_id = noone;
muno_char_icon = get_char_info(player, INFO_ICON);
muno_char_name = get_char_info(player, INFO_STR_NAME);
phone_darkened_player_color = make_color_rgb(
	color_get_red	(get_player_hud_color(player)) * 0.25,
	color_get_green	(get_player_hud_color(player)) * 0.25,
	color_get_blue	(get_player_hud_color(player)) * 0.25
	);

// character state info
phone_attacking = 0;
phone_window_end = 0;
phone_landing = 0;
phone_lightweight = 0;
phone_offscreen = [];
phone_dust_query = [];

// attack info
phone_invul_override = 0;
phone_stopped_sounds = [];
phone_arrow_cooldown = 0;
phone_invis_cooldown = 0;
phone_using_landing_cd = noone;
phone_using_invul = noone;

// game/match environment info
phone_playtest = (object_index == oTestPlayer);
phone_practice = get_match_setting(SET_PRACTICE) && !phone_playtest && get_player_hud_color(player) != c_gray;
phone_hud_hidden = !(get_local_setting(SET_HUD_SIZE) || get_local_setting(SET_HUD_NAMES));
phone_ditto = false;
phone_blastzone_r = room_width - get_stage_data(SD_X_POS) + get_stage_data(SD_SIDE_BLASTZONE);
phone_blastzone_l = get_stage_data(SD_X_POS) - get_stage_data(SD_SIDE_BLASTZONE);
phone_blastzone_t = get_stage_data(SD_Y_POS) - get_stage_data(SD_TOP_BLASTZONE);
phone_blastzone_b = get_stage_data(SD_Y_POS) + get_stage_data(SD_BOTTOM_BLASTZONE);
// phone_blastzone_l = get_stage_data(SD_BLASTZONE_LEFT_X);
// phone_blastzone_r = get_stage_data(SD_BLASTZONE_RIGHT_X);
// phone_blastzone_t = get_stage_data(SD_BLASTZONE_TOP_Y);
// phone_blastzone_b = get_stage_data(SD_BLASTZONE_BOTTOM_Y);
phone_game_over = false;
phone_lagging = false;
phone_online = 0;
for (var cur = 0; cur < 4; cur++){
	if get_player_hud_color(cur+1) == $64e542 phone_online = 1;
}

// phone info
phone_fast = 0;
phone_char_ided = false;
phone_cheats = [];
phone_cheats_updated = []; // "just got clicked"; manually reset to 0
phone_frozen_damage = 0;

// to draw big screen. MUST go before phone is created.
instance_create(x, y, "obj_article_solid");

phone = {
	
	// version
	firmware: 5,
	
	// dev-end config
	uses_shader: 0,
	supports_fast_graphics: false,
	dont_fast: false,
	include_stats: true,
	stats_notes: "-",
	include_custom: false,
	custom_name: "",
	custom_fd_content: [],
	extra_top_size: 0,
	
	// "constants"
	lowered_y: 300,
	screen_width: 120,
	screen_height: 240,
	
	// current state/position/etc
	state: 0,
	state_timer: 0,
	x: 0,
	y: 0,
	app: 0,
	apps: [],
	cursor: 0,
	page: 0,
	
	// app data
	tips: [{}], // reserved spot for "how to phone" tip.
	patches: [],
	data: [],
	cheats: [],
	utils: [],
	utils_cur: [],
	utils_cur_updated: [],
	
	// whether or not stuff has been done
	frame_data_loaded: false,
	has_opened_yet: false,
	
	// timers
	click_bump_timer: 0,
	click_bump_timer_max: 5,
	app_icon_slide_timer: 0,
	app_icon_slide_timer_max: 15,
	cursor_change_timer: 0,
	cursor_change_timer_max: 5,
	page_change_timer: 0,
	page_change_timer_max: 10,
	
	// misc
	big_screen_pos_offset: 1,
	last_text_size: [],
	scroll_dist: 0,
	target_scroll_dist: 0,
	starting_ag_index: 80,
	starting_hg_index: 80,
	phone_attack_index: 40,
	
	dummy: 0 // footer, because LWOs don't support trailing commas :(
}

sfx_pho_open = sound_get("_pho_acnh_prompt3");
sfx_pho_close = sound_get("_pho_acnh_cancel1");
sfx_pho_move = sound_get("_pho_acnh_move1");
sfx_pho_move_home = sound_get("_pho_acnh_move2");
sfx_pho_page = sound_get("_pho_acnh_select2");
sfx_pho_open_app = sound_get("_pho_acnh_select1");
sfx_pho_close_app = sound_get("_pho_acnh_cancel2");
sfx_pho_power_off = sound_get("_pho_acnh_chime3");
sfx_pho_power_on = sound_get("_pho_acnh_chime1");

initIndexes();

phone.attack_names = [
	"None",
	"Jab",
	"???",
	"???",
	"FTilt",
	"DTilt",
	"UTilt",
	"FStrong",
	"DStrong",
	"UStrong",
	"DAttack",
	"FAir",
	"BAir",
	"DAir",
	"UAir",
	"NAir",
	"FSpecial",
	"DSpecial",
	"USpecial",
	"NSpecial",
	"FStrong 2",
	"DStrong 2",
	"UStrong 2",
	"USpecial Ground",
	"USpecial 2",
	"FSpecial 2",
	"FThrow",
	"UThrow",
	"DThrow",
	"NThrow",
	"DSpecial 2",
	"Extra 1",
	"DSpecial Air",
	"NSpecial 2",
	"FSpecial Air",
	"Taunt",
	"Taunt 2",
	"Extra 2",
	"Extra 3",
	"MunoPhone",
	"???",
	"NSpecial Air",
	"???",
	"???",
	"???",
	"???",
	"???",
	"???",
	"???",
	"???",
	"???"
];

with phone{
	
	phone = self;
	
	APP_HOME		= pho_initApp("Home Screen",	$000000, $000000, apps);
	APP_TIPS		= pho_initApp("Tips",			$1e82f2, $002eaf, tips);
	APP_PATCHES		= pho_initApp("Patches",		$15f37e, $007852, patches);
	APP_DATA		= pho_initApp("Data",			$f0bc27, $9e6400, data);
	APP_CHEATS		= pho_initApp("Cheats",			$ef2d27, $9e0032, cheats);
	APP_UTILS		= pho_initApp("Utilities",		$8358f1, $4425b8, utils);
	APP_POWER		= pho_initApp("Power",			$f07c27, $bd3200, []);
}

user_event(15);

with phone{
	if supports_fast_graphics{
		UTIL_FAST		= pho_initUtil("Graphics", [0, 1], ["Fancy", "Fast"], "This character supports Fast Graphics! This setting disables certain visual effects to make the character run better on lesser hardware. It will trigger automatically (even in VS Mode) if the FPS drops below 60 for about 5+ frames while the MunoPhone is closed.
	
		In online matches, it won't automatically trigger; instead, press the F1 key on the keyboard to enable Fast Graphics.");
	}
	else{
		dont_fast = true;
	}
	
	UTIL_FPS_WARN	= pho_initUtil("Low FPS Warning", [1, 0], ["On", "Off"], "Display an onscreen warning when the game's FPS dips below 60.")
	UTIL_OPAQUE		= pho_initUtil("Opaque Background", [0, 1, 2], ["Off", "On", "When Focused"], "Draw an opaque background for app content, instead of a transparent one.");
	UTIL_DMG_FREEZE	= pho_initUtil("Freeze Own Damage", [0, 1], ["Off", "On"], "Prevent the phone user's damage from changing (by constantly setting it back to the initial value).");
	UTIL_STATE_SAVE	= pho_initUtil("Save Position and Damage", [0], "", "Save the position and damage of all characters.");
	UTIL_STATE_LOAD	= pho_initUtil("Load Position and Damage", [0], "", "Load the position and damage saved by the previous setting.");
	UTIL_GREEN		= pho_initUtil("Greenscreen", [0, 1], ["Off", "On"], "Enable a greenscreen that is drawn at the same depth as the phone's content screen.
	
	(Won't take effect until you put away the phone.)");
	UTIL_PARRY		= pho_initUtil("Endless Parry", [0, 1], ["Off", "On"], "Causes other players' parry windows to last forever until they successfully parry something, if the CPU action is set to Parry.
	
	Useful for testing the on-parry effects of a move without having to time it perfectly.");
	
	var attack_list = [
		0,
		AT_JAB,
		AT_FTILT,
		AT_DTILT,
		AT_UTILT,
		AT_DATTACK,
		AT_FSTRONG,
		AT_USTRONG,
		AT_DSTRONG,
		AT_NAIR,
		AT_FAIR,
		AT_BAIR,
		AT_UAIR,
		AT_DAIR,
		AT_NSPECIAL,
		AT_FSPECIAL,
		AT_USPECIAL,
		AT_DSPECIAL,
		AT_TAUNT,
		];
		
	var attack_names = [];
	
	for (var i = 0; i < array_length(attack_list); i++){
		attack_names[i] = phone.attack_names[attack_list[i]];
	}
	
	UTIL_ATTACK		= pho_initUtil("Spam Attack", attack_list, attack_names, "Makes the CPU spam a certain attack. Set the CPU action to Crouch for ground moves, and Jump for air moves.
	
	(If the action is Jump, this Utility will also try to force the CPU to shorthop.)");
	UTIL_CPU		= pho_initUtil("CPU Behavior Changes", [1, 0], ["On", "Off"], "Makes changes to some base-game CPUs to make them better training dummies, removing annoying side effects when recovering.
	
		Zetterburn, Maypul, and Ranno cannot inflict their status effects.
		
		Kragg and Forsburn cannot create pillars or clones.
		
		Shovel Knight's FSpecial and USpecial have no hitbox (meaning no gems are created), and he doesn't drop bags of gems on death.");
}

initTip("Phone Controls", true);
initWords( "Bowser,");
initWords("Thank you for your purchase of a MunoPhone Touch! Here are a couple of handy tips to get you started with your new smart device:");
initHeader("Sleep Mode");
initSection("With the phone open, pressing Special goes to the Home Screen, and then pressing it again closes the phone.");
initSection("If you instead press Taunt or Shield, you will suspend the phone, leaving any full-screen content visible while you control your character.");
initSection("Opening the phone again after this puts you right back where you left off!");
initHeader("Taunting");
initSection("In Practice Mode, for most characters, your taunt is replaced with opening the phone.");
initSection("If you want to perform the normal taunt, you can hold any direction on the Control Stick and then press taunt!");
initWords_ext("- Muno", fa_right, c_white, 0, 0);

initPatch("About MunoPhone", "");
initWords("MunoPhone Touch is the second version of a general-use utility released for RoA character devs to add to their mods.");
initWords("It provides bonus features in Practice Mode, useful behind-the-scenes shortcuts for common coding tasks, and a more balanced version of Sandbert to use as a character base.");
initHeader("Developed by");
initSection("Muno - byMuno.com");
initHeader("SFX from");
initSection("Animal Crossing: New Horizons");
initHeader("Firmware");
initSection("v" + string(phone.firmware));

#define initTip(tip_name, zeroeth)

if zeroeth{
	phone.tips[0] = {
		name: tip_name,
		objs: [],
		page_starts: [0]
	};
	
	phone.currently_edited_obj = phone.tips[0];
}
else{
	array_push(phone.tips, {
		name: tip_name,
		objs: [],
		page_starts: [0]
	});
	
	phone.currently_edited_obj = phone.tips[array_length(phone.tips) - 1];
}

initWords_ext("- " + tip_name + " -", fa_center, phone.apps[phone.APP_TIPS].color, 0, 0);

#define initPatch(patch_version, patch_date)

array_push(phone.patches, {
	name: (patch_date == "" ? "" : "v") + patch_version,
	objs: [],
	page_starts: [0]
});

phone.currently_edited_obj = phone.patches[array_length(phone.patches) - 1];

if patch_date == ""{
	initWords_ext("- " + patch_version + " -", fa_center, phone.apps[phone.APP_PATCHES].color, 0, 0);
}
else{
	initWords_ext("- v" + patch_version + ": " + patch_date + " -", fa_center, phone.apps[phone.APP_PATCHES].color, 0, 0);
}

#define initHeader(obj_text)

initWords_ext(obj_text, fa_left, "h", 0, 0);

#define initSection(obj_text)

initWords_ext(obj_text, fa_left, c_white, 1, 0);

#define initWords(obj_text)

array_push(phone.currently_edited_obj.objs, {
	type: 0,
	text: obj_text,
	align: fa_left,
	color: c_white,
	indent: 0,
	side_by_side: false
});

#define initWords_ext(obj_text, obj_align, obj_color, obj_indent, obj_side_by_side)

array_push(phone.currently_edited_obj.objs, {
	type: 0,
	text: obj_text,
	align: obj_align,
	color: obj_color,
	indent: obj_indent,
	side_by_side: obj_side_by_side
});

#define pho_initApp(app_name, app_color, app_color_dark, arr)

array_push(apps, {
	name: app_name,
	color: make_color_rgb(color_get_blue(app_color), color_get_green(app_color), color_get_red(app_color)),
	color_dark: make_color_rgb(color_get_blue(app_color_dark), color_get_green(app_color_dark), color_get_red(app_color_dark)),
	array: arr
});

return array_length(apps) - 1;

#define pho_initUtil(ch_name, ch_opt, ch_opt_name, ch_desc)

array_push(utils, {
	name: ch_name,
	options: ch_opt,
	option_names: ch_opt_name,
	description: ch_desc,
	on: 0
});

array_push(utils_cur, ch_opt[0]);
array_push(utils_cur_updated, 0);
return array_length(utils) - 1;

#define initIndexes

// Custom indexes

AT_PHONE = phone.phone_attack_index;

i = phone.starting_ag_index;

// NOTE: All overrides for the frame data guide should be strings. Any non-applicable (N/A) values should be entered as "-"

// General Attack Indexes
AG_MUNO_ATTACK_EXCLUDE = i; i++;		// Set to 1 to exclude this move from the list of moves
AG_MUNO_ATTACK_NAME = i; i++;			// Enter a string to override move name
AG_MUNO_ATTACK_FAF = i; i++;			// Enter a string to override FAF
AG_MUNO_ATTACK_ENDLAG = i; i++;			// Enter a string to override endlag
AG_MUNO_ATTACK_LANDING_LAG = i; i++;	// Enter a string to override landing lag
AG_MUNO_ATTACK_MISC = i; i++;			// Enter a string to OVERRIDE the move's "Notes" section, which automatically includes the Cooldown System and Misc. Window Traits found below
AG_MUNO_ATTACK_MISC_ADD = i; i++;		// Enter a string to ADD TO the move's "Notes" section (preceded by the auto-generated one, then a line break)

// Adding Notes to a move is good for if a move requires a long explanation of the data, or if a move overall has certain behavior that should be listed such as a manually coded cancel window

// General Window Indexes
AG_MUNO_WINDOW_EXCLUDE = i; i++;		// 0: include window in timeline (default)    1: exclude window from timeline    2: exclude window from timeline, only for the on-hit time    3: exclude window from timeline, only for the on-whiff time
AG_MUNO_WINDOW_ROLE = i; i++;			// 0: none (acts identically to AG_MUNO_WINDOW_EXCLUDE = 1)   1: startup   2: active (or BETWEEN active frames, eg between multihits)   3: endlag
AG_MUNO_ATTACK_USES_ROLES = i; i++;		// Must be set to 1 for AG_MUNO_WINDOW_ROLE to take effect

// If your move's windows are structured non-linearly, you can use AG_MUNO_WINDOW_ROLE to force the frame data system to parse the window order correctly.

// Cooldown System (do this instead of manually setting in attack_update, and cooldown/invul/armor will automatically appear in the frame data guide)
AG_MUNO_ATTACK_COOLDOWN = i; i++;		// Set this to a number, and the move's move_cooldown[] will be set to it automatically. Set it to any negative number and it will refresh when landing, getting hit, or walljumping. (gets converted to positive when applied)
AG_MUNO_ATTACK_CD_SPECIAL = i; i++;		// Set various cooldown effects on a per-attack basis.
AG_MUNO_WINDOW_CD_SPECIAL = i; i++;		// Set various cooldown effects on a per-window basis.
AG_MUNO_WINDOW_INVUL = i; i++;			// -1: invulnerable    -2: super armor    above 0: that amount of soft armor

/*
 * AG_MUNO_ATTACK_CD_SPECIAL values:
 * - 1: the cooldown will use the phone_arrow_cooldown variable instead of move_cooldown[attack], causing it to display on the overhead player indicator; multiple attacks can share this cooldown.
 * - 2: the cooldown will use the phone_invis_cooldown variable instead of move_cooldown[attack], which doesn't display anywhere (unless you code your own HUD element) but does allow you to share the cooldown between moves.
 * 
 * AG_MUNO_WINDOW_CD_SPECIAL values:
 * - 1: a window will be exempted from causing cooldown. It is HIGHLY RECOMMENDED to do this for any startup windows, so that the cooldown doesn't apply if you're hit out of the move before being able to use it.
 * - 2: a window will reset the cooldown to 0.
 * - 3: a window will set cooldown only if the has_hit	      variable is false, and set it to 0 if has_hit        is true.
 * - 4: a window will set cooldown only if the has_hit_player variable is false, and set it to 0 if has_hit_player is true.
 */

i = phone.starting_hg_index;

HG_MUNO_HITBOX_EXCLUDE = i; i++;		// Set to 1 to exclude this hitbox from the frame data guide
HG_MUNO_HITBOX_NAME = i; i++;			// Enter a string to override hitbox name

HG_MUNO_HITBOX_ACTIVE = i; i++;			// Enter a string to override active frames
HG_MUNO_HITBOX_DAMAGE = i; i++;			// Enter a string to override damage
HG_MUNO_HITBOX_BKB = i; i++;			// Enter a string to override base knockback
HG_MUNO_HITBOX_KBG = i; i++;			// Enter a string to override knockback growth
HG_MUNO_HITBOX_ANGLE = i; i++;			// Enter a string to override angle
HG_MUNO_HITBOX_PRIORITY = i; i++;		// Enter a string to override priority
HG_MUNO_HITBOX_GROUP = i; i++;			// Enter a string to override group
HG_MUNO_HITBOX_BHP = i; i++;			// Enter a string to override base hitpause
HG_MUNO_HITBOX_HPG = i; i++;			// Enter a string to override hitpause scaling
HG_MUNO_HITBOX_MISC = i; i++;			// Enter a string to override the auto-generated misc notes (which include misc properties like angle flipper or elemental effect)
HG_MUNO_HITBOX_MISC_ADD = i; i++;		// Enter a string to ADD TO the auto-generated misc notes, not override (line break will be auto-inserted)

// Misc. Hitbox Traits
HG_MUNO_OBJECT_LAUNCH_ANGLE = i; i++;	// Override the on-hit launch direction of compatible Workshop objects, typically ones without gravity. For example, Otto uses this for the ball rehit angles. Feel free to code this into your attacks, AND to support it for your own hittable articles.

/* Set the obj launch angle to:
 * - -1 to send horizontally away (simulates flipper 3, angle 0)
 * - -2 to send radially away (simulates flipper 8)
 */

// Codec speakers
SPK_TRUM = 0;
SPK_ALTO = 1;
SPK_OTTO = 2;
SPK_CODA = 3;
SPK_ECHO = 4;
SPK_MINE = 5;
SPK_SEGA = 6;

// Guidance speakers
SPK_PIT	 = 0;
SPK_PALU = 1;
SPK_VIR	 = 2;
SPK_DPIT = 3;

// Codec gimmicks
GIM_CHOMP		= 2;
GIM_CLONE		= 3;
GIM_LAUGH_TRACK	= 5;
GIM_SKIP		= 7;
GIM_DIE			= 11;
GIM_SHUT_UP		= 13;
GIM_HOWL		= 17;
GIM_SHADER		= 19;
GIM_TEXTBOX		= 23;
GIM_COLOR		= 29;



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Post Draw																	║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_post_draw

if !phone_hud_hidden && draw_indicator{
	var col = (phone_arrow_cooldown && !(phone_arrow_cooldown - 1 < 25 && (phone_arrow_cooldown - 1) % 10 >= 5)) ? phone_darkened_player_color : get_player_hud_color(player);
	draw_sprite_ext(sprite_get("_pho_cooldown_arrow"), 0, x - 7, y - char_height - hud_offset - 28, 1, 1, 0, col, 1);
}



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ CSS Draw																	║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_css_draw

var is_online = get_player_hud_color(player) == $64e542;

shader_end();

// obsoleted by patch lol
// textDraw(x + 220, y + 210, "fName", c_white, 100, 1000, fa_right, 1, false, 0.25, "char ver. " + string(get_char_info(player, INFO_VER_MAJOR)) + "." + string(get_char_info(player, INFO_VER_MINOR)), false);

draw_sprite_ext(sprite_get("_pho_icon"), 0, x + 6, y + 42, 2, 2, 0, c_white, 1);

// Alt costume

var alt_cur = get_player_color(player);
user_event(15);

rectDraw(x + 10, y + 10, 202, 6, c_black);

var col = alt_ui_recolor == noone ? c_white : make_color_rgb(get_color_profile_slot_r(alt_cur, alt_ui_recolor), get_color_profile_slot_g(alt_cur, alt_ui_recolor), get_color_profile_slot_b(alt_cur, alt_ui_recolor));

// var offset = (alt_cur > 15) * 16;

// for (i = 0; i < (num_alts - offset) && i < 16; i++){
// 	var draw_color = (i == alt_cur - offset) ? col : c_gray * 0.5;
// 	var draw_x = x + 78 + 8 * i;
// 	rectDraw(draw_x, y + 10, 6, 4, draw_color);
// }

var thin = num_alts > 16;

for (i = 0; i < num_alts; i++){
	var draw_color = (i == alt_cur) ? col : c_gray * 0.5;
	var draw_x = x + 78 + (thin ? 4 : 8) * i;
	rectDraw(draw_x, y + 10, thin ? 2 : 6, 4, draw_color);
}

var txt = "#" + string(alt_cur);

rectDraw(x + 76, y + 15, 42, 21, c_black);

textDraw(x + 82, y + 19, "fName", col, 20, 1000, fa_left, 1, false, 1, txt, false);

if use_alt_names{
	if alt_cur < array_length(alt_names) && alt_names[alt_cur] != ""{
		rectDraw(x + 10, y + 142 - is_online * 12, string_width_ext(alt_names[alt_cur], 1000, 200), 10, c_black);
		textDraw(x + 10, y + 141 - is_online * 12, "fName", col, 1000, 200, fa_left, 1, true, 1, alt_names[alt_cur], false);
	}
}



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Draw HUD																	║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_draw_hud

if !array_equals(phone_offscreen, []){
	
	var spr_pho_offscreen = sprite_get("_pho_offscreen");
	
	var empty = 1;
	
	for (var i = 0; i < array_length(phone_offscreen); i++){
		if phone_offscreen[i] != noone{
			empty = 0;
			if !instance_exists(phone_offscreen[i]){
				phone_offscreen[i] = noone;
			}
			else with phone_offscreen[i]{
				var leeway = phone_offscr_leeway;
				
				var x_ = x + phone_offscr_x_offset * spr_dir;
				var y_ = y + phone_offscr_y_offset;
				
				var off_l = x_ < view_get_xview() - leeway;
				var off_r = x_ > view_get_xview() + view_get_wview() + leeway;
				var off_u = y_ < view_get_yview() - leeway;
				var off_d = y_ > view_get_yview() + view_get_hview() - 52 + leeway;
				
				var margin = 34;
				var idx = noone;
				
				if off_l{
					idx = 0;
					if off_u idx = 1;
					if off_d idx = 7;
				}
				else if off_r{
					idx = 4;
					if off_u idx = 3;
					if off_d idx = 5;
				}
				else if off_u idx = 2;
				else if off_d idx = 6;
				
				if idx != noone{
					draw_sprite_ext(spr_pho_offscreen, idx, clamp(x_ - view_get_xview(), margin, view_get_wview() - margin) - 32, clamp(y_ - view_get_yview(), margin, view_get_hview() - 52 - margin) - 32, 2, 2, 0, get_player_hud_color(player), 1);
					with other shader_start();
					draw_sprite_ext(phone_offscr_sprite, phone_offscr_index, clamp(x_ - view_get_xview(), margin, view_get_wview() - margin) - 32, clamp(y_ - view_get_yview(), margin, view_get_hview() - 52 - margin) - 32, 2, 2, 0, c_white, 1);
					with other shader_end();
				}
			}
		}
	}
	
	if empty phone_offscreen = [];
}

// onscreen text

if (fps_real) < 60 && !phone_online && phone.utils_cur[phone.UTIL_FPS_WARN]{
	draw_debug_text(32, 32, "Low FPS! (" + string(floor(fps_real)) + ")");
}

if phone_online && get_gameplay_time() < 300 draw_debug_text(10, 48, "ONLINE: Press the F1 key to enable Fast Graphics.");

if !phone.has_opened_yet && phone_practice{
	var x_pos = 20;
	var y_pos = view_get_hview() - 32 + (phone.state == 1) * phone.state_timer * 10;
	textDraw(x_pos, y_pos, "fName", c_white, 100, 100, fa_left, 1, true, 1, "Taunt!", true);
	draw_sprite_ext(sprite_get("_pho_icon"), 0, x_pos + phone.last_text_size[0] - 4, y_pos - 13, 2, 2, 0, c_white, 1);
}

// the phone itself

if phone.state == 0 return;

var phone_x = 80 + phone.x;
var phone_y = 264 + phone.y - sin(phone.click_bump_timer / 6) * 8;

maskHeader();
rectDraw(phone_x, phone_y, phone.screen_width, phone.screen_height, phone.apps[phone.app].color_dark);
maskMidder();
rectDraw(phone_x, phone_y, phone.screen_width, phone.screen_height, phone.apps[phone.app].color_dark);

if phone.app == phone.APP_HOME{
	for (var i = 1; i < array_length(phone.apps); i++){
		var app_sel = i == phone.cursor;
		var app_x = phone_x + 2 + app_sel * phone.cursor_change_timer + ease_backIn(0, phone.screen_width, phone.app_icon_slide_timer, phone.app_icon_slide_timer_max, 1);
		var app_y = phone_y + 10 + 38 * (i-1);
		drawAppIcon(app_x, app_y, i, app_sel);
	}
}

else if phone.app == phone.APP_POWER{
	var text_x = phone_x + phone.screen_width / 2 + 1 - ease_backIn(0, phone.screen_width, phone.app_icon_slide_timer, phone.app_icon_slide_timer_max, 1);
	var text_y = phone_y + 65;
	
	textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, true, 1, "ATTACK:", true);
	text_y += phone.last_text_size[1];
	textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, false, 1, "Disable Phone", true);
	text_y += phone.last_text_size[1];
	textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, true, 1, "SPECIAL:", true);
	text_y += phone.last_text_size[1];
	textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, false, 1, "Cancel", true);
	text_y += phone.last_text_size[1] * 2;
	textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, false, 1, "Press F5 to turn the Phone back on.", false);
}

else{
	var arr = phone.apps[phone.app].array;
	var text_x = phone_x + phone.screen_width / 2 + 1 - ease_backIn(0, phone.screen_width, phone.app_icon_slide_timer, phone.app_icon_slide_timer_max, 1);
	
	if array_length(arr){
		var text_y = phone_y + 59;
		text_y -= phone.scroll_dist;
		for (var i = 0; i < array_length(arr); i++){
			var sel = phone.cursor == i;
			textDraw(text_x + sel * phone.cursor_change_timer, text_y, "fName", sel ? c_white : phone.apps[phone.app].color, 18, phone.screen_width - 8, fa_center, 1, sel, 1, arr[i].name, true);
			text_y += phone.last_text_size[1] + 6;
		}
	}
	else{
		var text_y = phone_y + 65;
		textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, true, 1, "No " + phone.apps[phone.app].name + "
		Loaded", true);
		text_y += phone.last_text_size[1];
		textDraw(text_x, text_y, "fName", c_white, 18, phone.screen_width, fa_center, 1, false, 1, "bruhm oment", false);
	}
	
	rectDraw(phone_x, phone_y, phone.screen_width, 20, phone.apps[phone.app].color_dark);
}

if phone.app{
	// draw the app's icon at, like, the top of the screen or whatever
	var app_x = phone_x + 2;
	var app_y = phone_y + 10 + ease_backIn(0, 38 * (phone.app - 1), phone.app_icon_slide_timer, phone.app_icon_slide_timer_max, 1);
	drawAppIcon(app_x, app_y, phone.app, true);
}

maskFooter();

if phone.uses_shader shader_start();
draw_sprite_ext(sprite_get("_pho_base"), get_gameplay_time() / 4, phone_x - 68, phone_y - 136, 2, 2, 0, c_white, 1);
if phone.uses_shader shader_end();

#define drawAppIcon(app_x, app_y, i, app_sel)

if app_sel{
	draw_sprite_ext(sprite_get("_pho_app_icons"), 0, app_x, app_y, 2, 2, 0, c_white, 1);
}
draw_sprite_ext(sprite_get("_pho_app_icons"), i, app_x, app_y, 2, 2, 0, c_white, 1);
textDraw(app_x + 10, app_y + 13, "fName", app_sel ? c_white : phone.apps[i].color, 10000, 200, fa_left, 1, true, 1, phone.apps[i].name, false);


#define rectDraw(x1, y1, width, height, color)

draw_rectangle_color(x1, y1, x1 + width - 1, y1 + height - 1, color, color, color, color, false);

#define textDraw(x1, y1, font, color, lineb, linew, align, scale, outline, alpha, text, get_size)

x1 = round(x1);
y1 = round(y1);

draw_set_font(asset_get(font));
draw_set_halign(align);

if outline {
	for (i = -1; i < 2; i++) {
		for (j = -1; j < 2; j++) {
			draw_text_ext_transformed_color(x1 + i * 2, y1 + j * 2, text, lineb, linew, scale, scale, 0, c_black, c_black, c_black, c_black, alpha);
		}
	}
}

if alpha > 0.01 draw_text_ext_transformed_color(x1, y1, text, lineb, linew, scale, scale, 0, color, color, color, color, alpha);

if get_size phone.last_text_size = [string_width_ext(text, lineb, linew), string_height_ext(text, lineb, linew)];

#define maskHeader

gpu_set_blendenable(false);
gpu_set_colorwriteenable(false,false,false,true);
draw_set_alpha(0);
draw_rectangle_color(0,0, room_width, room_height, c_white, c_white, c_white, c_white, false);
draw_set_alpha(1);

#define maskMidder

gpu_set_blendenable(true);
gpu_set_colorwriteenable(true,true,true,true);
gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
gpu_set_alphatestenable(true);

#define maskFooter

gpu_set_alphatestenable(false);
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);

/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Big Screen																║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_big_screen(in_hud)

var phone_active = phone.state > 0;

if phone.big_screen_pos_offset < 1{
	var draw_w = view_get_wview();
	var draw_h = view_get_hview();
	var draw_x = view_get_xview() - draw_w * phone.big_screen_pos_offset;
	var draw_y = view_get_yview();
	
	if in_hud{
		draw_x -= view_get_xview();
		draw_y -= view_get_yview();
	}
	
	var margin_l = 256;
	var margin_r = 32;
	var margin_t = 32;
	var margin_b = 20;
	
	if phone.utils_cur[phone.UTIL_OPAQUE] == 0 || phone.utils_cur[phone.UTIL_OPAQUE] == 2 && !phone_active draw_set_alpha(0.75);
	rectDraw(draw_x, draw_y, draw_w, draw_h, c_black);
	draw_set_alpha(1);
	
	draw_x -= round(118 * (phone.y / phone.lowered_y));
	draw_y -= phone.cursor_change_timer;
	
	if array_length(phone.apps[phone.app].array) > 0{
		var item = phone.apps[phone.app].array[phone.cursor];
		
		if "page_starts" in item && array_length(item.page_starts) > 1{
			textDraw(draw_x + 140 - round(118 * (phone.y / phone.lowered_y)), draw_y + 201 - phone.extra_top_size, "fName", c_white, 1000, 1000, fa_center, 1, 0, 1, "Page " + string(phone.page + 1), 0);
			textDraw(draw_x + 140 - round(118 * (phone.y / phone.lowered_y)), draw_y + 222 - phone.extra_top_size, "fName", c_white, 1000, 1000, fa_center, 1, 0, 1, "ATTACK: " + (phone.page == array_length(item.page_starts) - 1 ? "First" : "Next"), 1);
		}
		
		else if "options" in item{
			textDraw(draw_x + 140 - round(118 * (phone.y / phone.lowered_y)), draw_y + 222 - phone.extra_top_size, "fName", c_white, 1000, 1000, fa_center, 1, 0, 1, "ATTACK: " + (array_length(item.options) > 1 ? (array_length(item.options) > 2 ? "Next Option" : "Toggle") : "Activate"), 1);
			if array_length(item.options) > 2 textDraw(draw_x + 140 - round(118 * (phone.y / phone.lowered_y)), draw_y + 201 - phone.extra_top_size, "fName", c_white, 1000, 1000, fa_center, 1, 0, 1, "JUMP: Previous Option", 1);
		}
	}
	
	var app_color = phone.apps[phone.app].color;
	
	// below: drawing the contents of the screen
	
	if phone.app == phone.APP_TIPS || phone.app == phone.APP_PATCHES{
	
		draw_y += ease_sineIn(0, 400, phone.page_change_timer, phone.page_change_timer_max);
		
		var text_x = draw_x + margin_l;
		var text_y = draw_y + margin_t;
		var reached_end = 0;
		for (var i = item.page_starts[phone.page]; i < array_length(item.objs) && !reached_end; i++){
			var obj = item.objs[i];
			switch(obj.type){
				case 0: // text
					var this_x = text_x;
					var this_w = draw_w - margin_l - margin_r;
					
					var indent_mult = 32 * (obj.align == fa_right ? -1 : 1)
					
					this_x += obj.indent * indent_mult;
					this_w -= obj.indent * indent_mult;
					
					switch(obj.align){
						case fa_center:
							this_x += this_w / 2;
							break;
						case fa_right:
							this_x += this_w;
							break;
					}
					
					textDraw(this_x, text_y, "fName", is_string(obj.color) ? app_color : obj.color, 18, this_w, obj.align, 1, 0, 1, obj.text, true);
					if !obj.side_by_side{
						text_y += phone.last_text_size[1] + 10;
					}
					break;
				case 1: // image
					var this_x = text_x;
					var this_w = draw_w - margin_l - margin_r;
					
					var x_off = sprite_get_xoffset(obj.sprite);
					var y_off = sprite_get_yoffset(obj.sprite);
					
					if obj.needs_auto_margins{
						obj.margin_l = x_off;
						obj.margin_r = sprite_get_width(obj.sprite) - x_off;
						obj.margin_u = y_off;
						obj.margin_d = sprite_get_height(obj.sprite) - y_off;
						
						obj.needs_auto_margins = false;
					}
					
					var draw_frame = obj.frame;
					
					if (draw_frame < 0){
						draw_frame = phone.state_timer / abs(draw_frame);
					}
					
					var img_l = x_off - obj.margin_l;
					var img_t = y_off - obj.margin_u;
					var img_w = (x_off + obj.margin_r) - (x_off - obj.margin_l);
					var img_h = (y_off + obj.margin_d) - (y_off - obj.margin_u);
					
					if sign(obj.xscale) == -1 this_x += img_w;
					
					switch(obj.align){
						case fa_center:
							this_x += this_w * 0.5 - img_w * abs(obj.yscale) * 0.5;
							break;
						case fa_right:
							this_x += this_w - img_w * (obj.xscale < 0 ? 1 : abs(obj.xscale));
							break;
					}
					
					if obj.uses_shader shader_start();
					draw_sprite_part_ext(obj.sprite, draw_frame, img_l, img_t, img_w, img_h, this_x, text_y + (sprite_get_height(obj.sprite) * abs(obj.yscale) * 0.5 * (sign(obj.yscale) == -1)), obj.xscale, obj.yscale, obj.color, obj.alpha);
					if obj.uses_shader shader_end();
					
					if !obj.side_by_side{
						text_y += img_h * abs(obj.yscale) + 10;
					}
					break;
			}
			
			if text_y > draw_y + draw_h - margin_b - 64{
				reached_end = true;
				if !array_find_index(item.page_starts, i){
					array_push(item.page_starts, i);
				}
			}
		}
	}
	
	else if phone.app == phone.APP_DATA{
		
		var text_x = draw_x + margin_l;
		var text_y = draw_y + margin_t;
				
		var this_w = draw_w - margin_l - margin_r;
		var this_x = text_x + this_w / 2;
		
		textDraw(this_x, text_y, "fName", app_color, 18, this_w, fa_center, 1, 0, 1, "- " + item.name + " -", true);
		
		text_y += phone.last_text_size[1] + 10;
		
		switch(item.type){
			case 1: // stats
				
				var stats_table = [
					
					// grounded
					"Walk Speed", walk_speed,
					"Walk Accel", walk_accel,
					"Dash Speed", dash_speed,
					"Initial Dash Speed", initial_dash_speed,
					"Initial Dash Time", initial_dash_time,
					"Ground Friction", ground_friction,
					"Waveland Adj", wave_land_adj,
					"Waveland Friction", wave_friction,
					
					// aerial
					"Max Air Speed", air_max_speed,
					"Air Accel", air_accel,
					"Pratfall Accel", prat_fall_accel,
					"Air Friction", air_friction,
					"Fall Speed", max_fall,
					"Fast Fall Speed", fast_fall,
					"Gravity", gravity_speed,
					"Hitstun Gravity", hitstun_grav,
					
					// jumps
					"Full Hop", jump_speed,
					"Short Hop", short_hop_speed,
					"DJump", djump_speed,
					"DJump Count", max_djumps,
					"Walljump HSP", walljump_hsp,
					"Walljump VSP", walljump_vsp,
					"Max Jump Speed", max_jump_hsp,
					"DJump Change", jump_change,
					
					// misc
					"Knockback Adj", knockback_adj,
					"Jumpsquat Time", jump_start_time,
					"Leave Ground Max", leave_ground_max,
					"Prat Land Time", prat_land_time,
					"Land Time", land_time,
					"Notes", phone.stats_notes,
					]
				
				var orig_y = text_y;
				
				for (var i = 0; i < array_length(stats_table); i += 2){
					textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, stats_table[i], true);
					text_y += phone.last_text_size[1];
					textDraw(text_x + 16, text_y, "fName", c_white, 18, 100, fa_left, 1, 0, 1, decimalToString(stats_table[i+1]), true);
					text_y += phone.last_text_size[1];
					
					if text_y > draw_y + draw_h - margin_b * 8{
						text_y = orig_y;
						text_x += 160;
					}
				}
				break;
			case 2: // a move
				textDraw(draw_x + view_get_wview() - 9 + round(118 * 3 * (phone.y / phone.lowered_y)), draw_y + 32, "fName", c_white, 1000, 1000, fa_right, 1, 0, 1, "JUMP: Refresh", 1);
				
				var orig_x = text_x;
				var orig_y = text_y;
				
				textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, "Length (Whiff):", true);
				text_x += phone.last_text_size[0] + 8;
				textDraw(text_x, text_y, "fName", c_white, 18, 100, fa_left, 1, 0, 1, item.length, false);
				text_x = orig_x + 240;
				textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, "Ending Lag (Whiff):", true);
				text_x += phone.last_text_size[0] + 8;
				textDraw(text_x, text_y, "fName", c_white, 18, 100, fa_left, 1, 0, 1, item.ending_lag, false);
				text_x = orig_x + 480;
				textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, "Landing Lag (Whiff):", true);
				text_x += phone.last_text_size[0] + 8;
				textDraw(text_x, text_y, "fName", c_white, 18, 100, fa_left, 1, 0, 1, item.landing_lag, false);
				
				text_x = orig_x;
				text_y += phone.last_text_size[1];
				
				if item.misc != "-"{
					textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, "Notes:", true);
					text_x += phone.last_text_size[0] + 8;
					textDraw(text_x, text_y, "fName", c_white, 18, draw_w - margin_l - margin_r - 64, fa_left, 1, 0, 1, item.misc, true);
					text_y += phone.last_text_size[1];
					text_x = orig_x;
				}
				
				if array_length(item.hitboxes){
					text_y += 10;
					var add_x = 64;
					var stats_table = [
						"Active",
						"DMG",
						"BKB",
						"KBG",
						"Angle",
						"Pri.",
						"BHP",
						"HPG",
						];
					
					text_x += add_x * 2;
					
					for (var i = 0; i < array_length(stats_table); i++){
						textDraw(text_x, text_y, "fName", app_color, 18, 24, fa_left, 1, 0, 1, stats_table[i], true);
						text_x += add_x;
					}
					
					text_y += phone.last_text_size[1] + 10;
					
					var reached_end = false;
	
					text_y += ease_sineIn(0, 240, phone.page_change_timer, phone.page_change_timer_max);
					
					for (var i = item.page_starts[phone.page]; i < array_length(item.hitboxes) && !reached_end; i++){
						text_x = orig_x;
						var hb = item.hitboxes[i];
						stats_table = [
							hb.active,
							hb.damage,
							hb.base_kb,
							hb.kb_scale,
							hb.angle,
							hb.priority,
							hb.base_hitpause,
							hb.hitpause_scale,
							];
						textDraw(text_x, text_y, "fName", app_color, 18, 120, fa_left, 1, 0, 1, item.hitboxes[i].name, false);
						text_x += add_x * 2;
					
						for (var j = 0; j < array_length(stats_table); j++){
							textDraw(text_x, text_y, "fName", hb.parent_hbox && hb.parent_hbox != i + 1 && j > 0 ? c_gray : c_white, 18, 24, fa_left, 1, 0, 1, stats_table[j], true);
							text_x += add_x;
						}
						
						text_y += phone.last_text_size[1];
						
						if hb.misc != "-"{
							text_x = orig_x + add_x * 2;
							textDraw(text_x, text_y, "fName", c_gray, 18, draw_w - margin_l - margin_r - 128, fa_left, 1, 0, 1, hb.misc, true);
							text_y += phone.last_text_size[1];
						}
						
						text_y += 10;
						
						if text_y - ease_sineIn(0, 240, phone.page_change_timer, phone.page_change_timer_max) > draw_y + draw_h - margin_b - 64{
							reached_end = true;
							if !array_find_index(item.page_starts, i){
								array_push(item.page_starts, i);
							}
						}
					}
				}
				break;
			case 3: // custom
				var orig_y = text_y;
				
				for (var i = 0; i < array_length(phone.custom_fd_content); i++){
					var cur = phone.custom_fd_content[i];
					switch(cur.type){
						case 0: // header
							textDraw(text_x, text_y, "fName", app_color, 18, 160, fa_left, 1, 0, 1, cur.content, true);
							text_y += phone.last_text_size[1];
							break;
						case 1: // body
							textDraw(text_x + 16, text_y, "fName", c_white, 18, 100, fa_left, 1, 0, 1, cur.content, true);
							text_y += phone.last_text_size[1];
							if text_y > draw_y + draw_h - margin_b * 8{
								text_y = orig_y;
								text_x += 160;
							}
							break;
					}
				}
				break;
		}
	}
	
	else if phone.app == phone.APP_CHEATS || phone.app == phone.APP_UTILS{
		
		var text_x = draw_x + margin_l;
		var text_y = draw_y + margin_t;
		
		var this_w = draw_w - margin_l - margin_r;
		var this_x = round(text_x + this_w / 2);
		
		textDraw(this_x, text_y, "fName", app_color, 18, this_w, fa_center, 1, 0, 1, "- " + item.name + " -", true);
		text_y += phone.last_text_size[1] + 10;
		textDraw(this_x, text_y, "fName", c_white, 18, this_w, fa_center, 1, 0, 1, item.description, true);
		text_y += phone.last_text_size[1] + 30;
		
		
		rectDraw(text_x + 64, text_y - 19, this_w - 128, 2, app_color);
		
		var num_options = array_length(item.option_names);
		
		if num_options > 1{
			var col_height = 10;
			var num_cols = min(4, ceil(num_options / col_height));
			var col_spacing = 96 + 32 * (5 - num_cols);;
			var avg_col = (num_cols - 1) / 2;
			
			for (var j = 0; j < num_cols; j++){
				var col_x = this_x + (j - avg_col) * col_spacing;
				var col_y = text_y;
				for (var i = j * col_height; i < (j + 1) * col_height && i < num_options; i++){
					var to_draw = item.option_names[i];
					if item.on == i to_draw = "> " + to_draw + " <";
					textDraw(col_x, col_y, "fName", item.on == i ? c_white : c_gray, 18, this_w, fa_center, 1, 0, 1, to_draw, true);
					col_y += phone.last_text_size[1] + 10;
				}
			}
		}
		else{
			var to_draw = "> Click to Activate <";
			textDraw(this_x, text_y, "fName", c_white, 18, this_w, fa_center, 1, 0, 1, to_draw, true);
		}
	}
}
	
if phone.utils_cur[phone.UTIL_GREEN] && !phone_active rectDraw(0, 0, room_width, room_height, c_lime);



/*
array_push(utils, {
	name: ch_name,
	options: ch_opt,
	option_names: ch_opt_name,
	description: ch_desc,
	on: 0
});
*/



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Update																	║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_update

// one-time stuff

if phone_practice && !phone.frame_data_loaded{
	loadFrameData();
	phone.frame_data_loaded = true;
}

if !phone.lightweight{
	
	if !phone_game_over{
		var dead = [1, 1, 1, 1];
		with oPlayer if state != PS_DEAD{
			dead[get_player_team(player) - 1] = 0;
		}
		if dead[0] + dead[1] + dead[2] + dead[3] > 2{
			phone_game_over = true;
		}
	}

	if !phone_char_ided{
		with oPlayer if self != other{
			if "muno_char_id" not in self muno_char_id = noone;
			if "muno_char_name" not in self muno_char_name = get_char_info(player, INFO_STR_NAME);
			if "muno_char_icon" not in self muno_char_icon = get_char_info(player, INFO_ICON);
			if (muno_char_id == other.muno_char_id && muno_char_id != noone) || "url" in self && url == other.url{
				other.phone_ditto = true;
				phone_ditto = true;
			}
		}
		phone_char_ided = true;
	}
	
	// general update utils - attacks
			
	if phone_arrow_cooldown > 0 phone_arrow_cooldown--;
	if phone_invis_cooldown > 0 phone_invis_cooldown--;
	
	phone_landing = (!free || state == PS_WALL_JUMP || state_cat == SC_HITSTUN || state == PS_RESPAWN);
	
	if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND){
		phone_attacking = 1;
		phone_window_end = floor(get_window_value(attack, window, AG_WINDOW_LENGTH) * ((get_window_value(attack, window, AG_WINDOW_HAS_WHIFFLAG) && !has_hit) ? 1.5 : 1));
	}
	else{
		if phone_attacking && (state == PS_LANDING_LAG || state == PS_PRATLAND || state_cat == SC_HITSTUN || !visible){
			if !array_equals(phone_stopped_sounds, []){
				for (var ii = 0; ii < array_length(phone_stopped_sounds); ii++){
					sound_stop(phone_stopped_sounds[ii]);
				}
				phone_stopped_sounds = [];
			}
		}
		phone_attacking = 0;
	}
	
	if phone_attacking{
		if phone_using_invul && !phone_invul_override && array_find_index(muno_invul_checked, attack) != -1{
			super_armor = false;
			invincible = false;
			soft_armor = 0;
			
			switch(get_window_value(attack, window, AG_MUNO_WINDOW_INVUL)){
				case -1:
					invincible = true;
					break;
				case -2:
					super_armor = true;
					break;
				case 0:
					break;
				default:
					soft_armor = get_window_value(attack, window, AG_MUNO_WINDOW_INVUL);
					break;
			}
		}
		
		phone_invul_override = 0;
		
		if get_attack_value(attack, AG_MUNO_ATTACK_COOLDOWN) != 0{
			
			var set_amt = abs(get_attack_value(attack, AG_MUNO_ATTACK_COOLDOWN));
			
			switch (get_window_value(attack, window, AG_MUNO_WINDOW_CD_SPECIAL)){
				case 1:
					set_amt = -1;
					break;
				case 2:
					set_amt = 0;
					break;
				case 3:
					if has_hit set_amt = 0;
					break;
				case 4:
					if has_hit_player set_amt = 0;
					break;
			}
			
			if set_amt != -1 switch (get_attack_value(attack, AG_MUNO_ATTACK_CD_SPECIAL)){
				case 0:
					move_cooldown[attack] = set_amt;
					break;
				case 1:
					phone_arrow_cooldown = set_amt;
					break;
				case 2:
					phone_invis_cooldown = set_amt;
					break;
			}
		}
	}
	
	if phone_using_landing_cd == noone{
		phone_using_landing_cd = 0;
		phone_using_invul = 0;
		muno_cooldown_checked = [];
		muno_invul_checked = [];
		for (var checked_move = 0; checked_move < 50; checked_move++){
			if (get_attack_value(checked_move, AG_MUNO_ATTACK_COOLDOWN) < 0){
				phone_using_landing_cd = 1;
				array_push(muno_cooldown_checked, checked_move);
			}
			for (var checked_window = 1; get_window_value(checked_move, checked_window, AG_WINDOW_LENGTH) > 0; checked_window++){
				if (get_window_value(checked_move, checked_window, AG_MUNO_WINDOW_INVUL) != 0){
					phone_using_invul = 1;
					array_push(muno_invul_checked, checked_move);
				}
			}
		}
	}
	
	if phone_using_landing_cd && phone_landing{
		for (var checked_move = 0; checked_move < array_length(muno_cooldown_checked); checked_move++){
			switch (get_attack_value(muno_cooldown_checked[checked_move], AG_MUNO_ATTACK_CD_SPECIAL)){
				case 0:
					move_cooldown[muno_cooldown_checked[checked_move]] = 0;
					break;
				case 1:
					phone_arrow_cooldown = 0;
					break;
				case 2:
					phone_invis_cooldown = 0;
					break;
			}
		}
	}
	
	// general update utils - misc

	if phone_practice && state == PS_RESPAWN{
		visible = true;
	}
	
	if phone.supports_fast_graphics{
		phone_fast = phone.utils[phone.UTIL_FAST].on;
	
		if !phone_fast && ((!phone_online && fps_real < 60) || (phone_online && keyboard_key == 112)) && !phone.state && !phone.dont_fast && state != PS_SPAWN && (state != PS_IDLE || state_timer > 5){
			if phone_lagging < 1 phone_lagging += 0.2;
			else{
				if (phone_online && keyboard_key == 48){
					print_debug("FAST GRAPHICS ENABLED - F1 KEY PRESSED");
				}
				else{
					print_debug("FAST GRAPHICS ENABLED - FPS REACHED " + string(fps_real));
				}
				phone.utils[phone.UTIL_FAST].on = 1;
				phone.utils_cur[phone.UTIL_FAST] = 1;
				phone.utils_cur_updated[phone.UTIL_FAST] = 1;
				phone_lagging = 1;
			}
		}
		else if phone_lagging != 1 phone_lagging = 0;
	}

	if array_length(phone_dust_query){
		for(var i = 0; i < array_length(phone_dust_query); i++){
			var cur = phone_dust_query[i];
			spawn_base_dust(cur[0], cur[1], cur[2], cur[3]);
		}
		phone_dust_query = [];
	}
} // END LIGHTWEIGHT

if phone_practice{

	if phone.utils_cur[phone.UTIL_DMG_FREEZE]{
		set_player_damage(player, phone_frozen_damage);
	}
	
	if phone.utils_cur_updated[phone.UTIL_DMG_FREEZE]{
		phone.utils_cur_updated[phone.UTIL_DMG_FREEZE] = 0;
		phone_frozen_damage = get_player_damage(player);
	}
	
	if phone.utils_cur_updated[phone.UTIL_STATE_SAVE]{
		phone.utils_cur_updated[phone.UTIL_STATE_SAVE] = 0;
		
		with oPlayer{
			phone_save_state_x = x;
			phone_save_state_y = y;
			phone_save_state_spr_dir = spr_dir;
			phone_save_state_dmg = get_player_damage(player);
			spawn_hit_fx(x, y - 32, 301);
		}
	}
	
	if phone.utils_cur_updated[phone.UTIL_STATE_LOAD]{
		phone.utils_cur_updated[phone.UTIL_STATE_LOAD] = 0;
	
		var found = 0;
		
		with oPlayer{
			if "phone_save_state_x" in self{
				x = phone_save_state_x;
				y = phone_save_state_y;
				spr_dir = phone_save_state_spr_dir;
				set_player_damage(player, phone_save_state_dmg);
				spawn_hit_fx(x, y - 32, 301);
			}
			else if !found{
				print_debug("Position and damage not saved!");
				found = 1;
			}
		}
	}
	
	if phone.utils_cur[phone.UTIL_CPU] && phone_practice{
		with oPlayer if "url" in self{
			if (burned && burnt_id.url == CH_ZETTERBURN && get_player_hud_color(burnt_id.player) == c_gray) burned = 0;
			if get_player_hud_color(player) == c_gray{
				if (url == CH_KRAGG) can_up_b = 0;
				if (url == CH_FORSBURN) move_cooldown[AT_FSPECIAL] = 2;
				if (url == CH_SHOVEL_KNIGHT){
					gems = 0;
					if (state == PS_ATTACK_AIR && window == 1 && window_timer == 1){
						set_num_hitboxes(AT_USPECIAL, 0);
						set_num_hitboxes(AT_FSPECIAL, 0);
					}
				}
			}
			if (url != CH_MAYPUL) marked = false;
			if (url != CH_RANNO) poison = 0;
		}
	}
	
	if phone.utils_cur[phone.UTIL_PARRY] && get_training_cpu_action() == CPU_PARRY{
		with oPlayer if self != other && state == PS_PARRY && window == 1 && !hitpause && !invincible window_timer = 1;
	}
	
	if phone.utils_cur[phone.UTIL_ATTACK]{
		var atk = phone.utils_cur[phone.UTIL_ATTACK];
		with oPlayer if get_player_hud_color(player) == c_gray && (state == PS_FIRST_JUMP && vsp != 0 || state == PS_CROUCH){
			if (state == PS_FIRST_JUMP){
				vsp = -short_hop_speed;
			}
			set_attack(atk);
		}
	}
}

// phone logic

if phone_practice switch(phone.state){
	case 0: // closed
		phone.y = phone.lowered_y;
		break;
	case 1: // opening
		var s_t_max = 15;
		phone.y = ease_backOut(phone.lowered_y, 0, phone.state_timer, s_t_max, 1);
		if phone.app == 0 phone.cursor = 1;
		if phone.state_timer >= s_t_max{
			setPhoneState(2);
			phone.has_opened_yet = true;
		}
		break;
	case 2: // opened
		phone.y = 0;
		
		if phone.app == phone.APP_HOME{
			var sel = normalListLogic(true);
			if sel != -1{
				setPhoneApp(sel);
				sound_play(sfx_pho_open_app, false, 0);
				phoneAppIconSlide();
				phone.cursor = 0;
			}
		}
		
		else if phone.app == phone.APP_TIPS || phone.app == phone.APP_PATCHES{
			var sel = normalListLogic(false);
		}
		
		else if phone.app == phone.APP_DATA{
			var sel = normalListLogic(false);
			if sel == -1 && jump_pressed{
				sound_play(sfx_pho_power_on, false, 0);
				print("Frame Data reloaded!");
				phone.data = [];
				phone.apps[phone.APP_DATA].array = phone.data;
				loadFrameData();
				clear_button_buffer(PC_JUMP_PRESSED);
			}
		}
		
		else if phone.app == phone.APP_CHEATS || phone.app == phone.APP_UTILS{
			var sel = normalListLogic(false);
		}
		
		else if phone.app == phone.APP_POWER{
			if attack_pressed{
				clear_button_buffer(PC_ATTACK_PRESSED);
				setPhoneState(4);
				sound_play(sfx_pho_power_off, false, 0);
			}
		}
		
		else{
			setPhoneApp(0);
		}
		
		if special_pressed{
			if phone.app{
				phone.cursor = phone.app;
				setPhoneApp(0);
				phoneAppIconSlide();
				sound_play(sfx_pho_close_app, false, 0);
			}
			else{
				setPhoneState(3);
				sound_play(sfx_pho_close, false, 0);
			}
			clear_button_buffer(PC_SPECIAL_PRESSED);
		}
		else if shield_pressed || taunt_pressed{
			setPhoneState(3);
			sound_play(sfx_pho_close, false, 0);
			clear_button_buffer(PC_SHIELD_PRESSED);
			clear_button_buffer(PC_TAUNT_PRESSED);
		}
		
		break;
	case 3: // closing
		var s_t_max = 15;
		phone.y = ease_backIn(0, phone.lowered_y, phone.state_timer, s_t_max, 1);
		if phone.state_timer >= s_t_max{
			setPhoneState(0);
		}
		break;
	case 4: // closing... forever!
		var s_t_max = 15;
		phone.y = ease_backIn(0, phone.lowered_y, phone.state_timer, s_t_max, 1);
		if phone.state_timer >= s_t_max{
			setPhoneState(0);
			phone_practice = 0;
		}
		break;
}

if phone_practice phoneBigScreen(phone.app == clamp(phone.app, phone.APP_TIPS, phone.APP_UTILS) && array_length(phone.apps[phone.app].array));
else phone.big_screen_pos_offset = 1;

if ((state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) && attack == AT_PHONE){
	soft_armor = 9999;
	if (window == 2){
		hsp = 0;
		vsp = 0;
		can_move = false;
		can_fast_fall = false;
		
		switch(phone.state){
			case 0:
			case 3:
				window++;
				window_timer = 0;
				break;
		}
	}
}

phone.state_timer++;
if phone.click_bump_timer{
	phone.click_bump_timer--;
}
if phone.app_icon_slide_timer{
	phone.app_icon_slide_timer--;
}
if phone.cursor_change_timer{
	phone.cursor_change_timer--;
}
if phone.page_change_timer{
	phone.page_change_timer--;
}

#define phoneBigScreen(should_be_displayed)

phone.big_screen_pos_offset = lerp(phone.big_screen_pos_offset, !should_be_displayed, 0.4);

#define phoneCursorChange

phone.cursor_change_timer = phone.cursor_change_timer_max;

#define phoneAppIconSlide

phone.app_icon_slide_timer = phone.app_icon_slide_timer_max;

#define phoneClickBump

phone.click_bump_timer = phone.click_bump_timer_max;

#define phonePageChange

phone.page_change_timer = phone.page_change_timer_max;

#define setPhoneApp(n_a)

phone.app = n_a;
phone.page = 0;
phoneClickBump();

#define setPhoneState(n_s)

phone.state = n_s;
phone.state_timer = 0;

#define normalListLogic(ignore_0th)

var arr = phone.apps[phone.app].array;
var len = array_length_1d(arr);

if len == 0 return -1;

var pages_valid = 0;

if (!joy_pad_idle && "held_timer" in self) && array_length(arr) > 1{
	held_timer++;
	
	var held = held_timer > 24 && held_timer mod 5 == 0;
	
	if (down_pressed || (down_down && held)){
		phone.cursor++;
		phone.page = 0;
		phoneCursorChange();
		sound_play(phone.app ? sfx_pho_move : sfx_pho_move_home, false, 0);
	}
	
	else if (up_pressed || (up_down && held)){
		phone.cursor--;
		phone.page = 0;
		phoneCursorChange();
		sound_play(phone.app ? sfx_pho_move : sfx_pho_move_home, false, 0);
		if ignore_0th && phone.cursor == 0{
			phone.cursor = len - 1;
		}
	}
	
	phone.cursor = (phone.cursor + len) % len;
}
else{
	held_timer = 0;
}
	
if "page_starts" in arr[phone.cursor] && array_length(arr[phone.cursor].page_starts) > 1{
	pages_valid = 1;
	var pgs = array_length(arr[phone.cursor].page_starts);
	if attack_pressed{
		phone.page++;
		phoneCursorChange();
		clear_button_buffer(PC_ATTACK_PRESSED);
		phonePageChange();
		sound_play(sfx_pho_page, false, 0);
	}
	phone.page = (phone.page + pgs) % pgs;
}

if "options" in arr[phone.cursor]{
	pages_valid = 1;
	var opts = array_length(arr[phone.cursor].options);
	var utiling = phone.app == phone.APP_UTILS;
	var cheating = phone.app == phone.APP_CHEATS;
	var cursor_change = (attack_pressed - jump_pressed);
	if cursor_change != 0{
		arr[phone.cursor].on += cursor_change;
		if utiling phone.utils_cur_updated[phone.cursor] = 1;
		if cheating phone_cheats_updated[phone.cursor] = 1;
		phoneCursorChange();
		clear_button_buffer(PC_ATTACK_PRESSED);
		clear_button_buffer(PC_JUMP_PRESSED);
		phonePageChange();
		sound_play(sfx_pho_page, false, 0);
	}
	arr[phone.cursor].on = (arr[phone.cursor].on + opts) % opts;
	if utiling phone.utils_cur[phone.cursor] = arr[phone.cursor].options[arr[phone.cursor].on];
	if cheating phone_cheats[phone.cursor] = arr[phone.cursor].options[arr[phone.cursor].on];
}

if phone.app > 0{
	phone.target_scroll_dist = 0;
	var total_height = 0;
	var found_cursor = 0;
	
	for (var i = 0; i < array_length(arr); i++){
		textDraw(0, 0, "fName", c_white, 18, phone.screen_width - 8, fa_center, 1, 0, 0, arr[i].name, true);
		total_height += phone.last_text_size[1] + 6;
		if !found_cursor phone.target_scroll_dist += phone.last_text_size[1] + 6;
		if phone.cursor == i{
			found_cursor = true;
			phone.target_scroll_dist -= phone.last_text_size[1] * 0.5;
		}
	}
	
	phone.target_scroll_dist = max(0, min(phone.target_scroll_dist - 80, total_height - 180));
	
	phone.scroll_dist = lerp(phone.scroll_dist, phone.target_scroll_dist, 0.5);
}
else{
	phone.scroll_dist = 0;
	phone.target_scroll_dist = 0;
}

if ignore_0th && phone.cursor == 0{
	phone.cursor = 1;
}

if attack_pressed && !pages_valid{
	clear_button_buffer(PC_ATTACK_PRESSED);
	return phone.cursor;
}
return -1;



/*
╔═══════════════════════════════════════════════════════════════════════════╗
║																			║
║ Set Attack																║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

#define CORE_set_attack

phone_stopped_sounds = [];

if get_attack_value(attack, AG_MUNO_ATTACK_COOLDOWN) != 0 switch (get_attack_value(attack, AG_MUNO_ATTACK_CD_SPECIAL)){
	case 1:
		move_cooldown[attack] = phone_arrow_cooldown;
		break;
	case 2:
		move_cooldown[attack] = phone_invis_cooldown;
		break;
}

if (attack == AT_TAUNT && joy_pad_idle && phone_practice) || attack == AT_PHONE{
	attack = AT_PHONE;
	with phone setPhoneState(1);
	sound_play(phone.has_opened_yet ? sfx_pho_open : sfx_pho_power_on, false, 0);
}



#define loadFrameData

i = 0; // i = current spot in the registered move list

if phone.include_stats initStats();
if phone.include_custom initCustom();

for (j = 0; j < array_length_1d(phone.move_ordering); j++){ // j = index in array of ordered attack indexes
	var current_attack_index = phone.move_ordering[j];
	if (get_window_value(current_attack_index, 1, AG_WINDOW_LENGTH) || get_hitbox_value(current_attack_index, 1, HG_HITBOX_TYPE)) && !get_attack_value(current_attack_index, AG_MUNO_ATTACK_EXCLUDE){
		initMove(current_attack_index, phone.attack_names[current_attack_index]);
	}
}



#define initStats

array_push(phone.data, {
	name: "Stats",
	type: 1 // stats
});

#define initCustom

array_push(phone.data, {
	name: phone.custom_name,
	type: 3 // custom
});



#define initMove(atk_index, default_move_name)

var def = "-";
var n = 0, hh = 0;

var stored_name = pullAttackValue(atk_index, AG_MUNO_ATTACK_NAME, default_move_name);

var stored_timeline = [];
if get_attack_value(atk_index, AG_MUNO_ATTACK_USES_ROLES) for (n = 0; get_window_value(atk_index, n+1, AG_WINDOW_LENGTH); n++){
	if get_window_value(atk_index, n+1, AG_MUNO_WINDOW_ROLE) stored_timeline[array_length_1d(stored_timeline)] = n+1;
}
else if get_attack_value(atk_index, AG_NUM_WINDOWS) for (n = 0; n < get_attack_value(atk_index, AG_NUM_WINDOWS); n++){
	if !(get_window_value(atk_index, n+1, AG_MUNO_WINDOW_EXCLUDE) == 1) stored_timeline[array_length_1d(stored_timeline)] = n+1;
}
else{
	stored_timeline = 0;
}

var stored_length = def;
if is_array(stored_timeline){
	stored_length = 0;
	for (n = 0; n < array_length_1d(stored_timeline); n++){
		if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 2) stored_length += get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH);
	}
	var stored_length_w = 0;
	for (n = 0; n < array_length_1d(stored_timeline); n++){
		if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 3) stored_length_w += ceil(get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[n], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1));
	}
	stored_length = decimalToString(stored_length) + ((stored_length == stored_length_w) ? "" : " (" + decimalToString(stored_length_w) + ")");
}
stored_length = pullAttackValue(atk_index, AG_MUNO_ATTACK_FAF, stored_length);

var stored_ending_lag = def;
if (is_array(stored_timeline)){
	var time_int = 0;
	var time_int_whiff = 0;
	if get_attack_value(atk_index, AG_MUNO_ATTACK_USES_ROLES){
		for (n = 0; n < array_length_1d(stored_timeline); n++){
			if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_ROLE) == 3){
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 2) time_int += get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH);
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 3) time_int_whiff += ceil(get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[n], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1));
			}
		}
	}
	else{
		for (n = 0; n < array_length_1d(stored_timeline); n++){
			var last_hitbox_frame = 0;
			var test_me = 0;
			for (hh = 0; get_hitbox_value(atk_index, hh, HG_HITBOX_TYPE); hh++){
				if (get_hitbox_value(atk_index, hh, HG_WINDOW) == stored_timeline[n]){
					test_me = get_hitbox_value(atk_index, hh, HG_LIFETIME) + get_hitbox_value(atk_index, hh, HG_WINDOW_CREATION_FRAME);
					if get_hitbox_value(atk_index, hh, HG_HITBOX_TYPE) == 2 test_me = -1;
					if abs(test_me) > last_hitbox_frame last_hitbox_frame = test_me;
				}
			}
			if last_hitbox_frame > 0{
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 2) time_int = get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) - last_hitbox_frame;
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 3) time_int_whiff = ceil(get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[n], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1) - last_hitbox_frame);
			}
			else if last_hitbox_frame == -1{ // projectile
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 2) time_int = get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH);
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 3) time_int_whiff = ceil(get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[n], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1));
			}
			else{
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 2) time_int += get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH);
				if (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_EXCLUDE) != 3) time_int_whiff += ceil(get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[n], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1));
			}
		}
	}
	
	if time_int && decimalToString(time_int) != stored_length{
		stored_ending_lag = decimalToString(time_int);
		if time_int != time_int_whiff stored_ending_lag += " (" + decimalToString(time_int_whiff) + ")";
	}
}
stored_ending_lag = pullAttackValue(atk_index, AG_MUNO_ATTACK_ENDLAG, stored_ending_lag);

var stored_landing_lag = def;
if (get_attack_value(atk_index, AG_HAS_LANDING_LAG) && get_attack_value(atk_index, AG_CATEGORY) == 1){
	stored_landing_lag = decimalToString(get_attack_value(atk_index, AG_LANDING_LAG));
	if get_attack_value(atk_index, AG_LANDING_LAG) stored_landing_lag += " (" + decimalToString(ceil(get_attack_value(atk_index, AG_LANDING_LAG) * 1.5)) + ")";
}
stored_landing_lag = pullAttackValue(atk_index, AG_MUNO_ATTACK_LANDING_LAG, stored_landing_lag);

var stored_misc = def;

if (get_attack_value(atk_index, AG_STRONG_CHARGE_WINDOW) != 0){
	var found = false;
	var strong_charge_frame = 0;
	for (var iter = 0; iter < array_length(stored_timeline) && !found; iter++){
		strong_charge_frame += ceil(get_window_value(atk_index, stored_timeline[iter], AG_WINDOW_LENGTH) * (get_window_value(atk_index, stored_timeline[iter], AG_WINDOW_HAS_WHIFFLAG) ? 1.5 : 1));
		if stored_timeline[iter] == get_attack_value(atk_index, AG_STRONG_CHARGE_WINDOW) found = true;
	}
	if found stored_misc = checkAndAdd(stored_misc, "Charge frame: " + decimalToString(strong_charge_frame));
}
	
if is_array(stored_timeline){
	var total_frames = 0;
	for (n = 0; n < array_length_1d(stored_timeline); n++){
		var frames = string(total_frames + 1) + "-" + string(total_frames + get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH));
		switch (get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_INVUL)){
			case -1:
				stored_misc = checkAndAdd(stored_misc, "Invincible f" + frames);
				break;
			case -2:
				stored_misc = checkAndAdd(stored_misc, "Super Armor f" + frames);
				break;
			case 0:
				break;
			default:
				stored_misc = checkAndAdd(stored_misc, string(get_window_value(atk_index, stored_timeline[n], AG_MUNO_WINDOW_INVUL)) + " Soft Armor f" + frames);
				break;
		}
		total_frames += get_window_value(atk_index, stored_timeline[n], AG_WINDOW_LENGTH);
	}
}

if (get_attack_value(atk_index, AG_MUNO_ATTACK_COOLDOWN) != 0)
	stored_misc = checkAndAdd(stored_misc, "Cooldown: " + string(abs(get_attack_value(atk_index, AG_MUNO_ATTACK_COOLDOWN))) + "f" + ((get_attack_value(atk_index, AG_MUNO_ATTACK_COOLDOWN) > 0) ? "" : " until land/walljump/hit"));
if (get_attack_value(atk_index, AG_MUNO_ATTACK_MISC_ADD) != 0)
	stored_misc = checkAndAdd(stored_misc, get_attack_value(atk_index, AG_MUNO_ATTACK_MISC_ADD));
if (get_attack_value(atk_index, AG_MUNO_ATTACK_MISC) != 0)
	stored_misc = get_attack_value(atk_index, AG_MUNO_ATTACK_MISC);

array_push(phone.data, {
	type: 2, // an actual move
	index: atk_index,
	name: stored_name,
	length: stored_length,
	ending_lag: stored_ending_lag,
	landing_lag: stored_landing_lag,
	hitboxes: [],
	page_starts: [0],
	num_hitboxes: get_num_hitboxes(atk_index),
	timeline: stored_timeline,
	misc: stored_misc
});

for (var l = 1; get_hitbox_value(atk_index, l, HG_HITBOX_TYPE); l++){
	if !get_hitbox_value(atk_index, l, HG_MUNO_HITBOX_EXCLUDE) initHitbox(array_length(phone.data) - 1, l);
}



#define pullAttackValue(move, index, def)

if is_string(get_attack_value(move, index)) return get_attack_value(move, index);
else return def;



#define initHitbox(move_index, index)

var def = "-";
var n = 0;

current_move = move_index;

var atk_index = phone.data[move_index].index;
var move = phone.data[move_index];
var parent = get_hitbox_value(atk_index, index, HG_PARENT_HITBOX);
if parent == index parent = 0;

var stored_active = def;
if is_array(phone.data[move_index].timeline){
	var win = get_hitbox_value(atk_index, index, HG_WINDOW);
	var w_f = get_hitbox_value(atk_index, index, HG_WINDOW_CREATION_FRAME);
	var lif = get_hitbox_value(atk_index, index, HG_LIFETIME);
	var frames_before = 0;
	var has_found = false;
	for (n = 0; n < array_length_1d(phone.data[move_index].timeline) && !has_found; n++){
		if (win == phone.data[move_index].timeline[n]){
			frames_before += w_f;
			has_found = true;
		}
		else{
			frames_before += get_window_value(atk_index, phone.data[move_index].timeline[n], AG_WINDOW_LENGTH);
		}
	}
	if has_found{
		stored_active = decimalToString(frames_before + 1);
		if (lif > 1){
			stored_active += "-";
			if (get_hitbox_value(atk_index, index, HG_HITBOX_TYPE) == 1){
				stored_active += decimalToString(frames_before + lif);
			}
		}
	}
}
stored_active = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_ACTIVE, stored_active);

var stored_damage = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_DAMAGE, pullHitboxValue(atk_index, index, HG_DAMAGE, def));

var stored_base_kb = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_BKB, pullHitboxValue(atk_index, index, HG_BASE_KNOCKBACK, "0"));
if get_hitbox_value(atk_index, index, HG_FINAL_BASE_KNOCKBACK) stored_base_kb += "-" + decimalToString(get_hitbox_value(atk_index, index, HG_FINAL_BASE_KNOCKBACK));

var stored_kb_scale = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_KBG, pullHitboxValue(atk_index, index, HG_KNOCKBACK_SCALING, "0"));

var stored_angle = def;
if get_hitbox_value(atk_index, index, HG_BASE_KNOCKBACK) stored_angle = decimalToString(get_hitbox_value(atk_index, index, HG_ANGLE));
else if get_hitbox_value(atk_index, parent, HG_BASE_KNOCKBACK) stored_angle = decimalToString(get_hitbox_value(atk_index, parent, HG_ANGLE));
var flipper = max(get_hitbox_value(atk_index, index, HG_ANGLE_FLIPPER), get_hitbox_value(atk_index, parent, HG_ANGLE_FLIPPER));
// if flipper stored_angle += "*";

var stored_priority = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_PRIORITY, pullHitboxValue(atk_index, index, HG_PRIORITY, (move.num_hitboxes > 1) ? "0" : def));

var stored_group = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_GROUP, pullHitboxValue(atk_index, index, HG_HITBOX_GROUP, (move.num_hitboxes > 1) ? "0" : def));

var stored_base_hitpause = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_BHP, pullHitboxValue(atk_index, index, HG_BASE_HITPAUSE, "0"));

var stored_hitpause_scale = pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_HPG, pullHitboxValue(atk_index, index, HG_HITPAUSE_SCALING, "0"));

var flipper_desc = [
	"sends at the exact same angle every time",
	"sends away from the center of the user",
	"sends toward the center of the user",
	"horizontal KB sends away from the hitbox center",
	"horizontal KB sends toward the hitbox center",
	"horizontal KB is reversed",
	"horizontal KB sends away from the user",
	"horizontal KB sends toward the user",
	"sends away from the hitbox center",
	"sends toward the hitbox center",
	"sends along the user's movement direction"
];

var effect_desc = ["nothing", "burn", "burn consume", "burn stun", "wrap", "freeze", "mark", "???", "auto wrap", "polite", "poison", "plasma stun", "crouchable"];

var ground_desc = ["woag", "Hits only grounded enemies", "Hits only airborne enemies"];

var tech_desc = ["woag", "Untechable", "Hit enemy goes through platforms", "Untechable, doesn't bounce"];

var flinch_desc = ["woag", "Forces grounded foes to flinch", "Cannot force flinch", "Forces crouching opponents to flinch"];

var rock_desc = ["woag", "Throws rocks", "Ignores rocks"];

var stored_misc = def;
if (stored_group != def)
	stored_misc = checkAndAdd(stored_misc, "Group " + stored_group);
if parent{
	stored_misc = checkAndAdd(stored_misc, "Parent: Hitbox #" + string(parent));
}
else{
	if (flipper)
		stored_misc = checkAndAdd(stored_misc, "Flipper " + decimalToString(flipper) + " (" + flipper_desc[flipper] + ")");
	if (pullHitboxValue(atk_index, index, HG_EFFECT, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Effect " + decimalToString(get_hitbox_value(atk_index, index, HG_EFFECT)) + ((real(pullHitboxValue(atk_index, index, HG_EFFECT, def)) < array_length(effect_desc)) ? " (" + effect_desc[real(pullHitboxValue(atk_index, index, HG_EFFECT, def))] + ")" : " (Custom)"));
	if (pullHitboxValue(atk_index, index, HG_EXTRA_HITPAUSE, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_EXTRA_HITPAUSE)) + " Extra Hitpause");
	if (pullHitboxValue(atk_index, index, HG_GROUNDEDNESS, def) != def)
		stored_misc = checkAndAdd(stored_misc, ground_desc[real(pullHitboxValue(atk_index, index, HG_GROUNDEDNESS, def))]);
	if (pullHitboxValue(atk_index, index, HG_IGNORES_PROJECTILES, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Cannot break projectiles");
	if (pullHitboxValue(atk_index, index, HG_HIT_LOCKOUT, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_HIT_LOCKOUT)) + "f Hit Lockout");
	if (pullHitboxValue(atk_index, index, HG_EXTENDED_PARRY_STUN, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Has extended parry stun");
	if (pullHitboxValue(atk_index, index, HG_HITSTUN_MULTIPLIER, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_HITSTUN_MULTIPLIER)) + "x Hitstun");
	if (pullHitboxValue(atk_index, index, HG_DRIFT_MULTIPLIER, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_DRIFT_MULTIPLIER)) + "x Drift");
	if (pullHitboxValue(atk_index, index, HG_SDI_MULTIPLIER, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_SDI_MULTIPLIER) + 1) + "x SDI");
	if (pullHitboxValue(atk_index, index, HG_TECHABLE, def) != def)
		stored_misc = checkAndAdd(stored_misc, tech_desc[real(pullHitboxValue(atk_index, index, HG_TECHABLE, def))]);
	if (pullHitboxValue(atk_index, index, HG_FORCE_FLINCH, def) != def)
		stored_misc = checkAndAdd(stored_misc, flinch_desc[real(pullHitboxValue(atk_index, index, HG_FORCE_FLINCH, def))]);
	if (pullHitboxValue(atk_index, index, HG_THROWS_ROCK, def) != def)
		stored_misc = checkAndAdd(stored_misc, rock_desc[real(pullHitboxValue(atk_index, index, HG_THROWS_ROCK, def))]);
	if (pullHitboxValue(atk_index, index, HG_PROJECTILE_PARRY_STUN, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Has parry stun");
	if (pullHitboxValue(atk_index, index, HG_PROJECTILE_DOES_NOT_REFLECT, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Does not reflect on parry");
	if (pullHitboxValue(atk_index, index, HG_PROJECTILE_IS_TRANSCENDENT, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Transcendent");
	if (pullHitboxValue(atk_index, index, HG_PROJECTILE_PLASMA_SAFE, def) != def)
		stored_misc = checkAndAdd(stored_misc, "Immune to Clairen's plasma field");
	if (pullHitboxValue(atk_index, index, HG_MUNO_OBJECT_LAUNCH_ANGLE, def) != def)
		stored_misc = checkAndAdd(stored_misc, decimalToString(get_hitbox_value(atk_index, index, HG_MUNO_OBJECT_LAUNCH_ANGLE)) + " Workshop Object launch angle");
}

if (get_hitbox_value(atk_index, index, HG_MUNO_HITBOX_MISC_ADD) != 0)
	stored_misc = checkAndAdd(stored_misc, get_hitbox_value(atk_index, index, HG_MUNO_HITBOX_MISC_ADD));
if (get_hitbox_value(atk_index, index, HG_MUNO_HITBOX_MISC) != 0)
	stored_misc = get_hitbox_value(atk_index, index, HG_MUNO_HITBOX_MISC);

var stored_name = string(index) + ": " + pullHitboxValue(atk_index, index, HG_MUNO_HITBOX_NAME, ((get_hitbox_value(atk_index, index, HG_HITBOX_TYPE) == 1) ? "Melee" : "Proj."));



array_push(phone.data[current_move].hitboxes, {
	name: stored_name,
	active: stored_active,
	damage: stored_damage,
	base_kb: stored_base_kb,
	kb_scale: stored_kb_scale,
	angle: stored_angle,
	priority: stored_priority,
	// group: stored_group,
	base_hitpause: stored_base_hitpause,
	hitpause_scale: stored_hitpause_scale,
	misc: stored_misc,
	parent_hbox: parent
});



#define pullHitboxValue(move, hbox, index, def)

if get_hitbox_value(move, hbox, HG_PARENT_HITBOX) != 0 switch(index){
	case HG_HITBOX_TYPE:
	case HG_WINDOW:
	case HG_WINDOW_CREATION_FRAME:
	case HG_LIFETIME:
	case HG_HITBOX_X:
	case HG_HITBOX_Y:
	case HG_HITBOX_GROUP:
		break;
	default:
		if index < 70 hbox = get_hitbox_value(move, hbox, HG_PARENT_HITBOX);
}

if get_hitbox_value(move, hbox, index) != 0 || is_string(get_hitbox_value(move, hbox, index)) return decimalToString(get_hitbox_value(move, hbox, index));
else return string(def);



#define checkAndAdd(orig, add)

if orig == "-" return decimalToString(add);
if string_height_ext(decimalToString(orig) + "   |   " + decimalToString(add), 10, 560) == string_height_ext(decimalToString(orig), 10, 560){
	return decimalToString(orig) + "   |   " + decimalToString(add);
}
return decimalToString(orig) + "
" + decimalToString(add);



#define decimalToString(input)

if !is_number(input) return(string(input));

input = input % 1000;

input = string(input);
var last_char = string_char_at(input, string_length(input));

if (string_length(input) > 2){
	var third_last_char = string_char_at(input, string_length(input) - 2);
	if (last_char == "0" && third_last_char == ".") input = string_delete(input, string_length(input), 1);
}

if (string_char_at(input, 1) == "0") input = string_delete(input, 1, 1);

return input;



#define spawn_base_dust // originally by supersonic
/// spawn_base_dust(x, y, name, dir = 0)
///spawn_base_dust(x, y, name, ?dir)
//This function spawns base cast dusts. Names can be found below.
var dlen; //dust_length value
var dfx; //dust_fx value
var dfg; //fg_sprite value
var dfa = 0; //draw_angle value
var dust_color = 0;
var x = argument[0], y = argument[1], name = argument[2];
var dir = argument_count > 3 ? argument[3] : 0;

switch (name) {
    default: 
    case "dash_start":dlen = 21; dfx = 3; dfg = 2626; break;
    case "dash": dlen = 16; dfx = 4; dfg = 2656; break;
    case "jump": dlen = 12; dfx = 11; dfg = 2646; break;
    case "doublejump": 
    case "djump": dlen = 21; dfx = 2; dfg = 2624; break;
    case "walk": dlen = 12; dfx = 5; dfg = 2628; break;
    case "land": dlen = 24; dfx = 0; dfg = 2620; break;
    case "walljump": dlen = 24; dfx = 0; dfg = 2629; dfa = dir != 0 ? -90*dir : -90*spr_dir; break;
    case "n_wavedash": dlen = 24; dfx = 0; dfg = 2620; dust_color = 1; break;
    case "wavedash": dlen = 16; dfx = 4; dfg = 2656; dust_color = 1; break;
}
var newdust = spawn_dust_fx(round(x),round(y),asset_get("empty_sprite"),dlen);
if newdust == noone return noone;
newdust.dust_fx = dfx; //set the fx id
if dfg != -1 newdust.fg_sprite = dfg; //set the foreground sprite
newdust.dust_color = dust_color; //set the dust color
if dir != 0 newdust.spr_dir = dir; //set the spr_dir
newdust.draw_angle = dfa;
return newdust;