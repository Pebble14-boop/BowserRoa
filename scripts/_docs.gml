/*

This file is the nitty-gritty docs of the MunoPhone Touch - it's a list of all
the different variables, side features, etc. that you as a character dev can
take advantage of.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #0  ║															║
╠══════════════╝															║
║																			║
║ Utility Variables															║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

The MunoPhone template creates certain variables inside the oPlayer object. Some
of these are purely for behind-the-scenes work, while others exist to add
functionality for use by the character dev. This section documents the name and
behavior of each; some of them are quite useful.

phone_attacking
	Every frame, this gets set to the value of
		(state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
	, so you can reference it to check if your character is performing an
	attack - useful for running attack-only code outside attack_update. e.g.
		if (phone_attacking && attack == AT_USPECIAL)

phone_window_end
	Every frame if phone_attacking is true, this gets set to the value of
		floor(get_window_value(attack, window, AG_WINDOW_LENGTH) *
		((get_window_value(attack, window, AG_WINDOW_HAS_WHIFFLAG) && !has_hit)
		? 1.5 : 1))
	...which is a fancy way of saying "the last frame of the current attack
	window." You can use this to run code at the end of a window, e.g.
	
	if (window_timer == phone_window_end){
		print("this is being run at the END of this window");
	}

phone_playtest
	This is true if you are playtesting the character on the CSS, and false
	otherwise.

phone_practice
	This is true if you are playing in Practice Mode, and false otherwise. It
	also gets set to false when the MunoPhone is powered off, and is always
	false for CPU players.

phone_game_over
	This is true if all of the players except for one team are in the PS_DEAD
	state, which means that the game has ended and is in slow-mo or	whatever.
	(Might act weirdly on custom stages with weird rules, who knows)

phone_stopped_sounds
	This is an array that stores the instance IDs of played sounds, empty by
	default. Whenever the player goes from the attacking states into landing
	lag, pratland, hitstun, or a death state, sound_stop() is run on each sound
	in the array, and then the array is cleared.
	
	In other words - you can add sounds to the array during an attack, and when
	the attack ends prematurely by getting hit / landinglag / dying, the sound
	will be cut short. To do this, simply do:
	
	array_push(phone_stopped_sounds, sound_play(sound_get("my_cool_sound")));

phone_landing
	This is true if the character is on the ground, walljumping, in hitstun,
	or respawning - and false otherwise. Handy for resetting once-per-jump
	resources.

phone_hud_hidden
	This is true if the player has disabled overhead names and damage in the
	RoA game settings, and false otherwise. Can be used to adjust the height of
	overhead HUD elements and best utilize space.

phone_offscreen
	This is an array that stores the instance IDs of objects (e.g. articles,
	projectiles, or whatever you want) which should have an offscreen indicator
	drawn for them. To use this, run this code from within that object, e.g.
	in hitbox_init or articleX_init:
	
	array_push(player_id.phone_offscreen, self);
	phone_offscr_sprite = sprite_get("..."); // icon to display
	phone_offscr_index = 0; // image_index of the icon
	phone_offscr_x_offset = 0; // x offset to draw the arrow at; uses spr_dir
	phone_offscr_y_offset = 0; // y offset to draw the arrow at
	phone_offscr_leeway = 16; // approximate width/height of obj
	
	An example icon can be found in the sprites folder:
	
	_pho_offscreen_example.png
	
	(it doesn't need a load.gml offset)

phone_dust_query
	This is an array that, itself, stores arrays. Its purpose is to provide easy
	access to the spawn_base_dust() function written by Supersonic, which lets
	you spawn RoA dust effects (e.g. the ones made when dashing) whenever you
	want!
	
	To spawn dust, just run this code from one of your character's scripts:
	
	array_push(phone_dust_query, [x_pos, y_pos, dust_type, direction]);
	
	e.g.
	
	array_push(phone_dust_query, [x, y, "dash_start", spr_dir]);
	
	Here's a list of all of the valid dust types:
	- "dash_start"
	- "dash" 
	- "jump"
	- "doublejump"
	- "djump"
	- "walk"
	- "land"
	- "walljump"
	- "n_wavedash"
	- "wavedash"
	
phone_lightweight
	Disables many features which are normally run during the match, which could
	help optimize performance a little bit if you don't need any of these
	features.
	
	Recommended if you're porting the phone to an existing character... I mean,
	you might as well.
	
	Disables:
	- setting muno_char_id for all characters in the match
	- phone_arrow_cooldown
	- phone_invis_cooldown
	- phone_attacking
	- phone_window_end
	- phone_stopped_sounds
	- AG_MUNO_ATTACK_COOLDOWN
	- AG_MUNO_WINDOW_INVUL
	- making the player visible while respawning in Practice Mode
	- phone_landing
	- automatically enabling Fast Graphics
	- phone_dust_query
	- phone_game_over

phone_fast
	This is true if the Fast Graphics setting is enabled (either manually or
	automatically due to low FPS), and false otherwise.

phone_ditto
	This is true if you are fighting a copy of the same character, and false
	otherwise.

phone_online
	This is true if you are playing an online match, and false otherwise.

phone_darkened_player_color
	This stores a GML color which is that of the current player color, but
	darkened.

phone_invul_override
	Set this to true during attack_update to disable the phone's checks for
	AG_MUNO_WINDOW_INVUL during that frame, allowing you to manually set soft
	armor, super armor, and invul even if you have set AG_MUNO_WINDOW_INVUL for
	the attack.

phone_arrow_cooldown
	This is the cooldown value for any attacks which use the
	AG_MUNO_ATTACK_CD_SPECIAL value of 1.

phone_invis_cooldown
	This is the cooldown value for any attacks which use the
	AG_MUNO_ATTACK_CD_SPECIAL value of 2.

muno_char_id
	In a match with ANY MunoPhone characters present, ALL characters will have
	this variable in them. For Muno's characters, this number is the same as the
	"fighter number" seen on the Steam thumbnail - Trummel=1, Otto=2, etc. For
	all other characters, its value is noone (the GML constant whose value is
	-4).

muno_char_name
	In a match with ANY MunoPhone characters present, ALL characters will have
	this variable in them. By default, it is the character's actual name, taken
	from config.ini. Phone characters can override this, as seen in event15.

muno_char_icon
	In a match with ANY MunoPhone characters present, ALL characters will have
	this variable in them. By default, it is the character's actual icon, taken
	from the character select screen. Phone characters can override this.

phone_frozen_damage
	This is the damage value stored by the "Freeze Own Damage" Utility.

phone
	This is the variable for the phone object.

phone_cheats
	This is the array which stores the current values of Cheats.

phone_cheats_updated
	This is the array which stores whether or not a Cheat has been updated this
	frame.

phone_lagging
	This is an internal variable used to determine whether or not Fast Graphics
	should be automatically enabled.

phone_using_landing_cd
	This is an internal variable used to determine whether or not to run the
	checks for move cooldowns that reset upon landing/hitstun/walljump.

phone_using_invul
	This is an internal variable used to determine whether or not to run the
	checks for invulnerability / armor.

phone_char_ided
	This is an internal variable used to track whether or not the phone has
	given a muno_char_id to the other characters in the match.

phone_blastzone_l
phone_blastzone_r
phone_blastzone_t
phone_blastzone_b
	These vars store the x/y coords of the left/right/top/bottom blastzones.
	Made obsolete by get_stage_data() macros, but included for backwards
	compatibility.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #1  ║															║
╠══════════════╝															║
║																			║
║ AG_ and HG_ Indexes														║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

Below is a listing of EVERY custom index present in the MunoPhone and what it
does. Not only are there ones for correcting the frame data guide, but there are
ALSO a lot of miscellaneous utility ones. Pretty cool, right?



General Attack Indexes - frame data correction

AG_MUNO_ATTACK_EXCLUDE
	Set to 1 to exclude this move from the list of moves
AG_MUNO_ATTACK_NAME
	Enter a string to override the move's name in the attack list
AG_MUNO_ATTACK_FAF
	Enter a string to override FAF
AG_MUNO_ATTACK_ENDLAG
	Enter a string to override endlag
AG_MUNO_ATTACK_LANDING_LAG
	Enter a string to override landing lag
AG_MUNO_ATTACK_MISC
	Enter a string to OVERRIDE the move's "Notes" section, which automatically
	includes the Cooldown System and Misc. Window Traits found below
AG_MUNO_ATTACK_MISC_ADD
	Enter a string to ADD TO the move's "Notes" section (preceded by the auto-
	generated one, then a line break)

P.S. Adding Notes to a move is good for if a move requires a long explanation of
the data, or if a move overall has certain behavior that should be listed, such
as a manually coded cancel window.

General Window Indexes - frame data correction

AG_MUNO_WINDOW_EXCLUDE
	0: include window in timeline (default)
	1: exclude window from timeline
	2: exclude window from timeline, only for the on-hit time
	3: exclude window from timeline, only for the on-whiff time
AG_MUNO_WINDOW_ROLE
	0: none (acts identically to AG_MUNO_WINDOW_EXCLUDE = 1)
	1: startup
	2: active (or IN BETWEEN active frames, eg between multihits)
	3: endlag
AG_MUNO_ATTACK_USES_ROLES
	Must be set to 1 for AG_MUNO_WINDOW_ROLE to take effect

P.S. If your move's windows are structured non-linearly, you can use
AG_MUNO_WINDOW_ROLE to force the frame data system to parse the window order
correctly (to a certain extent).

General Hitbox Indexes - frame data correction

HG_MUNO_HITBOX_EXCLUDE
	Set to 1 to exclude this hitbox from the frame data guide
HG_MUNO_HITBOX_NAME
	Enter a string to override the hitbox's name, very useful if the move has
	multiple hitboxes

HG_MUNO_HITBOX_ACTIVE
	Enter a string to override active frames
HG_MUNO_HITBOX_DAMAGE
	Enter a string to override damage
HG_MUNO_HITBOX_BKB
	Enter a string to override base knockback
HG_MUNO_HITBOX_KBG
	Enter a string to override knockback growth
HG_MUNO_HITBOX_ANGLE
	Enter a string to override angle
HG_MUNO_HITBOX_PRIORITY
	Enter a string to override priority
HG_MUNO_HITBOX_GROUP
	Enter a string to override group
HG_MUNO_HITBOX_BHP
	Enter a string to override base hitpause
HG_MUNO_HITBOX_HPG
	Enter a string to override hitpause scaling
HG_MUNO_HITBOX_MISC
	Enter a string to override the auto-generated misc notes (which include misc
	properties like angle flipper or elemental effect)
HG_MUNO_HITBOX_MISC_ADD
	Enter a string to ADD TO the auto-generated misc notes, not override (line
	break will be auto-inserted)

Cooldown System - this will automatically handle a move's cooldown for you!

AG_MUNO_ATTACK_COOLDOWN
	Set this to a number, and the move's move_cooldown[] will be set to it
	automatically. Set it to any negative number and it will refresh when
	landing, getting hit, or walljumping. (gets converted to positive when
	applied)
AG_MUNO_ATTACK_CD_SPECIAL
	Set various cooldown effects on a per-ATTACK basis.
	1: the cooldown will use the phone_arrow_cooldown variable instead of
	move_cooldown[attack], causing it to display on the overhead player
	indicator; multiple attacks can share this cooldown.
	2: the cooldown will use the phone_invis_cooldown variable instead of
	move_cooldown[attack], which doesn't display anywhere (unless you code your
	own HUD element) but does allow you to share the cooldown between moves.
AG_MUNO_WINDOW_CD_SPECIAL
	Set various cooldown effects on a per-WINDOW basis.
	1: a window will be exempted from causing cooldown. It is HIGHLY RECOMMENDED
	to do this for any startup windows, so that the cooldown doesn't apply if
	you're hit out of the move before being able to use it.
	2: a window will reset the cooldown to 0.
	3: a window will set cooldown only if the has_hit variable is false, and set
	it to 0 if has_hit is true.
	4: a window will set cooldown only if the has_hit_player variable is false,
	and	set it to 0 if has_hit_player is true.

Misc. Window Traits

AG_MUNO_WINDOW_INVUL
	Apply invulnerability during the window.
	-1: invulnerable
	-2: super armor
	above 0: that amount of soft armor

Misc. Hitbox Traits

HG_MUNO_OBJECT_LAUNCH_ANGLE
	Override the on-hit launch direction of compatible Workshop objects,
	typically ones without gravity. For example, Otto uses this for the ball
	rehit angles. Feel free to code this into your attacks, AND to support it
	for your own hittable articles.



...That was a lot.

If you're a big brain coder and have made your OWN custom AG_s or HG_s, there's
a chance that their indexes overlap. To resolve this, see user_event15.gml.

*/