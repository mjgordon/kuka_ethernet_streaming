public void parse() {
  for (String s : lines) {
    textProgram.add(s);
  }

  pcMap.clear();
  lineMap.clear();

  boolean activeFlag = false;
  PC = 0;
  for (int i = 0; i < lines.size(); i++) {
    String s = lines.get(i);
    if (activeFlag) {
      if (s.equals(endString)) {
        activeFlag = false;
        streamEnd = i;
      } 
      if (parseLine(s)) {
        pcMap.put(i,PC); 
        lineMap.put(PC,i);
        PC++;
      }
    } else {
      if (s.equals(startString)) {
        activeFlag = true;
        streamStart = i;
        if (parseLine(s)) {
          pcMap.put(i,PC);
          lineMap.put(PC,i);
          PC++;
        }
      } else {
        textMessages.add("...");
      }
    }
  }

  PC = 0;
  
  println(lines.size());
}

//Returns true if a message was created
public boolean parseLine(String s) {
  if (s.equals(";STREAM_START")) {
    ByteBuffer out = ByteBuffer.allocate(messageSize);
    out.put(0, CMD_START);
    messages.add(out);
    textMessages.add(Arrays.toString(out.array()));
  } else if (substring2(s, 0, 3).equals("LIN")) {
    parseLIN(s);
  } else if (substring2(s, 0, 3).equals("PTP")) {
    parsePTP(s);
  } else if (substring2(s, 0, 12).equals("TOOL_COMMAND")) {
    parseCommand(s);
  } else if (s.equals(";STREAM_END")) {
    ByteBuffer out = ByteBuffer.allocate(messageSize);
    out.put(0, CMD_END);
    messages.add(out);
    textMessages.add(Arrays.toString(out.array()));
  } else {
    textMessages.add(" ");
    return(false);
  }
  return(true);
}