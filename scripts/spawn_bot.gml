var spawn_x = random_range(0, room_width);
var spawn_y = random_range(0, room_height);

var bot = instance_create(spawn_x, spawn_y, obj_bot);
bot.ship_name = "Bot";

