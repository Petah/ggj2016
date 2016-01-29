// argument0: player id

buffer_seek(global.server_buffer, buffer_seek_start, 0);
buffer_write(global.server_buffer, buffer_s32, CMD_PLAYER_JOIN);
buffer_write(global.server_buffer, buffer_s32, global.next_player_id);
broadcast(global.server_buffer);

