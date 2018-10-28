public void parseCommand(String s) {
  ByteBuffer out = ByteBuffer.allocate(messageSize);
  out.put(CMD_TOOL_COMMAND);

  Matcher m = parenPattern.matcher(s);
  if (m.find()) {
    String content = m.group(1);
    String[] args = content.split(",");
    out.put(Byte.valueOf(args[0]));
    for (int i = 1 ; i < args.length; i++) {
       out.putInt(Integer.valueOf(args[i]));
    }
  }

  messages.add(out);
  textMessages.add(Arrays.toString(out.array()));
}