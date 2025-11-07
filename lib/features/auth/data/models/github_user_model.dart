// lib/data/models/github_user_model.dart

import '../../domain/entities/github_user_entity.dart';

class GithubUserModel extends GithubUserEntity {
  // Extra fields from API (if needed later)
  final String nodeId;
  final String htmlUrl;
  final String? company;
  final String? blog;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  GithubUserModel({
    required super.id,
    required String login,
    super.name,
    required super.avatarUrl,
    super.bio,
    required super.publicRepos,
    required super.followers,
    required super.following,
    required this.nodeId,
    required this.htmlUrl,
    this.company,
    this.blog,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          username: login,
        );

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      id: json['id'],
      login: json['login'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      nodeId: json['node_id'],
      htmlUrl: json['html_url'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
