public void parse() {
  for (String s : lines) {
    textProgram.add(s);
  }

  boolean activeFlag = false;
  for (int i = 0; i < lines.size(); i++) {
    String s = lines.get(i);
    if (activeFlag) {
      if (s.equals(endString)) {
        activeFlag = false;
        streamEnd = i;
        textMessages.add("END");
      } else {
        parseLine(s);
      }
    } else {
      if (s.equals(startString)) {
        activeFlag = true;
        streamStart = i;
        textMessages.add("START");
      }
      else {
        textMessages.add("...");
      }
    }
  }
}

public void parseLine(String s) {
  if (substring2(s, 0, 3).equals("LIN")) {
    parseLIN(s);
  } else if (substring2(s, 0, 3).equals("PTP")) {
    parsePTP(s);
  } else if (substring2(s, 0, 12).equals("TOOL_COMMAND")) {
    parseCommand(s);
  } else {
    textMessages.add(" ");
  }
}

public void parseLIN(String s) {
  ByteBuffer out = ByteBuffer.allocate(28);
  out.put(0, CMD_LIN);
  out.put(1, (byte)0);

  Matcher m = curlyBracePattern.matcher(s);
  if (m.find()) {
    String content = m.group();
    content = content.substring(8, content.length() - 1);
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

public void parsePTP(String s) {
  ByteBuffer out = ByteBuffer.allocate(28);
  out.put(0, CMD_PTP);
  out.put(1, (byte)0);

  Matcher m = curlyBracePattern.matcher(s);
  if (m.find()) {
    String content = m.group();
    int firstSpace = content.indexOf(" ");
    content = content.substring(firstSpace + 1, content.length() - 1);
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

public void parseCommand(String s) {
  ByteBuffer out = ByteBuffer.allocate(28);
  out.put(0, CMD_TOOL_COMMAND);
  out.put(1, (byte)0);

  messages.add(out);
  textMessages.add(Arrays.toString(out.array()));
}