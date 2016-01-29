// argument0: command
// argument1: instance

process_command(argument0, argument1);

// Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
buffer_seek(global.client_buffer, buffer_seek_start, 0);

// Write the command into the buffer
buffer_write(global.client_buffer, buffer_s32, argument0);

// Send this to the server
network_send_packet(global.client, global.client_buffer, buffer_tell(global.client_buffer));

