var asteroid = instance_create(random_range(0, room_width), random_range(0, room_height), obj_asteroid);
switch (choose(0, 1)) {
    case 0: {
        asteroid.sprite_index = spr_meteor_large_grey;
        asteroid.asteroid_split_into = spr_meteor_small_grey;
        break;
    }
    case 1: {
        asteroid.sprite_index = spr_meteor_large_brown;
        asteroid.asteroid_split_into = spr_meteor_small_brown;
        break;
    }
    default: {
        show_message("Couldn't create asteroid");
    }
}

