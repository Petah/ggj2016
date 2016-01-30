// argument0: command

log("Send command " + string(argument0));

buffer_seek(global.client_buffer, buffer_seek_start, 0);
buffer_write(global.client_buffer, buffer_s32, argument0);
network_send_packet(global.client, global.client_buffer, buffer_tell(global.client_buffer));

