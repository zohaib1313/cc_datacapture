void printWrapped(Object value) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(value.toString())
      .forEach((match) => print("***${match.group(0)}***"));
}
