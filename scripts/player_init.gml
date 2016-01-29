// argument0: client socket
// argument1: player id

var spawn_x = random_range(0, room_width);
var spawn_y = random_range(0, room_height);

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_INIT);
buffer_write(global.server_buffer, buffer_s32, argument1);
buffer_write(global.server_buffer, buffer_f32, spawn_x);
buffer_write(global.server_buffer, buffer_f32, spawn_y);
network_send_packet(argument0, global.server_buffer, buffer_tell(global.server_buffer));

