if (text == "Create Server") {
  with(obj_button) instance_destroy();
  instance_create_layer(0, 0, "Instances", obj_server);
  var playerClient = instance_create_layer(0, 0, "Instances", obj_playerClient);
  playerClient.connected = true;
  
  instance_create_layer(100, 100, "Instances", obj_player);
} else {
  with(obj_button) instance_destroy();
  instance_create_layer(0, 0, "Instances", obj_playerClient);
  instance_create_layer(100, 100, "Instances", obj_player);
}