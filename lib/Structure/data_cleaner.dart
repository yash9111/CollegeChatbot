String data_cleaner(String paragraph) {
  // Define a list of common delimiters
  

  if (containsKeywords(
      paragraph, ["context information", "not mentioned "])) {
    return "Sorry i can not answer this question !";
  }

  return paragraph;
}

bool containsKeywords(String paragraph, List<String> keywords) {
  for (String keyword in keywords) {
    if (paragraph.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
  }
  return false;
}
