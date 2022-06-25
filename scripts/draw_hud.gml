// prevents draw_hud from running a frame too early and spitting an error
if "phone" not in self exit;



// MunoPhone Touch code - don't touch
// should be at BOTTOM of file, but above any #define lines
muno_event_type = 5;
user_event(14);