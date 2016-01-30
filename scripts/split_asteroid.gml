if (asteroid_split) {
    for (var i = 0; i < random_range(2, 6); i++) {
        var asteroid = instance_create(x, y, obj_asteroid);
        asteroid.sprite_index = asteroid_split_into;
        asteroid.ship_hp /= 2;
        asteroid.asteroid_split = false;
    }
}
instance_destroy();

