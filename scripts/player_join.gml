// argument0: player id

var spawn_x = random_range(0, room_width);
var spawn_y = random_range(0, room_height);

log("Join at " + string(spawn_x) + "," + string(spawn_y));

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_JOIN);
buffer_write(global.server_buffer, buffer_s32, global.next_player_id);
buffer_write(global.server_buffer, buffer_f32, spawn_x);
buffer_write(global.server_buffer, buffer_f32, spawn_y);
broadcast(global.server_buffer);

