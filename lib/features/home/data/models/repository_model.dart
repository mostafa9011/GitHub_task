import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.htmlUrl,
    required super.description,
    required super.defaultBranch,
    required super.stargazersCount,
    required super.forksCount,
    required super.language,
    required super.owner,
    required super.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      htmlUrl: json['html_url'],
      description: json['description'],
      defaultBranch: json['default_branch'],
      stargazersCount: json['stargazers_count'],
      forksCount: json['forks_count'],
      language: json['language'] ?? 'Unknown',
      owner: OwnerModel.fromJson(json['owner']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class OwnerModel extends OwnerEntity {
  OwnerModel({
    required super.id,
    required super.username,
    required super.avatarUrl,
    required super.htmlUrl,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'],
      username: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
    );
  }
}
