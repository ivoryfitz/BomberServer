
  var stringBuilder = "[DEBUG]====" + argument[0] + "====" + "\n";
  for (var i = 1; i < argument_count; i++) {
    stringBuilder += "\t" + argument[i++] + "::" + string(argument[i]);
    if (i < argument_count - 1) stringBuilder += "\n";
  }
  show_debug_message(stringBuilder)
