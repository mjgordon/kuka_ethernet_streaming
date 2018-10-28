public void parsePTP(String s) {
  ByteBuffer out = ByteBuffer.allocate(messageSize);


  Matcher m = curlyBracePattern.matcher(s);
  if (m.find()) {
    String content = m.group();

    int dataOffset = -1;
    Matcher typeMatcher = E6POSPattern.matcher(content);
    if (typeMatcher.find()) {
      out.put(0, CMD_PTP_POS);
      dataOffset = typeMatcher.end();
    }
    
    typeMatcher = E6AXISPattern.matcher(content);
    if (typeMatcher.find()) {
      out.put(0,CMD_PTP_AXIS);
      dataOffset = typeMatcher.end();
    }
    
    out.put(1, (byte)0);
    
    content = content.substring(dataOffset);
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