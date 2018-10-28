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

ArrayList<String> lines = new ArrayList<String>();

private final String startString = ";STREAM_START";
private final String endString = ";STREAM_END";

Pattern curlyBracePattern = Pattern.compile("\\{(.*?)\\}");
Pattern parenPattern = Pattern.compile("\\((.*?)\\)");
Pattern E6POSPattern = Pattern.compile("E6POS: ");
Pattern E6AXISPattern = Pattern.compile("E6AXIS: ");

ArrayList<ByteBuffer> messages = new ArrayList<ByteBuffer>();

private final int gutter = 12;

TextBox textStatus;
TextBox textProgram;
TextBox textMessages;

Button resetButton;

private int messageSize = 28;

int streamStart = 0;
int streamEnd = 0;

int PC = 0;

PFont font;

HashMap<Integer,Integer> pcMap = new HashMap<Integer,Integer>();
HashMap<Integer,Integer> lineMap = new HashMap<Integer,Integer>();

public void setup() {
  size(1600,900);
  drop = new SDrop(this);
  setupTextBoxes();
  resetButton = new Button("RESET", width - (60 + gutter), gutter, 60, 60);
  setupServer();
}

public void draw() {
  background(0);

  updateServer();
  textStatus.drawTextBox(false);
  textProgram.drawTextBox(true);
  textMessages.drawTextBox(true);
  resetButton.drawButton();
}

public void mousePressed() {
  resetButton.pick(mouseX, mouseY);
}

public void mouseWheel(MouseEvent event) {
  int d = event.getCount();
  textProgram.scroll(d);
  textMessages.scroll(d);
}