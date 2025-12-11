abstract class EndPoints {
  static const String baseUrl = "https://api.github.com";

  static String repositories() {
    return "/search/repositories?q=Flutter&sort=stars&order=desc&per_page=50";
  }
}
