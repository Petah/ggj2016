// argument0: client socket
// argument1: player id

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_INIT);
buffer_write(global.server_buffer, buffer_s32, argument1);
network_send_packet(argument0, global.server_buffer, buffer_tell(global.server_buffer));

