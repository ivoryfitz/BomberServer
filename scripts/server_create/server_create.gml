/// server_create/1
/// @description Initializes and sets up obj_server for business
/// @param {Real} port The port to listen on

var port = argument0;
server = network_create_server_raw(network_socket_tcp, port, 20);
debug_print("Server::network_create_server_raw", "Result", server);
serverClientMap = ds_map_create();
nextClientIdToAssign = 0;
sendBuffer = buffer_create(256, buffer_fixed, 1); 
if (server != 0) show_error("Could not create server!", true);
