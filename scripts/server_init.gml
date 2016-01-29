var ip;
var port = 6510;

global.server = noone;
global.player_id = noone;
global.next_player_id = 1000;
global.network_players = ds_map_create();

if (global.host) {
    log('Starting server on ' + string(port));
    global.server = network_create_server(network_socket_tcp, port, 32);
    global.clients = ds_map_create();
    ip = '127.0.0.1';
    global.server_buffer = buffer_create(256, buffer_grow, 1);
} else {
    ip = '10.50.19.239';
}

log('Connecting to server ' + string(ip) + ':' + string(port));
global.client = network_create_socket(network_socket_tcp);
network_connect(global.client, ip, port);

global.client_buffer = buffer_create(256, buffer_grow, 1);

alarm[0] = 30;

