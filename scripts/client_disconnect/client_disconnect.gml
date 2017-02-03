/// client_disconnect/0
/// @description Clean up our mess

ds_map_destroy(otherPlayersMap);
network_destroy(socketId);