if (keyboard_check(vk_up)) {
    motion_add(rotation, 1);
}

if (keyboard_check(vk_down)) {
    speed -= 1;
    if (speed < 0) {
        speed = 0;
    }
}

if (keyboard_check(vk_left)) {
    rotation += 10;
}

if (keyboard_check(vk_right)) {
    rotation -= 10;
}

if (keyboard_check_pressed(vk_space)) {
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

