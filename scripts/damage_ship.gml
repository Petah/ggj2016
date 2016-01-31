with (argument0) {
    ship_hp -= argument1;
    if (ship_hp < 0) {
        dead = true;
        broadcast_particle_burst(global.mine_ship_bits, x, y);
        obj_count_down.image_index = 0;
        obj_count_down.alarm[0] = room_speed;
        ship_score -= 50;
        log("Remote score " + string(ship_score));
        if (ship_score < 0) {
            ship_score = 0;
        }
        x = -1000000;
        y = -1000000;
        speed = 0;
        alarm[0] = room_speed * 3.4;
        audio_play_sound(snd_beep_1, 20, false);
    }
}
return false;
