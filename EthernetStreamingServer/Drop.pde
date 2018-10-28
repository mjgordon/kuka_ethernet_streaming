void dropEvent(DropEvent theDropEvent) {
  if (theDropEvent.isFile()) {
      File file = theDropEvent.file();
      Path path = file.toPath();
      try {
        lines = new ArrayList<String>(Files.readAllLines(path));
        parse();
        setStatusText();
      }
      catch(Exception e) {
        println(e);
      }   
  }
}