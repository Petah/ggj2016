// argument0: command
// argument1: socket
// argument2: player id

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, argument0);
buffer_write(global.server_buffer, buffer_s32, argument2);
network_send_packet(socket, global.server_buffer, buffer_tell(global.server_buffer));

