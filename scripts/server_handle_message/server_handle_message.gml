/// server_handle_message/2
/// @description Handles data events. This will be where you found most of the complexity
///              within obj_server. Since we're following a Peer-to-Server mentality, this
///              script has to handle reading all inbound messages from obj_playerClients 
///              and then propagating that message out to all other obj_playerClients as needed.
/// @param {Real} socketId The socket that has sent the data
/// @param {Buffer} buffer The data that was sent

var senderSocketId = argument0;
var buffer = argument1;
var serverClientSender = serverClientMap[? string(senderSocketId)];

while(true) {
  // All incoming data packets MUST have an identifying byte. This tells us the purpose of
  // the message.
  var messageId = buffer_read(buffer, buffer_u8);
  switch(messageId) {
    case messages.MOVE:
      //Someone told us they Moved!
      //Read off the buffer to find out where they moved to
      var xx = buffer_read(buffer, buffer_u16);
      var yy = buffer_read(buffer, buffer_u16);
      
      //Now we need to create a new Message to tell everyone else
      //about this person moving.
      buffer_seek(sendBuffer, buffer_seek_start, 0);
      buffer_write(sendBuffer, buffer_u8, messages.MOVE);
      buffer_write(sendBuffer, buffer_u16, serverClientSender.clientId);
      buffer_write(sendBuffer, buffer_u16, xx);
      buffer_write(sendBuffer, buffer_u16, yy);
      
      with(obj_serverClient) {
        if(clientId != serverClientSender.clientId) {
          //debug_print("Server::Sending Updates Out", "Socket", socketId, "ServerClientId", clientId);
          network_send_raw(socketId, other.sendBuffer, buffer_tell(other.sendBuffer));    
        }
      }
    break;   
    
    case messages.CONNECT:
      var receivedName = buffer_read(buffer, buffer_string);
      serverClientSender.name = receivedName;
      
      buffer_seek(sendBuffer, buffer_seek_start, 0);
      buffer_write(sendBuffer, buffer_u8, messages.CONNECTED);
      buffer_write(sendBuffer, buffer_u16, serverClientSender.clientId);
      buffer_write(sendBuffer, buffer_string, serverClientSender.name);
      
      with(obj_serverClient) {
        if(clientId != serverClientSender.clientId) {
          debug_print("Server::Sending Client Name", "ClientId", serverClientSender.clientId, "Name", serverClientSender.name);
          network_send_raw(socketId, other.sendBuffer, buffer_tell(other.sendBuffer));    
        }
      }
      
      with(obj_serverClient) {
        if(clientId != serverClientSender.clientId) {
          buffer_seek(other.sendBuffer, buffer_seek_start, 0);
          buffer_write(other.sendBuffer, buffer_u8, messages.CONNECTED);
          buffer_write(other.sendBuffer, buffer_u16, clientId);
          buffer_write(other.sendBuffer, buffer_string, name);
          debug_print("Server::Sending Client Name", "ClientId", clientId, "Name", name);
          network_send_raw(serverClientSender.socketId, other.sendBuffer, buffer_tell(other.sendBuffer));    
        }
      }
    break;
  }
  
  //Breakout if we've read everything off the buffer
  if(buffer_tell(buffer) == buffer_get_size(buffer)) {
    //debug_print("Server::Breaking out, buffer consumed");
    break;
  }
}