if (keyboard_check(vk_up)) {
    send_command(CMD_ACCELERATE, self);
}

if (keyboard_check(vk_down)) {
    send_command(CMD_BREAK, self);
}

if (keyboard_check(vk_left)) {
    send_command(CMD_TURN_LEFT, self);
}

if (keyboard_check(vk_right)) {
    send_command(CMD_TURN_RIGHT, self);
}

if (keyboard_check_pressed(vk_space)) {
    send_command(CMD_FIRE_1, self);
}

/*
if (keyboard_check_pressed(vk_space)) {
    var bullet = instance_create(x, y, obj_bullet);
    with (bullet) {
        speed = other.speed + 10;
        direction = other.direction;
    }
}

image_angle = direction;

view_xview[view_current] = x - (view_wview[view_current] / 2);
view_yview[view_current] = y - (view_hview[view_current] / 2);
*/

