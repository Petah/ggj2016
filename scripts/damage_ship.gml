with (argument0) {
    ship_hp -= argument1;
    if (ship_hp < 0) {
        dead = true;
        if (object_index != obj_bot) {
            send_count_down(id);
        }
        ship_died_x = x;
        ship_died_y = y;
        broadcast_particle_burst(global.mine_ship_bits, x, y);
        ship_score -= 500;
        // log("Remote score " + string(ship_score));
        if (ship_score < 0) {
            ship_score = 0;
        }
        move_outside_bounds(self.id);
        speed = 0;
        alarm[0] = room_speed * 3.4;
        audio_play_sound(snd_beep_1, 20, false);
    }
}
return false;
