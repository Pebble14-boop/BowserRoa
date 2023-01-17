///#args attack // this line makes code editors not freak out for some reason

if (attack == AT_USPECIAL && !free)
    attack = AT_USPECIAL_2;

if(attack == AT_NSPECIAL){
    fire_charge = 0;
    fireball = noone;
    fireball_num = 3;
}





// MunoPhone Touch code - don't touch
// should be at BOTTOM of file, but above any #define lines
muno_event_type = 2;
user_event(14);