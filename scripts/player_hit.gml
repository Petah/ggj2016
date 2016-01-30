if (ship_id != other.id) {
    with (other) {
        ship_hp -= other.ammo_damage;
        if (ship_hp < 0) {
            dead = true;
            x = -1000000;
            y = -1000000;
            speed = 0;
            alarm[0] = room_speed * 5;
        }
    }
    move_contact_solid(direction, speed);
    instance_create(x, y, obj_explosion);
    instance_destroy();
}

