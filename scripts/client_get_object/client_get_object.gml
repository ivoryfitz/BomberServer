/// client_get_object/1
/// @description Convenience method for getting the obj_otherPlayer out of the map
/// @param {Real} clientId The clientId that we want/need


var scr_clientId = argument0;
var scr_clientIdStr = string(scr_clientId);

if(ds_map_exists(otherPlayersMap, scr_clientIdStr)) {
  return otherPlayersMap[? scr_clientIdStr];
} else {
  var newOtherPlayer = instance_create_layer(0, 0, "Instances", obj_otherPlayer);
  otherPlayersMap[? scr_clientIdStr] = newOtherPlayer;
  return newOtherPlayer;
}