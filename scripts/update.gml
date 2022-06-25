// MunoPhone Touch code - don't touch
// should be at TOP of file
muno_event_type = 1;
user_event(14);

doing_goku_beam = (phone_attacking && attack == AT_NSPECIAL && window == clamp(window, 4, 6));

if phone_cheats[CHEAT_FLY] && !shield_down vsp = -1;

//intro anim
if (introTimer2 < 5) {
    introTimer2++;
} else {
    introTimer2 = 0;
    introTimer++;
}
//this increments introTimer every few frames, depending on the number entered

if (introTimer < 14) {
    draw_indicator = false;
} else {
    draw_indicator = true;
}
//this stops the overhead HUD from getting in the way of the animation. If your animation does not involve much movement, this may not be necessary.
