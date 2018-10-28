Server server;

public void setupServer() {
  server = new Server(this, 52323);
}

public void updateServer() {
  Client c = server.available(); 

  if (c != null) {
    if (c.available() >= 5) {
      ByteBuffer message = ByteBuffer.allocate(5);
      c.readBytes(message.array());
      byte command = message.get(0);
      int data = message.getInt(1);

      if (command == CMD_REQUEST_COMMANDS) {
        sendCommands(c, data);
      }
    }
  }
}

public void sendCommands(Client c, int amount) {
  int start = PC;
  for (int i = 0; i < amount; i++) {
    c.write(messages.get(start + i).array());

    if (lineMap.get(start + i) == streamEnd) {
      break;
    }
    PC++;
    textProgram.setScroll(lineMap.get(PC) - 5);
    textMessages.setScroll(lineMap.get(PC) - 5);
  }
}