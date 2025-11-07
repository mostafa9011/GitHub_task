abstract class GithubUserEntity {
  final int id;
  final String username;
  final String? name;
  final String avatarUrl;
  final String? bio;
  final int publicRepos;
  final int followers;
  final int following;

  const GithubUserEntity({
    required this.id,
    required this.username,
    this.name,
    required this.avatarUrl,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });
}
