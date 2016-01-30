// argument0: command
// argument1: instance

// log("Process command " + string(argument0) + " on " + string(argument1));

with (argument1) {
    switch (argument0) {
        case CMD_ACCELERATE: {
            motion_add(rotation, ship_thrust_forward)
            if(speed > ship_max_speed)
            {
                speed = ship_max_speed;
            }
            particle_create_wrap(x, y, global.thrust_particle);
            break;
        }
        case CMD_BREAK: {
            speed -= ship_thrust_reverse;
            if (speed < 0) {
                speed = 0;
            }
            break;
        }
        case CMD_TURN_RIGHT: {
            rotation -= ship_turn_speed;
            break;
        }
        case CMD_TURN_LEFT: {
            rotation += ship_turn_speed;
            break;
        }
        case CMD_FIRE_1: {
            var bullet = instance_create(x, y, obj_bullet_1);
            bullet.speed = speed + bullet.ammo_speed;
            bullet.direction = rotation;
            bullet.alarm[0] = bullet.ammo_lifespan;
            bullet.ship_id = id;
            break;
        }
    }
}
