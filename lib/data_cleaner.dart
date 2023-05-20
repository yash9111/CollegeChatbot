String data_cleaner(String paragraph) {
  List<String> points = paragraph.split(RegExp(r'(?<=[a-z])\. (?=[A-Z])'));

  // Trim any leading or trailing whitespaces from each point
  points = points.map((point) => point.trim()).toList();

  // Remove any empty points
  points.removeWhere((point) => point.isEmpty);

  String pointsString = points.join('\n');

  return pointsString;
}

void wordByword(String res) {
  List<String> text = res.split(' ');

  for (int i = 0; i < text.length; i++) {
    Future.delayed(Duration(seconds: i), () {
      print(text[i]);
    });

    // return result;
  }
}

void main() {
  wordByword("Hello my name is yash");
}
