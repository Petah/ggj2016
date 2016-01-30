// argument0: command
// argument1: instance

// log("Process command " + string(argument0) + " on " + string(argument1));

with (argument1) {
    switch (argument0) {
        case CMD_ACCELERATE: {
            motion_add(rotation, ship_thrust_forward)
            if(speed > ship_max_speed) {
                speed = ship_max_speed;
            }
            broadcast_particle(global.thrust_particle, x - lengthdir_x(20, rotation), y - lengthdir_y(20, rotation));
            // particle_create_wrap(x - lengthdir_x(20, rotation), y - lengthdir_y(20, rotation), global.thrust_particle);
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
            if (loaded) {
                var bullet = instance_create(x + lengthdir_x(25, rotation - gun_angle), y + lengthdir_y(25, rotation - gun_angle), obj_bullet_1);
                bullet.speed = speed + bullet.ammo_speed;
                bullet.direction = rotation;
                bullet.image_angle = rotation;
                bullet.alarm[0] = bullet.ammo_lifespan;
                bullet.ship_id = id;
                
                gun_angle = -gun_angle;
                
                audio_play_sound(snd_shoot_1, 50, false);
    
                loaded = false;
                alarm[1] = max(bullet.ammo_reload_speed / ship_reload_modifier, 1);
            }
            break;
        }
    }
    image_angle = rotation;
}

