/// client_handle_message/1
/// @description Handles the data event. This is where the server ends up telling
///              us how to draw the game state.
/// @param {Buffer} buffer The data we've received

var buffer = argument0;

while(true) {
  var messageId = buffer_read(buffer, buffer_u8);
  switch(messageId) {
    case messages.MOVE:
      var senderClientId = buffer_read(buffer, buffer_u16);
      var xx = buffer_read(buffer, buffer_u16);
      var yy = buffer_read(buffer, buffer_u16);
      
      var senderOtherPlayer = client_get_object(senderClientId);
      senderOtherPlayer.x = xx;
      senderOtherPlayer.y = yy;
    break;
    
    case messages.CONNECTED:
      var connectingClientId = buffer_read(buffer, buffer_u16);
      var connectingName = buffer_read(buffer, buffer_u16);
      var senderOtherPlayer = client_get_object(senderClientId);
      senderOtherPlayer.name = connectingName;
      connected = true;
      
    break; 
  }
  
  //Breakout if we've read everything off the buffer
  if(buffer_tell(buffer) == buffer_get_size(buffer)) {
    break;
  }
}