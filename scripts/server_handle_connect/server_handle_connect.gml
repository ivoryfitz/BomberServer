/// server_handle_connect/1
/// @description Handles connection events. Will add the connecting socket as a obj_serverClient
///              to serverClientMap
/// @param {Real} socketId The socket that has connected

var socketId = argument0;

var newServerClient = instance_create_layer(0, 0, "Instances", obj_serverClient);
newServerClient.socketId = socketId;
newServerClient.clientId = nextClientIdToAssign++;

if(nextClientIdToAssign >= 65000) {
  nextClientIdToAssign = 0;
}

serverClientMap[? string(socketId)] = newServerClient;

buffer_seek(sendBuffer, buffer_seek_start, 0);
buffer_write(sendBuffer, buffer_u8, messages.CONNECTED);
network_send_raw(socketId, sendBuffer, buffer_tell(sendBuffer));