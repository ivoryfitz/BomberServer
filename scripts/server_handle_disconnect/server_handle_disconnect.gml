/// server_handle_disconnect/1
/// @description Handles disconnect events. Will destroy the corresponding obj_serverClient
///              as well as removing the socketId entry from the map.                 
/// @param {Real} socketId The socket that has disconnected

var socketIdStr = string(argument0);

with(serverClientMap[? socketIdStr]) {
  instance_destroy();
}

ds_map_delete(serverClientMap, socketIdStr);