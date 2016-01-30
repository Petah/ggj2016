with (argument0) {
    ship_hp -= argument1;
    if (ship_hp < 0) {
        dead = true;
        x = -1000000;
        y = -1000000;
        speed = 0;
        alarm[0] = room_speed * 5;
        return true;
    }
}
return false;
