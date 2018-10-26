public String substring2(String in, int begin, int end) {
  if (in.length() < end) return("");
  else return(in.substring(begin, end));
}