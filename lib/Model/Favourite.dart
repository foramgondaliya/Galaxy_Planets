class favourite {
  static Set<Map<String, dynamic>> favData = {};
  static List<Map<String, dynamic>> favGitaData = [];

  static void convertUniqueData() {
    favGitaData = favData.toList();
  }
}
