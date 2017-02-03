if(!connected) {
  connected = true;
  client_connect("173.174.90.144", 9000, async_load[? "result"]);
  alarm[0] = global.UPDATE_SPEED;

}