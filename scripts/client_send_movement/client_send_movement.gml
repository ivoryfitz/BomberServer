///client_send_movement/0
///@description Send player movement update

buffer_seek(sendBuffer, buffer_seek_start, 0);
buffer_write(sendBuffer, buffer_u8, messages.MOVE);
buffer_write(sendBuffer, buffer_u16, round(obj_player.x));
buffer_write(sendBuffer, buffer_u16, round(obj_player.y));
debug_print("Player::Firing Update", "Socket from `network_create_socket`", socketId);
network_send_raw(socketId, sendBuffer, buffer_tell(sendBuffer));