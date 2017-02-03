switch(async_load[? "type"]) {
  case network_type_connect:
  case network_type_non_blocking_connect:
    var socketId = async_load[? "socket"];
    debug_print("Server Connection Event", "Socket", socketId, "id", async_load[? "id"]);
    server_handle_connect(socketId);
  break;    
  
  case network_type_data:
    var socketId = async_load[? "id"];
    var dataBuffer = async_load[? "buffer"];
    debug_print("Server Data Event", "Socket", socketId, "id", async_load[? "id"], "Buffer Size", buffer_get_size(dataBuffer));
    if(socketId != global.localPlayerClient) {
      server_handle_message(socketId, dataBuffer);
    } else {
      debug_print("Server Ignoring Data Event");
    }
  break;
  
  case network_type_disconnect:
    var socketId = async_load[? "socket"];
    debug_print("Server Disconnect Event", "SocketId", socketId);
    server_handle_disconnect(socketId);
  break;    
}