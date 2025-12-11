import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:hive/hive.dart';

part 'repository_model.g.dart';

@HiveType(typeId: 0)
class RepositoryModel extends RepositoryEntity {
  @HiveField(0)
  final int hiveId;
  @HiveField(1)
  final String hiveName;
  @HiveField(2)
  final String hiveFullName;
  @HiveField(3)
  final String hiveHtmlUrl;
  @HiveField(4)
  final String? hiveDescription;
  @HiveField(5)
  final String hiveDefaultBranch;
  @HiveField(6)
  final int hiveStargazersCount;
  @HiveField(7)
  final int hiveForksCount;
  @HiveField(8)
  final int hiveOpenIssuesCount;
  @HiveField(9)
  final String hiveLanguage;
  @HiveField(10)
  final OwnerModel hiveOwner;
  @HiveField(11)
  final DateTime hiveUpdatedAt;

  RepositoryModel({
    required this.hiveId,
    required this.hiveName,
    required this.hiveFullName,
    required this.hiveHtmlUrl,
    required this.hiveDescription,
    required this.hiveDefaultBranch,
    required this.hiveStargazersCount,
    required this.hiveForksCount,
    required this.hiveOpenIssuesCount,
    required this.hiveLanguage,
    required this.hiveOwner,
    required this.hiveUpdatedAt,
  }) : super(
          id: hiveId,
          name: hiveName,
          fullName: hiveFullName,
          htmlUrl: hiveHtmlUrl,
          description: hiveDescription,
          defaultBranch: hiveDefaultBranch,
          stargazersCount: hiveStargazersCount,
          forksCount: hiveForksCount,
          openIssuesCount: hiveOpenIssuesCount,
          language: hiveLanguage,
          owner: hiveOwner,
          updatedAt: hiveUpdatedAt,
        );

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      hiveId: json['id'],
      hiveName: json['name'],
      hiveFullName: json['full_name'],
      hiveHtmlUrl: json['html_url'],
      hiveDescription: json['description'],
      hiveDefaultBranch: json['default_branch'],
      hiveStargazersCount: json['stargazers_count'],
      hiveForksCount: json['forks_count'],
      hiveOpenIssuesCount: json['open_issues_count'] ?? 0,
      hiveLanguage: json['language'] ?? 'Unknown',
      hiveOwner: OwnerModel.fromJson(json['owner']),
      hiveUpdatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': hiveId,
      'name': hiveName,
      'full_name': hiveFullName,
      'html_url': hiveHtmlUrl,
      'description': hiveDescription,
      'default_branch': hiveDefaultBranch,
      'stargazers_count': hiveStargazersCount,
      'forks_count': hiveForksCount,
      'open_issues_count': hiveOpenIssuesCount,
      'language': hiveLanguage,
      'owner': hiveOwner.toJson(),
      'updated_at': hiveUpdatedAt.toIso8601String(),
    };
  }
}

@HiveType(typeId: 1)
class OwnerModel extends OwnerEntity {
  @HiveField(0)
  final int hiveId;
  @HiveField(1)
  final String hiveUsername;
  @HiveField(2)
  final String hiveAvatarUrl;
  @HiveField(3)
  final String hiveHtmlUrl;

  OwnerModel({
    required this.hiveId,
    required this.hiveUsername,
    required this.hiveAvatarUrl,
    required this.hiveHtmlUrl,
  }) : super(
          id: hiveId,
          username: hiveUsername,
          avatarUrl: hiveAvatarUrl,
          htmlUrl: hiveHtmlUrl,
        );

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      hiveId: json['id'],
      hiveUsername: json['login'],
      hiveAvatarUrl: json['avatar_url'],
      hiveHtmlUrl: json['html_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': hiveId,
      'login': hiveUsername,
      'avatar_url': hiveAvatarUrl,
      'html_url': hiveHtmlUrl,
    };
  }
}
