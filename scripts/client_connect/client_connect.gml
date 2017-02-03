/// client_connect/2
/// @description Establishes the connection for obj_playerClient to obj_server
/// @param {String} ip IP Address to connect to
/// @param {Real} port Port to connect to
/// @param {String} name username to send to server

var scr_ip = argument0;
var scr_port = argument1;
var scr_name = argument2;

socketId = network_create_socket(network_socket_tcp);
global.localPlayerClient = socketId;
var connError = network_connect_raw(socketId, scr_ip, scr_port);
debug_print("Player Socket", "Socket", socketId);
sendBuffer = buffer_create(256, buffer_fixed, 1);
otherPlayersMap = ds_map_create();
if (connError < 0) {
  show_error("Could not connect to Server!", true);
}
buffer_seek(sendBuffer, buffer_seek_start, 0);
buffer_write(sendBuffer, buffer_u8, messages.CONNECT);
buffer_write(sendBuffer, buffer_string, scr_name);
network_send_raw(socketId, sendBuffer, buffer_tell(sendBuffer));