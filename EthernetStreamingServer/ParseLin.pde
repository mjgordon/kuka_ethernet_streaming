public void parseLIN(String s) {
  ByteBuffer out = ByteBuffer.allocate(messageSize);
  out.put(0, CMD_LIN);
  out.put(1, (byte)0);

  Matcher m = curlyBracePattern.matcher(s);
  if (m.find()) {
    String content = m.group(1);
    content = content.substring(7);
    String[] parts = content.split(", ");
    for (int i = 0; i < 6; i++) {
      String part = parts[i];
      String[] parts2 = part.split(" ");
      float data = Float.parseFloat(parts2[1]);

      out.putFloat(2 + (i * 4), data);
    }
  }
  messages.add(out);
  textMessages.add(Arrays.toString(out.array()));
}