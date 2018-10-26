void dropEvent(DropEvent theDropEvent) {
  if (theDropEvent.isFile()) {
      File file = theDropEvent.file();
      Path path = file.toPath();
      try {
        lines = new ArrayList<String>(Files.readAllLines(path));
        fileLength = lines.size();
        parse();
        setStatusText();
      }
      catch(Exception e) {
        println(e);
      }   
  }
}