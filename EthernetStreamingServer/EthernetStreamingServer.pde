

import java.util.ArrayList;
import java.util.Arrays;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.*;

import drop.*;
import test.*;

import processing.net.*;

SDrop drop;

int fileLength = 0;
ArrayList<String> lines = new ArrayList<String>();

private final String startString = ";STREAM_START";
private final String endString = ";STREAM_END";

Pattern curlyBracePattern = Pattern.compile("\\{([^}]+)\\}");
Pattern E6POSPattern = Pattern.compile("{E6POS:");

ArrayList<ByteBuffer> messages = new ArrayList<ByteBuffer>();

TextBox textStatus;
TextBox textProgram;
TextBox textMessages;

byte CMD_LIN = 0;
byte CMD_PTP = 1;
byte CMD_TOOL_COMMAND = 2;
byte CMD_HALT = 3;
byte CMD_WAIT = 4;

private final int gutter = 12;

int streamStart = 0;
int streamEnd = 0;

public void setup() {
  size(1280,800);
  drop = new SDrop(this);
  setupTextBoxes();
}

public void draw() {
  background(0);
  
  textStatus.drawTextBox(false);
  textProgram.drawTextBox(true);
  textMessages.drawTextBox(true);

}


public void mouseWheel(MouseEvent event) {
   int d = event.getCount();
   textProgram.scroll(d);
   textMessages.scroll(d);
}