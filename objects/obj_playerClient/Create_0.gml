///@description obj_playerClient works hand in hand with obj_player and obj_otherPlayer
///             to make things tic. It communicates with the server and with other clients.
connected = false;
name = "";
get_string_async("Please enter a username", "");
