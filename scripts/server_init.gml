var CMD_PING = 0;

var ip = '10.50.19.239';
var port = 6510;

if (global.host) {
    log('Starting server on ' + string(port));
    server = network_create_server(network_socket_tcp, port, 32);
    clients = ds_map_create();
} else {
    log('Connecting to server ' + string(ip) + ':' + string(port));
    client = network_create_socket(network_socket_tcp);
    network_connect(client, ip, port);
    
    buff = buffer_create(256, buffer_grow, 1);
    buffer_seek(buff, buffer_seek_start, 0);
    buffer_write(buff, buffer_u8, CMD_PING);
    network_send_packet(client, buff, buffer_tell(buff));
}

