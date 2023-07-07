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

// Hair
set_color_profile_slot( 0, 0, 200, 48, 40 );
set_color_profile_slot_range( 0, 3, 20, 19 );

// Mouth/Belly
set_color_profile_slot( 0, 1, 216, 148, 88 );
set_color_profile_slot_range( 1, 6, 30, 20 );

// Skin/Shell
set_color_profile_slot( 0, 2, 7, 157, 17 );
set_color_profile_slot_range( 2, 3, 6, 27 );

// Skin 2
set_color_profile_slot( 0, 3, 216, 124, 32 );
set_color_profile_slot_range( 3, 14, 16, 17 );

// Horn Rim
set_color_profile_slot( 0, 4, 176, 36, 16 );
set_color_profile_slot_range( 4, 2, 9, 23 );

// Horns
set_color_profile_slot( 0, 5, 232, 172, 144 );
set_color_profile_slot_range( 5, 5, 15, 20 );

// Shell
set_color_profile_slot( 0, 6, 248, 244, 240 );
set_color_profile_slot_range( 6, 31, 4, 51 );

// Fireball
set_color_profile_slot( 0, 7, 201, 101, 236 );
set_color_profile_slot_range( 7, 24, 42, 41 );


// ALTERNATE COLORS
set_num_palettes( 31 );

// Color 1
set_color_profile_slot( 1, 0, 120, 32, 16 ); //Hair
set_color_profile_slot( 1, 1, 189, 146, 106 ); //Mouth/Belly
set_color_profile_slot( 1, 2, 128, 84, 37 ); //Skin/Shell
set_color_profile_slot( 1, 3, 122, 74, 30 ); //Skin 2
set_color_profile_slot( 1, 4, 152, 12, 8 ); //Horn Rim
set_color_profile_slot( 1, 5, 248, 244, 240 ); //Horns
set_color_profile_slot( 1, 6, 232, 214, 211 ); //Shell
set_color_profile_slot( 1, 7, 244, 202, 129 ); //Fireball

// Color 2
set_color_profile_slot( 2, 0, 181, 32, 30 ); //Hair
set_color_profile_slot( 2, 1, 214, 161, 116 ); //Mouth/Belly
set_color_profile_slot( 2, 2, 60, 74, 150 ); //Skin/Shell
set_color_profile_slot( 2, 3, 62, 66, 102 ); //Skin 2
set_color_profile_slot( 2, 4, 117, 41, 20 ); //Horn Rim
set_color_profile_slot( 2, 5, 212, 186, 167 ); //Horns
set_color_profile_slot( 2, 6, 219, 206, 204 ); //Shell
set_color_profile_slot( 2, 7, 251, 251, 253 ); //Fireball

// Color 3
set_color_profile_slot( 3, 0, 130, 69, 29 ); //Hair
set_color_profile_slot( 3, 1, 212, 164, 100 ); //Mouth/Belly
set_color_profile_slot( 3, 2, 240, 188, 72 ); //Skin/Shell
set_color_profile_slot( 3, 3, 112, 69, 25 ); //Skin 2
set_color_profile_slot( 3, 4, 201, 98, 44 ); //Horn Rim
set_color_profile_slot( 3, 5, 227, 222, 183 ); //Horns
set_color_profile_slot( 3, 6, 255, 239, 201 ); //Shell
set_color_profile_slot( 3, 7, 232, 200, 98 ); //Fireball

// SSBU/4 Brown
set_color_profile_slot( 4, 0, 194, 110, 27 ); //Hair
set_color_profile_slot( 4, 1, 189, 147, 106 ); //Mouth/Belly
set_color_profile_slot( 4, 2, 99, 52, 29 ); //Skin/Shell
set_color_profile_slot( 4, 3, 79, 39, 19 ); //Skin 2
set_color_profile_slot( 4, 4, 232, 160, 26 ); //Horn Rim
set_color_profile_slot( 4, 5, 248, 244, 240 ); //Horns
set_color_profile_slot( 4, 6, 232, 223, 181 ); //Shell
set_color_profile_slot( 4, 7, 255, 206, 138 ); //Fireball

// SSBU/4 Yellow
set_color_profile_slot( 5, 0, 214, 187, 68 ); //Hair
set_color_profile_slot( 5, 1, 216, 148, 88 ); //Mouth/Belly
set_color_profile_slot( 5, 2, 112, 43, 25 ); //Skin/Shell
set_color_profile_slot( 5, 3, 227, 153, 57 ); //Skin 2
set_color_profile_slot( 5, 4, 196, 121, 22 ); //Horn Rim
set_color_profile_slot( 5, 5, 255, 202, 148 ); //Horns
set_color_profile_slot( 5, 6, 255, 250, 214 ); //Shell
set_color_profile_slot( 5, 7, 242, 244, 247 ); //Fireball

// SSBU/4 Red
set_color_profile_slot( 6, 0, 200, 48, 40 ); //Hair
set_color_profile_slot( 6, 1, 216, 148, 88 ); //Mouth/Belly
set_color_profile_slot( 6, 2, 186, 46, 90 ); //Skin/Shell
set_color_profile_slot( 6, 3, 150, 27, 27 ); //Skin 2
set_color_profile_slot( 6, 4, 245, 153, 88 ); //Horn Rim
set_color_profile_slot( 6, 5, 219, 206, 191 ); //Horns
set_color_profile_slot( 6, 6, 219, 197, 171 ); //Shell
set_color_profile_slot( 6, 7, 232, 170, 151 ); //Fireball

// SSBU/4 Blue
set_color_profile_slot( 7, 0, 200, 74, 68 ); //Hair
set_color_profile_slot( 7, 1, 216, 148, 88 ); //Mouth/Belly
set_color_profile_slot( 7, 2, 46, 41, 186 ); //Skin/Shell
set_color_profile_slot( 7, 3, 63, 79, 158 ); //Skin 2
set_color_profile_slot( 7, 4, 209, 148, 6 ); //Horn Rim
set_color_profile_slot( 7, 5, 255, 251, 232 ); //Horns
set_color_profile_slot( 7, 6, 245, 237, 237 ); //Shell
set_color_profile_slot( 7, 7, 235, 221, 211 ); //Fireball

// SSBU/4 Gray
set_color_profile_slot( 8, 0, 168, 57, 20 ); //Hair
set_color_profile_slot( 8, 1, 179, 132, 93 ); //Mouth/Belly
set_color_profile_slot( 8, 2, 91, 99, 107 ); //Skin/Shell
set_color_profile_slot( 8, 3, 68, 72, 79 ); //Skin 2
set_color_profile_slot( 8, 4, 189, 80, 25 ); //Horn Rim
set_color_profile_slot( 8, 5, 227, 232, 232 ); //Horns
set_color_profile_slot( 8, 6, 216, 199, 219 ); //Shell
set_color_profile_slot( 8, 7, 214, 206, 217 ); //Fireball

// Melee/Brawl Red
set_color_profile_slot( 9, 0, 232, 197, 43 ); //Hair
set_color_profile_slot( 9, 1, 216, 148, 88 ); //Mouth/Belly
set_color_profile_slot( 9, 2, 158, 19, 19 ); //Skin/Shell
set_color_profile_slot( 9, 3, 166, 81, 6 ); //Skin 2
set_color_profile_slot( 9, 4, 166, 66, 22 ); //Horn Rim
set_color_profile_slot( 9, 5, 232, 208, 162 ); //Horns
set_color_profile_slot( 9, 6, 248, 244, 240 ); //Shell
set_color_profile_slot( 9, 7, 240, 199, 163 ); //Fireball

// Melee/Brawl Blue
set_color_profile_slot( 10, 0, 232, 166, 43 ); //Hair
set_color_profile_slot( 10, 1, 216, 174, 106 ); //Mouth/Belly
set_color_profile_slot( 10, 2, 43, 51, 148 ); //Skin/Shell
set_color_profile_slot( 10, 3, 9, 89, 9 ); //Skin 2
set_color_profile_slot( 10, 4, 85, 96, 97 ); //Horn Rim
set_color_profile_slot( 10, 5, 202, 203, 204 ); //Horns
set_color_profile_slot( 10, 6, 248, 244, 240 ); //Shell
set_color_profile_slot( 10, 7, 233, 252, 227 ); //Fireball

// Melee/Brawl Black
set_color_profile_slot( 11, 0, 191, 65, 12 ); //Hair
set_color_profile_slot( 11, 1, 216, 171, 88 ); //Mouth/Belly
set_color_profile_slot( 11, 2, 61, 52, 43 ); //Skin/Shell
set_color_profile_slot( 11, 3, 71, 64, 38 ); //Skin 2
set_color_profile_slot( 11, 4, 181, 90, 38 ); //Horn Rim
set_color_profile_slot( 11, 5, 242, 226, 99 ); //Horns
set_color_profile_slot( 11, 6, 255, 255, 255 ); //Shell
set_color_profile_slot( 11, 7, 246, 199, 138 ); //Fireball

// Classic
set_color_profile_slot( 12, 0, 176, 74, 40 ); //Hair
set_color_profile_slot( 12, 1, 219, 137, 50 ); //Mouth/Belly
set_color_profile_slot( 12, 2, 59, 143, 14 ); //Skin/Shell
set_color_profile_slot( 12, 3, 76, 122, 39 ); //Skin 2
set_color_profile_slot( 12, 4, 128, 44, 29 ); //Horn Rim
set_color_profile_slot( 12, 5, 251, 255, 227 ); //Horns
set_color_profile_slot( 12, 6, 243, 255, 242 ); //Shell
set_color_profile_slot( 12, 7, 246, 245, 202 ); //Fireball

// Giga Bowser
set_color_profile_slot( 13, 0, 171, 55, 34 ); //Hair
set_color_profile_slot( 13, 1, 189, 161, 76 ); //Mouth/Belly
set_color_profile_slot( 13, 2, 18, 122, 65 ); //Skin/Shell
set_color_profile_slot( 13, 3, 110, 66, 36 ); //Skin 2
set_color_profile_slot( 13, 4, 105, 87, 24 ); //Horn Rim
set_color_profile_slot( 13, 5, 204, 186, 120 ); //Horns
set_color_profile_slot( 13, 6, 235, 228, 204 ); //Shell
set_color_profile_slot( 13, 7, 252, 216, 131 ); //Fireball

// Dark Bowser
set_color_profile_slot( 14, 0, 45, 48, 45 ); //Hair
set_color_profile_slot( 14, 1, 173, 159, 131 ); //Mouth/Belly
set_color_profile_slot( 14, 2, 63, 80, 143 ); //Skin/Shell
set_color_profile_slot( 14, 3, 63, 76, 130 ); //Skin 2
set_color_profile_slot( 14, 4, 64, 61, 84 ); //Horn Rim
set_color_profile_slot( 14, 5, 173, 159, 131 ); //Horns
set_color_profile_slot( 14, 6, 255, 255, 255 ); //Shell
set_color_profile_slot( 14, 7, 207, 162, 222 ); //Fireball

// Dry Bowser
set_color_profile_slot( 15, 0, 200, 48, 40 ); //Hair
set_color_profile_slot( 15, 1, 216, 148, 88 ); //Mouth/Belly
set_color_profile_slot( 15, 2, 7, 157, 17 ); //Skin/Shell
set_color_profile_slot( 15, 3, 216, 124, 32 ); //Skin 2
set_color_profile_slot( 15, 4, 176, 36, 16 ); //Horn Rim
set_color_profile_slot( 15, 5, 232, 172, 144 ); //Horns
set_color_profile_slot( 15, 6, 248, 244, 240 ); //Shell
set_color_profile_slot( 15, 7, 216, 229, 235 ); //Fireball

// 64
set_color_profile_slot( 16, 0, 186, 43, 17 ); //Hair
set_color_profile_slot( 16, 1, 209, 166, 71 ); //Mouth/Belly
set_color_profile_slot( 16, 2, 6, 122, 13 ); //Skin/Shell
set_color_profile_slot( 16, 3, 216, 78, 19 ); //Skin 2
set_color_profile_slot( 16, 4, 161, 41, 14 ); //Horn Rim
set_color_profile_slot( 16, 5, 247, 215, 111 ); //Horns
set_color_profile_slot( 16, 6, 248, 235, 231 ); //Shell
set_color_profile_slot( 16, 7, 244, 202, 129 ); //Fireball

// Midbus
set_color_profile_slot( 17, 0, 217, 50, 120 ); //Hair
set_color_profile_slot( 17, 1, 255, 197, 120 ); //Mouth/Belly
set_color_profile_slot( 17, 2, 255, 200, 0 ); //Skin/Shell
set_color_profile_slot( 17, 3, 217, 50, 120 ); //Skin 2
set_color_profile_slot( 17, 4, 140, 38, 38 ); //Horn Rim
set_color_profile_slot( 17, 5, 48, 42, 37 ); //Horns
set_color_profile_slot( 17, 6, 128, 128, 107 ); //Shell
set_color_profile_slot( 17, 7, 242, 223, 223 ); //Fireball

// Ultimate Koopa
set_color_profile_slot( 18, 0, 0, 255, 0 ); //Hair
set_color_profile_slot( 18, 1, 0, 255, 0 ); //Mouth/Belly
set_color_profile_slot( 18, 2, 0, 255, 0 ); //Skin/Shell
set_color_profile_slot( 18, 3, 0, 255, 0 ); //Skin 2
set_color_profile_slot( 18, 4, 0, 255, 0 ); //Horn Rim
set_color_profile_slot( 18, 5, 0, 255, 0 ); //Horns
set_color_profile_slot( 18, 6, 0, 255, 0 ); //Shell
set_color_profile_slot( 18, 7, 0, 255, 0 ); //Fireball

// Fury Bowser
set_color_profile_slot( 19, 0, 255, 40, 31 ); //Hair
set_color_profile_slot( 19, 1, 72, 72, 72 ); //Mouth/Belly
set_color_profile_slot( 19, 2, 48, 48, 48 ); //Skin/Shell
set_color_profile_slot( 19, 3, 40, 40, 40 ); //Skin 2
set_color_profile_slot( 19, 4, 94, 94, 94 ); //Horn Rim
set_color_profile_slot( 19, 5, 252, 115, 76 ); //Horns
set_color_profile_slot( 19, 6, 89, 89, 89 ); //Shell
set_color_profile_slot( 19, 7, 255, 172, 89 ); //Fireball

// "Dark"Bowser
set_color_profile_slot( 20, 0, 156, 50, 26 ); //Hair
set_color_profile_slot( 20, 1, 212, 158, 59 ); //Mouth/Belly
set_color_profile_slot( 20, 2, 55, 55, 61 ); //Skin/Shell
set_color_profile_slot( 20, 3, 55, 55, 61 ); //Skin 2
set_color_profile_slot( 20, 4, 176, 176, 176 ); //Horn Rim
set_color_profile_slot( 20, 5, 242, 242, 242 ); //Horns
set_color_profile_slot( 20, 6, 245, 245, 245 ); //Shell
set_color_profile_slot( 20, 7, 240, 243, 245 ); //Fireball

// Sol Badguy
set_color_profile_slot( 21, 0, 92, 41, 17 ); //Hair
set_color_profile_slot( 21, 1, 204, 151, 106 ); //Mouth/Belly
set_color_profile_slot( 21, 2, 194, 32, 29 ); //Skin/Shell
set_color_profile_slot( 21, 3, 140, 6, 6 ); //Skin 2
set_color_profile_slot( 21, 4, 97, 61, 33 ); //Horn Rim
set_color_profile_slot( 21, 5, 255, 187, 158 ); //Horns
set_color_profile_slot( 21, 6, 125, 121, 112 ); //Shell
set_color_profile_slot( 21, 7, 255, 224, 171 ); //Fireball

// Justice
set_color_profile_slot( 22, 0, 166, 39, 30 ); //Hair
set_color_profile_slot( 22, 1, 214, 200, 182 ); //Mouth/Belly
set_color_profile_slot( 22, 2, 25, 114, 191 ); //Skin/Shell
set_color_profile_slot( 22, 3, 214, 200, 182 ); //Skin 2
set_color_profile_slot( 22, 4, 125, 112, 112 ); //Horn Rim
set_color_profile_slot( 22, 5, 242, 238, 215 ); //Horns
set_color_profile_slot( 22, 6, 125, 117, 107 ); //Shell
set_color_profile_slot( 22, 7, 255, 229, 181 ); //Fireball

// Godzilla
set_color_profile_slot( 23, 0, 54, 45, 79 ); //Hair
set_color_profile_slot( 23, 1, 43, 34, 66 ); //Mouth/Belly
set_color_profile_slot( 23, 2, 58, 47, 74 ); //Skin/Shell
set_color_profile_slot( 23, 3, 25, 21, 36 ); //Skin 2
set_color_profile_slot( 23, 4, 53, 44, 74 ); //Horn Rim
set_color_profile_slot( 23, 5, 68, 43, 89 ); //Horns
set_color_profile_slot( 23, 6, 84, 76, 105 ); //Shell
set_color_profile_slot( 23, 7, 204, 246, 255 ); //Fireball

// SHADOW THE HEDGEHOG??!??!??!
set_color_profile_slot( 24, 0, 181, 31, 9 ); //Hair
set_color_profile_slot( 24, 1, 217, 135, 46 ); //Mouth/Belly
set_color_profile_slot( 24, 2, 38, 24, 18 ); //Skin/Shell
set_color_profile_slot( 24, 3, 26, 20, 17 ); //Skin 2
set_color_profile_slot( 24, 4, 138, 24, 7 ); //Horn Rim
set_color_profile_slot( 24, 5, 242, 242, 255 ); //Horns
set_color_profile_slot( 24, 6, 255, 246, 245 ); //Shell
set_color_profile_slot( 24, 7, 255, 254, 179 ); //Fireball

// Iron Tager
set_color_profile_slot( 25, 0, 97, 99, 105 ); //Hair
set_color_profile_slot( 25, 1, 222, 102, 54 ); //Mouth/Belly
set_color_profile_slot( 25, 2, 158, 15, 15 ); //Skin/Shell
set_color_profile_slot( 25, 3, 207, 60, 0 ); //Skin 2
set_color_profile_slot( 25, 4, 43, 46, 43 ); //Horn Rim
set_color_profile_slot( 25, 5, 191, 182, 159 ); //Horns
set_color_profile_slot( 25, 6, 104, 112, 112 ); //Shell
set_color_profile_slot( 25, 7, 255, 247, 143 ); //Fireball

// Susanoo
set_color_profile_slot( 26, 0, 97, 98, 161 ); //Hair
set_color_profile_slot( 26, 1, 83, 84, 122 ); //Mouth/Belly
set_color_profile_slot( 26, 2, 74, 74, 110 ); //Skin/Shell
set_color_profile_slot( 26, 3, 74, 74, 110 ); //Skin 2
set_color_profile_slot( 26, 4, 97, 232, 125 ); //Horn Rim
set_color_profile_slot( 26, 5, 83, 110, 122 ); //Horns
set_color_profile_slot( 26, 6, 137, 240, 157 ); //Shell
set_color_profile_slot( 26, 7, 177, 250, 173 ); //Fireball

// Broly
set_color_profile_slot( 27, 0, 226, 255, 179 ); //Hair
set_color_profile_slot( 27, 1, 235, 191, 110 ); //Mouth/Belly
set_color_profile_slot( 27, 2, 168, 49, 80 ); //Skin/Shell
set_color_profile_slot( 27, 3, 216, 159, 108 ); //Skin 2
set_color_profile_slot( 27, 4, 161, 113, 59 ); //Horn Rim
set_color_profile_slot( 27, 5, 242, 234, 191 ); //Horns
set_color_profile_slot( 27, 6, 235, 246, 255 ); //Shell
set_color_profile_slot( 27, 7, 227, 255, 227 ); //Fireball

// Bowletta
set_color_profile_slot( 28, 0, 209, 6, 8 ); //Hair
set_color_profile_slot( 28, 1, 221, 208, 135 ); //Mouth/Belly
set_color_profile_slot( 28, 2, 7, 223, 29 ); //Skin/Shell
set_color_profile_slot( 28, 3, 212, 161, 51 ); //Skin 2
set_color_profile_slot( 28, 4, 237, 186, 76 ); //Horn Rim
set_color_profile_slot( 28, 5, 246, 137, 194 ); //Horns
set_color_profile_slot( 28, 6, 240, 233, 239 ); //Shell
set_color_profile_slot( 28, 7, 244, 202, 129 ); //Fireball

// Kragg
set_color_profile_slot( 29, 0, 140, 116, 107 ); //Hair
set_color_profile_slot( 29, 1, 202, 205, 209 ); //Mouth/Belly
set_color_profile_slot( 29, 2, 89, 128, 74 ); //Skin/Shell
set_color_profile_slot( 29, 3, 89, 128, 74 ); //Skin 2
set_color_profile_slot( 29, 4, 140, 116, 107 ); //Horn Rim
set_color_profile_slot( 29, 5, 202, 205, 209 ); //Horns
set_color_profile_slot( 29, 6, 186, 154, 142 ); //Shell
set_color_profile_slot( 29, 7, 240, 245, 238 ); //Fireball

// VAE
set_color_profile_slot( 30, 0, 218, 31, 63 ); //Hair
set_color_profile_slot( 30, 1, 209, 199, 199 ); //Mouth/Belly
set_color_profile_slot( 30, 2, 49, 28, 99 ); //Skin/Shell
set_color_profile_slot( 30, 3, 218, 31, 63 ); //Skin 2
set_color_profile_slot( 30, 4, 218, 31, 63 ); //Horn Rim
set_color_profile_slot( 30, 5, 36, 14, 36 ); //Horns
set_color_profile_slot( 30, 6, 209, 199, 199 ); //Shell
set_color_profile_slot( 30, 7, 255, 245, 246 ); //Fireball


/* This is a comment used by that one RoA colors.gml generator tool to store palette data. You can safely keep it in your colors.gml if you plan to re-use the tool later, or safely remove it if you don't.
=== BEGIN JSON PALETTE ===
{"formatversion":1,"data":[{"name":"Hair","colors":[{"r":200,"g":48,"b":40,"main":true},{"r":153,"g":4,"b":2}]},{"name":"Mouth/Belly","colors":[{"r":240,"g":208,"b":168},{"r":216,"g":148,"b":88,"main":true},{"r":168,"g":100,"b":48}]},{"name":"Skin/Shell","colors":[{"r":7,"g":157,"b":17,"main":true},{"r":8,"g":92,"b":16}]},{"name":"Skin 2","colors":[{"r":240,"g":188,"b":72},{"r":216,"g":124,"b":32,"main":true},{"r":177,"g":62,"b":16}]},{"name":"Horn Rim","colors":[{"r":184,"g":52,"b":32},{"r":176,"g":36,"b":16,"main":true},{"r":120,"g":32,"b":16}]},{"name":"Horns","colors":[{"r":232,"g":172,"b":144,"main":true},{"r":184,"g":112,"b":88}]},{"name":"Shell","colors":[{"r":248,"g":244,"b":240,"main":true},{"r":184,"g":180,"b":176},{"r":120,"g":120,"b":120}]},{"name":"Fireball","colors":[{"r":201,"g":101,"b":236,"main":true},{"r":123,"g":7,"b":218},{"r":50,"g":3,"b":135}]}]}
=== END JSON PALETTE ===
*/






 
#define rangeSet(sha, col) // Auto-sets ranges to 1. Translates GML's asinine BGR hex colors to RGB.
 
set_color_profile_slot(0, sha, color_get_blue(col), color_get_green(col), color_get_red(col));
set_color_profile_slot_range(sha, 1, 1, 1);
 
 
 
#define colorSet(alt, sha, col) // Streamlines color setup. Translates BRG --> RGB.
 
set_color_profile_slot(alt, sha, color_get_blue(col), color_get_green(col), color_get_red(col));