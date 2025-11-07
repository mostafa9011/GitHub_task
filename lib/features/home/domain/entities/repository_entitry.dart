class RepositoryEntity {
  final int id;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String? description;
  final String defaultBranch;
  final int stargazersCount;
  final int forksCount;
  final String language;
  final OwnerEntity owner;
  final DateTime updatedAt;

  const RepositoryEntity({
    required this.id,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.defaultBranch,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.owner,
    required this.updatedAt,
  });
}

class OwnerEntity {
  final int id;
  final String username;
  final String avatarUrl;
  final String htmlUrl;

  const OwnerEntity({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.htmlUrl,
  });
}
