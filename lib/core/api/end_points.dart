abstract class EndPoints {
  static const String baseUrl = "https://api.github.com";

  static String loginWithGithubUser({required String username}) {
    return "$baseUrl/users/$username";
  }
}
