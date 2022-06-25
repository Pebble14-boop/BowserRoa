/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #0  ║															║
╠══════════════╝															║
║																			║
║ MunoPhone Touch - Introduction											║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

MunoPhone Touch is a utility pack for RoA characters, featuring:
- a phone interface for accessing bonus features in Practice Mode
- a number of backend coding-assist features
- a more balanced, cleanly-coded version of Sandbert to use as a character base
- and more!

In order to use the MunoPhone Touch, you should be at least somewhat used to
coding in RoA. All of the code is cookie-cutter and has simple templates, but it
certainly helps to know what exactly the words you're typing mean.

If you have any questions, you can find my Discord server, Twitter, etc. at my
website, https://bymuno.com. Get in touch! (Steam comments are unreliable, as I
don't check them frequently.)

LASTLY - To get notified of MunoPhone firmware updates, join the my Discord
server (found at my website) and get the MunoPhone Dev role. You'll be pinged
whenever improvements to the phone are uploaded, so that you can add them to
your character.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #1  ║															║
╠══════════════╝															║
║																			║
║ Making a NEW Character with MunoPhone Touch								║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

* If you've ALREADY made a character, see the next section for instructions on
how to install the MunoPhone!

This is actually really simple, and it's the same steps used to make a new
character from the REAL Sandbert. Even if you know how to do that, though, keep
reading, since there are other important steps.

1. Navigate to

	Program Files (x86)/Steam/steamapps/workshop/content/383980

(...you must have already done that if you're reading this, right?)

and find Sandbert with a Phone's folder. The folder's name is the numbers at the
end of the mod's Steam URL.

2. Copy it to

	Appdata/Local/RivalsofAether/workshop/

and feel free to change the name of the folder you just copied.

3. Play your character in Practice Mode to ensure that it works.

4. That's pretty much it! All of the user-edited content for the MunoPhone is
located in user_event15.gml and attacks/_phone.gml. The user_event14.gml file is
the behind-the-scenes MunoPhone code, which you should leave alone unless you
know what you're doing. All the rest is just regular character code.

If you're new to making characters, check out these handy guides!
- https://ko-fi.com/Blog/Post/Rivals-of-Aether-Workshop-A-Complete-Starter-Guid-I2I42WI2N
- https://pastebin.com/HdBYheUr

One final note: the commented numbers in files like jab.gml are just the
pre-patch values for Sandbert with a Phone's moves, e.g. documenting what a
value used to be before it got nerfed.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #2  ║															║
╠══════════════╝															║
║																			║
║ Adding MunoPhone Touch to an EXISTING Character							║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

* This section of the guide is intended for people who have ALREADY created a
character, and want to add the MunoPhone to that character. If you're starting
from scratch, skip this part!

	NOTE:
	
	It's possible that your character has the OLD version of the MunoPhone
	installed (the green flip-phone). If that's the case, please refer to the
	old _readme.gml and follow its existing-character installation guide in
	reverse - remove all of the files and code it tells you to add.
	
	You should NOT DELETE your user_event15.gml, since that has all of your
	custom Tips and such. However, you'll need to rename it or move it
	somewhere else, since ultimately it'll need to be replaced with the
	MunoPhone Touch's user_event15.gml (the format of the file has changed
	compared to the old MunoPhone). Please see the last section of this readme
	for instructions on transferring your content to the new user_event15, after
	you've finished the rest of the readme!

As for installing the MunoPhone Touch...

1. Copy these files into your character, putting them in the same folders as
they're in for Sandbert:

- scripts/user_event14.gml
- scripts/user_event15.gml
- scripts/articlephone_post_draw.gml
- scripts/_readme.gml
- scripts/_docs.gml
- scripts/attacks/_phone.gml
- everything in the sounds/ and sprites/ folders which starts with "_pho"

2. Add the following lines of code to your character in the specified places, to
allow the MunoPhone to run code at certain moments:

(if a file doesn't exist, you can just create a new empty one)

at the bottom of init.gml:

	muno_event_type = 0;
	user_event(14);

at the top of update.gml:

	muno_event_type = 1;
	user_event(14);

at the bottom of set_attack.gml:

	muno_event_type = 2;
	user_event(14);

at the top of post_draw.gml: (yes, it skips the "3")

	muno_event_type = 4;
	user_event(14);

at the bottom of draw_hud.gml:

	muno_event_type = 5;
	user_event(14);
	
in css_draw.gml (ideal order of code depends on what else you have in there):
	
	muno_event_type = 6;
	user_event(14);

NOTE: "at the bottom" means BEFORE any #define lines, if you have them.

3. This step depends on whether or not your character uses a Solid Article.

If it does NOT use a Solid Article (or you don't know what a Solid Article is),
- copy scripts/articlesolid_init.gml into your character.

If it DOES use a Solid Article,
- open Sandbert's articlesolid_init.gml.
- copy the contents of this file to your clipboard.
- open your character's articlesolid_init.gml.
- paste the contents of Sandbert's file to the VERY TOP of your file.

4. Try your character in Practice Mode to ensure that it works.

5. Make a phone-opening animation for your character, like Sandbert's - by
default, the filename should be "phone_open_stripX.png". Then, change the
animation timings in scripts/attacks/_phone.gml as necessary (unless your
anim matches the frame count of Sandbert's).

That's pretty much it! Visit event15.gml to set up the MunoPhone Touch's core
apps, and keep reading this readme for documentation on other features.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #3  ║															║
╠══════════════╝															║
║																			║
║ Frame Data Guide															║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

The Frame Data Guide automatically pulls the frame data and hitbox values from
all of your character's attacks, including any extra attacks you've added beyond
the normal ones. Optionally, you can also include a Stats page, AND a page for
documenting whatever information you want (e.g. numbers related to a character
gimmick). For more on that, see user_event15.gml.

Now, the automatic data parser is pretty thorough and fairly accurate. But
inevitably, some Workshop characters will have weird setups due to an inventive
move gimmick, or there might be a hole in MY code. If it's the latter, report
the bug and I'll try to fix it for the next release!

Either way, you as a character dev have ways to correct mistakes made by the
parser. Using various AG_ and HG_ indexes added by the phone, you can override
or otherwise guide	the frame data gatherer's results. Just go into the attack's
.gml file, and add lines with the custom AG_s and HG_s. You should feel right at
home if you've worked on a character before.

ex.

set_attack_value(AT_JAB, AG_MUNO_ATTACK_EXCLUDE, 1);
set_window_value(AT_JAB, 1, AG_MUNO_WINDOW_EXCLUDE, 1);
set_hitbox_value(AT_JAB, 1, HG_MUNO_HITBOX_EXCLUDE, 1);

For a full list of the AG_ and HG_ indexes added by the phone, see _docs.gml.

Also, a piece of advice: that the frame data guide is MUCH friendlier if you
follow good practices when programming windows and hitboxes. Here are some
guidelines, which you should follow in general (not only because of the
MunoPhone):

	Startup, active frames, and ending lag should be segregated by distinct
	breaks in windows. If a move is active on frames 4-10, then the active
	window should last 7 frames, after a 3 frame startup window.
	
	Each hitbox should have its OWN window, and gaps between hitboxes should
	correspond to gaps between active windows.
	
	Whifflag should be applied to ALL endlag windows, except for moves which
	lack any melee hitboxes... or Specials, which traditionally do not have
	whifflag in RoA.
	
	Simplify windows as much as possible while following the above guidelines.
	Don't add tons of windows for no reason.

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #4  ║															║
╠══════════════╝															║
║																			║
║ Referencing Phone Utilities												║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

The Cheats app lets you create ingame settings that players can use in Practice
Mode to make things happen in the game. See user_event15.gml for details.

As it turns out, the phone itself has a collection of character-universal
Cheat-like options, called Utilities. As a character dev, you can reference any
of these, and run code based on the value of the setting.

The handiest one is Fast Graphics. The MunoPhone can detect when the game's FPS
dips below 60, and automatically enable Fast Graphics - and then you, the
character dev, can disable certain visual effects when Fast Graphics activates.

To use Fast Graphics, first, enable it in user_event15.gml. Then, in your code,
reference the phone_fast variable. For example:

	// attack_update.gml
	
	if (attack == AT_USPECIAL && window == 2 && window_timer == 1){
		if !phone_fast{
			spawn_hit_fx(x, y, vfx_uspecial_start);
		}
	}

This may help alleviate lag on lower-end machines. P.S. In Practice Mode, use
the Utilites app to toggle Fast Graphics.

Fast Graphics is the most useful Utilities option, so it has its own keyword
(phone_fast). For the rest, you'll need to directly access the phone's data
arrays, like this:

	// update.gml
	
	if phone.utils_cur[phone.UTIL_GREEN]{
		print("The greenscreen is currently enabled.");
	}
	
	if phone.utils_cur_updated[phone.UTIL_GREEN]{
		if phone.utils_cur[phone.UTIL_GREEN]{
			print("The user just turned on the greenscreen.");
		}
		else{
			print("The user just turned off the greenscreen.");
		}
	}

These arrays are very similar to the ones used for Cheats.

As of writing, the list of Utilities is:
- UTIL_FAST			Fast Graphics
- UTIL_FPS_WARN		Low FPS Warning
- UTIL_OPAQUE		Opaque Background
- UTIL_DMG_FREEZE	Freeze Own Damage
- UTIL_STATE_SAVE	Save Position and Damage
- UTIL_STATE_LOAD	Load Position and Damage
- UTIL_GREEN		Greenscreen
- UTIL_CPU			CPU Behavior Changes

*/



/*

╔══════════════╦════════════════════════════════════════════════════════════╗
║  SECTION #5  ║															║
╠══════════════╝															║
║																			║
║ Transferring Content from the Old MunoPhone								║
║																			║
╚═══════════════════════════════════════════════════════════════════════════╝

As mentioned in SECTION #2, this section of the guide is intended for users who
already have the old flip phone installed on a character and want to upgrade to
the MunoPhone touch. Specifically, it walks you through the process of
transferring your custom data (e.g. Tips) from the old event15 to the new one.

First, the MunoPhone Touch does drop support for certain features found in the
old event15.

Removed features:
- Character Compatibility icons
- Character Compatibility templates for non-Muno characters
	- just move these outside of user_event15
- phone.taunt_hint_x and phone.taunt_hint_y
- phone_custom_debug

The rest of this section will give instructions on how to transfer everything
else from the old event15, starting from the top. As you go along, also
remember to fill out the NEW fields that weren't there before.

Compatibility Setup --> CSS Draw

	Copy the values of these vars from the old file to the new file, if needed:
	- num_alts

General Character Info --> General Settings

	Copy the values of these vars from the old file to the new file, if needed:
	- muno_char_name
	- muno_char_icon
	- phone.dont_fast
	- phone.lightweight
	
	Copy the value of the old file's phone.shader to the new file's
	phone.uses_shader, if needed.

Tips --> Tips

	This is one area where the syntax has changed a bit. First, the Tips section
	should no longer be wrapped in a "with phone{}", like it was in the old
	MunoPhone.
	
	Secondly, the syntax has changed a bit. Here is a comparison of the old and
	new functions:
	
		OLD: initTipWords(text)
		NEW: initWords(text)
		
		OLD: initTipWords_ext(text, align, color, indent, gimmick)
		NEW: initWords_ext(text, alignment, color, indent, ignore_height)
		
		OLD: initTipImage(sprite, frame, align, xscale, color, gimmick)
		NEW: initImage(sprite, frame)
		
		OLD: initTipImage_ext(sprite, frame, align, xscale, color, gimmick,
			border_l, border_r, border_u, border_d)
		NEW: initImage_ext(sprite, frame, alignment, xscale, yscale,
			uses_shader, color, alpha, ignore_height, crop_left, crop_right,
			crop_up, crop_down)
	
	Notes:
	- Paragraph/image gimmicks have been removed, but a couple of them have been
		promoted to their own arguments.
	- initImage() takes fewer arguments, defaulting to center-align.
	- border_l and crop_left (etc) are the same thing.
	- initImage() and initImage_ext() can now take sprite_get() directly,
		instead of needing a proxy var like the old phone.
	- Consider using the new initHeader() and initSection() where convenient.
	
	Copy your old Tips into the new event15 while editing the syntax to match
	the above changes. Smart use of find-and-replace is recommended.

Patch Notes --> Patches

	These have seen largely the same changes as Tips, and these two apps now use
	the same generic content functions (instead of having both initPatchWords()
	and initTipWords(), there's now just initWords(); etc).
	
	It is strongly recommended to use initHeader() and initSection() when
	writing Patches.
	
	Also, note that the Patches app is the new home of the old About app's
	content. It's recommended to just start the Abouts from scratch (edit the
	new template and copy over your old text).

Cheat Codes --> Cheats

	The syntax for these has been slightly changed.
	
	Syntax comparison:
	
		OLD: initCheat(display name, backstage name, [options], [option names],
			description)
		
		NEW: CHEAT_[NAME_HERE] = initCheat(name, [options], [option_names],
			description)
	
	The "backstage name" is no longer an argument of the function. Instead, the
	function *returns* the ID of the Cheat, and then you save that into a
	variable directly.
	
	In other words, you take the second argument from the old function, remote
	it, stick it in front without the quotation marks, and add an equals sign.
	
	Aside from this, you can copy the Cheats over verbatim.

Frame Data Guide --> Frame Data

	Copy the values of these vars from the old file to the new file, if needed:
	- phone.move_ordering
	- phone.include_stats
	- phone.stats_notes
	- phone.include_custom
	- phone.custom_name
	
	You can also copy the initCFDHeader() and initCFDBody() calls from the old
	file to the new one. Keep in mind that the layout of the custom data page is
	different compared to the old phone, and is more suited for very short
	headers / descriptions (usually numbers).
	
Compatibility --> Muno Character Compatibility

	The compatibility templates for Trummel codecs, Otto bobbleheads, and Steve
	death messages can be copied over verbatim.
*/



// That's it! Happy modding.





















