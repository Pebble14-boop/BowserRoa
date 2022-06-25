/*
 
Muno's easy color system TM.

TLDR instructions at the bottom of this comment block, but you should read the
whole thing so you know what this does.


 
This allows you to easily use RGB hex codes to define your colors. You can get
these quickly by changing the eyedropper in Aseprite (etc) to use RGB color,
then the hex will show in the color area at the corner of the screen. By doing
this, you can quickly swap between Aseprite eyedropper and GMEdit to code in
palettes you've drawn, which greatly reduces tedium.
 
(By default, GML uses Blue, Green, Red instead of Red, Green, Blue for hex
colors. This template allows you to use RGB instead of BGR. You're welcome!)
 
The system is optimized for the color setup style seen in Liz and adopted by me
for chars like Coda, where each shade is its OWN individual color (as opposed to
normal Rivals, where shades of the same color are grouped together). This allows
for better artistic control over the shades for alt costumes, notably fixing
issues with hue shifting.
 
The limitation is that only 8 separate colors can be registered in Rivals's
system. There's limited real estate, and having each shade separately uses more
of it. In light of this, the template ALSO supports ranges - just define them
using set_color_profile_slot_range(), like normal (example below). By default,
all 3 numbers of the range (H, S, V) are set to 1 by rangeSet().

Using this system shouldn't affect any other color-related code, such as code
to change colors mid-match. It's just a different front-end for the normal
color system.
 
Obviously, this is example is for Sandbert's colors. For the alt costumes, I
edited the shading color (except for the grey alt), to demonstrate the added
control that the separate-shade method gives you. I think the shaded color
only actually appears in the CSS artwork, results screen, and so on. See if you
can notice the hue-shifting and saturation-shifting added.



If you prefer the traditional RoA system for whatever reason, you're free to
replace this whole file without breaking any kind of MunoPhone functionality.



TLDR HOW TO
- Replace the hex values and labels in the rangeSet() section with your own
  character's colors, in RGB hex format.
- If needed, change the ranges in the set_color_profile_slot_range() section,
  exactly like normal colors.gml.
- For each alt, include the colorSet()s and the a++. (just copy and paste)
 
*/
 
// DEFAULT COLOR

// unnamed color row
set_color_profile_slot( 0, 0, 200, 48, 40 );
set_color_profile_slot_range( 0, 3, 20, 19 );

// unnamed color row
set_color_profile_slot( 0, 1, 216, 148, 88 );
set_color_profile_slot_range( 1, 6, 30, 20 );

// unnamed color row
set_color_profile_slot( 0, 2, 7, 157, 17 );
set_color_profile_slot_range( 2, 3, 6, 27 );

// unnamed color row
set_color_profile_slot( 0, 3, 216, 124, 32 );
set_color_profile_slot_range( 3, 14, 16, 17 );

// unnamed color row
set_color_profile_slot( 0, 4, 176, 36, 16 );
set_color_profile_slot_range( 4, 2, 9, 23 );

// unnamed color row
set_color_profile_slot( 0, 5, 232, 172, 144 );
set_color_profile_slot_range( 5, 5, 15, 20 );

// unnamed color row
set_color_profile_slot( 0, 6, 248, 244, 240 );
set_color_profile_slot_range( 6, 31, 4, 51 );


// ALTERNATE COLORS
set_num_palettes( 10 );

// Color 2
set_color_profile_slot( 1, 0, 153, 27, 26 ); //unnamed color row
set_color_profile_slot( 1, 1, 196, 141, 94 ); //unnamed color row
set_color_profile_slot( 1, 2, 83, 75, 138 ); //unnamed color row
set_color_profile_slot( 1, 3, 65, 63, 94 ); //unnamed color row
set_color_profile_slot( 1, 4, 117, 41, 20 ); //unnamed color row
set_color_profile_slot( 1, 5, 212, 186, 167 ); //unnamed color row
set_color_profile_slot( 1, 6, 201, 173, 168 ); //unnamed color row

// Color 3
set_color_profile_slot( 2, 0, 105, 93, 71 ); //unnamed color row
set_color_profile_slot( 2, 1, 212, 154, 76 ); //unnamed color row
set_color_profile_slot( 2, 2, 247, 193, 44 ); //unnamed color row
set_color_profile_slot( 2, 3, 105, 93, 71 ); //unnamed color row
set_color_profile_slot( 2, 4, 201, 98, 44 ); //unnamed color row
set_color_profile_slot( 2, 5, 227, 222, 183 ); //unnamed color row
set_color_profile_slot( 2, 6, 255, 239, 201 ); //unnamed color row

// Color 4
set_color_profile_slot( 3, 0, 120, 32, 16 ); //unnamed color row
set_color_profile_slot( 3, 1, 77, 72, 62 ); //unnamed color row
set_color_profile_slot( 3, 2, 99, 76, 52 ); //unnamed color row
set_color_profile_slot( 3, 3, 102, 96, 87 ); //unnamed color row
set_color_profile_slot( 3, 4, 152, 12, 8 ); //unnamed color row
set_color_profile_slot( 3, 5, 248, 244, 240 ); //unnamed color row
set_color_profile_slot( 3, 6, 120, 32, 16 ); //unnamed color row

// Dark Bowser
set_color_profile_slot( 4, 0, 26, 28, 26 ); //unnamed color row
set_color_profile_slot( 4, 1, 173, 159, 131 ); //unnamed color row
set_color_profile_slot( 4, 2, 63, 80, 143 ); //unnamed color row
set_color_profile_slot( 4, 3, 63, 76, 130 ); //unnamed color row
set_color_profile_slot( 4, 4, 64, 61, 84 ); //unnamed color row
set_color_profile_slot( 4, 5, 173, 159, 131 ); //unnamed color row
set_color_profile_slot( 4, 6, 255, 255, 255 ); //unnamed color row

// Midbus
set_color_profile_slot( 5, 0, 217, 50, 120 ); //unnamed color row
set_color_profile_slot( 5, 1, 255, 197, 120 ); //unnamed color row
set_color_profile_slot( 5, 2, 255, 200, 0 ); //unnamed color row
set_color_profile_slot( 5, 3, 217, 50, 120 ); //unnamed color row
set_color_profile_slot( 5, 4, 140, 38, 38 ); //unnamed color row
set_color_profile_slot( 5, 5, 48, 42, 37 ); //unnamed color row
set_color_profile_slot( 5, 6, 128, 128, 107 ); //unnamed color row

// Sol Badguy
set_color_profile_slot( 6, 0, 92, 41, 17 ); //unnamed color row
set_color_profile_slot( 6, 1, 204, 151, 106 ); //unnamed color row
set_color_profile_slot( 6, 2, 194, 32, 29 ); //unnamed color row
set_color_profile_slot( 6, 3, 140, 6, 6 ); //unnamed color row
set_color_profile_slot( 6, 4, 97, 61, 33 ); //unnamed color row
set_color_profile_slot( 6, 5, 255, 187, 158 ); //unnamed color row
set_color_profile_slot( 6, 6, 125, 121, 112 ); //unnamed color row

// Justice
set_color_profile_slot( 7, 0, 166, 30, 30 ); //unnamed color row
set_color_profile_slot( 7, 1, 214, 200, 182 ); //unnamed color row
set_color_profile_slot( 7, 2, 25, 114, 191 ); //unnamed color row
set_color_profile_slot( 7, 3, 214, 200, 182 ); //unnamed color row
set_color_profile_slot( 7, 4, 125, 112, 112 ); //unnamed color row
set_color_profile_slot( 7, 5, 242, 238, 215 ); //unnamed color row
set_color_profile_slot( 7, 6, 125, 117, 107 ); //unnamed color row

// Susanoo
set_color_profile_slot( 8, 0, 97, 98, 161 ); //unnamed color row
set_color_profile_slot( 8, 1, 83, 84, 122 ); //unnamed color row
set_color_profile_slot( 8, 2, 74, 74, 110 ); //unnamed color row
set_color_profile_slot( 8, 3, 74, 74, 110 ); //unnamed color row
set_color_profile_slot( 8, 4, 113, 232, 137 ); //unnamed color row
set_color_profile_slot( 8, 5, 83, 110, 122 ); //unnamed color row
set_color_profile_slot( 8, 6, 113, 232, 137 ); //unnamed color row

// unnamed alt palette
set_color_profile_slot( 9, 0, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 1, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 2, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 3, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 4, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 5, 0, 255, 0 ); //unnamed color row
set_color_profile_slot( 9, 6, 0, 255, 0 ); //unnamed color row


/* This is a comment used by that one RoA colors.gml generator tool to store palette data. You can safely keep it in your colors.gml if you plan to re-use the tool later, or safely remove it if you don't.
=== BEGIN JSON PALETTE ===
{"formatversion":1,"data":[{"name":"unnamed color row","colors":[{"r":200,"g":48,"b":40,"main":true},{"r":153,"g":4,"b":2}]},{"name":"unnamed color row","colors":[{"r":240,"g":208,"b":168},{"r":216,"g":148,"b":88,"main":true},{"r":168,"g":100,"b":48}]},{"name":"unnamed color row","colors":[{"r":7,"g":157,"b":17,"main":true},{"r":8,"g":92,"b":16}]},{"name":"unnamed color row","colors":[{"r":240,"g":188,"b":72},{"r":216,"g":124,"b":32,"main":true},{"r":177,"g":62,"b":16}]},{"name":"unnamed color row","colors":[{"r":184,"g":52,"b":32},{"r":176,"g":36,"b":16,"main":true},{"r":120,"g":32,"b":16}]},{"name":"unnamed color row","colors":[{"r":232,"g":172,"b":144,"main":true},{"r":184,"g":112,"b":88}]},{"name":"unnamed color row","colors":[{"r":248,"g":244,"b":240,"main":true},{"r":184,"g":180,"b":176},{"r":120,"g":120,"b":120}]}]}
=== END JSON PALETTE ===
*/
 
#define rangeSet(sha, col) // Auto-sets ranges to 1. Translates GML's asinine BGR hex colors to RGB.
 
set_color_profile_slot(0, sha, color_get_blue(col), color_get_green(col), color_get_red(col));
set_color_profile_slot_range(sha, 1, 1, 1);
 
 
 
#define colorSet(alt, sha, col) // Streamlines color setup. Translates BRG --> RGB.
 
set_color_profile_slot(alt, sha, color_get_blue(col), color_get_green(col), color_get_red(col));