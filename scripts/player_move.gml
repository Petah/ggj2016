turn_speed = 15;
acceleration = 1;

if (keyboard_check(vk_up)) {
    speed += acceleration;
}

if (keyboard_check(vk_down)) {
    speed -= acceleration;
}

if (keyboard_check(vk_left)) {
    direction += turn_speed; 
}

if (keyboard_check(vk_right)) {
    direction -= turn_speed; 
}

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


