public void buttonAction(String name) {
  if (name.equals("RESET")) {
    PC = 0;
  }
}

private class Button {
  private String name;

  private int x;
  private int y;
  private int w;
  private int h;

  boolean pressed = false;

  public Button(String name, int x, int y, int w, int h) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void drawButton() {
    fill(pressed ? 100 : 20);
    noStroke();
    rect(x, y, w, h);
    fill(255);
    text(name, x + 12, y + 30);
  }

  public void pick(int x, int y) {
    if (x >= this.x && y >= this.y && x <= this.x + w && y <=this.y + h) {
      buttonAction(name);
    }
  }
}