if (asteroid_split) {
    for (var i = 0; i < random_range(2, 6); i++) {
        var asteroid = instance_create(x, y, obj_asteroid);
        asteroid.sprite_index = asteroid_split_into;
        asteroid.ship_hp /= 2;
        asteroid.asteroid_split = false;
    }

    if (object_is_ancestor(other.object_index, obj_bullet)) { 
        if (random(5) < 1) {
            instance_create(x, y, obj_powerup_rapid_fire);
        }
    }
} else if (object_is_ancestor(other.object_index, obj_bullet)) { 
    for (var i = 0; i < random_range(1,6); i++) {
        var coin = instance_create(x, y, obj_coin_1);
    }
}
instance_destroy();

