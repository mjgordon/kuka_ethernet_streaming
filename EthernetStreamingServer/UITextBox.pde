
public void setupTextBoxes() {
  font = loadFont("Consolas-12.vlw");
  textFont(font);

  textStatus = new TextBox(
    gutter, gutter, 
    width-(gutter * 3 + 60), 60);
  textProgram = new TextBox(
    gutter, gutter * 2 + 60, 
    (width - (gutter * 3)) / 2, height - (gutter * 3 + 60));
  textMessages = new TextBox(
    (width / 2) + (gutter / 2), gutter * 2 + 60, 
    (width - (gutter * 3)) / 2, height - (gutter * 3 + 60));

  setStatusText();
}

public void setStatusText() {
  textStatus.clear();
  textStatus.add("KUKA KRL PROGRAM STREAMING VIA ETHERNET - 2018 MATT GORDON");
  textStatus.add(String.format("File is %d lines long, contains %d streamable commands", lines.size(), messages.size()));
  println(messages.size());
  textStatus.add( "Currently supported commands are LIN, PTP, TOOL_COMMAND, HALT, WAIT");
}

public class TextBox {
  private int x;
  private int y;
  private int w;
  private int h;

  private ArrayList<String> lines;

  private int scroll = 0;

  private PGraphics g;

  public TextBox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    lines = new ArrayList<String>();

    g = createGraphics(w, h);
    
  }

  public void add(String s) {
    lines.add(s);
  }

  public void clear() {
    lines = new ArrayList<String>();
  }

  public boolean pick(int x, int y) {
    return(x >= this.x && y >= this.y && x <= (this.x + this.w) && y <= (this.y + this.h));
  }

  public void drawTextBox(boolean program) {
    g.beginDraw();
    g.textFont(font);
    g.background(20);

    if (program) {
      g.fill(100, 0, 0);
      int offset = 0;
      if (lineMap.containsKey(PC)) {
        offset = lineMap.get(PC);
      }
      g.rect(0, (offset - scroll) * 12 + 1, w, 14);
    }

    for (int i = 0; i < lines.size(); i++) {
      g.fill(255);
      if (program && (i <= streamStart || i >= streamEnd)) {
        g.fill(100);
      }
      String front = "      ";
      if (program) {
        int mapValue = -1;
        if (pcMap.containsKey(i)) {
          mapValue = pcMap.get(i);
          front = String.format("%05d", mapValue) + " ";
        }
      }
      g.text(front + lines.get(i), 6, (i - scroll) * 12 + 12);
    }

    g.endDraw();
    image(g, x, y);
  }

  public void setScroll(int n) {
    scroll = n;
    if (scroll < 0) {
      scroll = 0;
    } else if (scroll > (lines.size() - (h / 12))) {
      scroll = lines.size() - (h / 12);
    }
  }

  public void scroll(int d) {
    setScroll(scroll + d);
  }
}