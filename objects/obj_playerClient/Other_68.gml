var eventId = async_load[? "id"];

if(socketId == eventId) {
  switch(async_load[? "type"]) {
    case network_type_data:
      var receivedBuffer = async_load[? "buffer"];
      var buffSize = buffer_get_size(receivedBuffer);
      debug_print("Player Data Event", "Socket", async_load[? "socket"], "id", eventId, "Buffer Size", buffSize); 
      client_handle_message(receivedBuffer);
    break;
  }
} else {
  debug_print("Player::Not My Socket, Ignoring.");
}