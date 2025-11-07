import 'package:github_task/core/api/dio_consumer.dart';
import 'package:github_task/core/api/end_points.dart';
import 'package:github_task/features/auth/data/models/github_user_model.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';

abstract class AuthDataSource {
  Future<GithubUserEntity> loginWithGithubUser({required String username});
}

class AuthDataSourceImpl implements AuthDataSource {
  final DioConsumer dioConsumer;

  AuthDataSourceImpl({required this.dioConsumer});

  @override
  Future<GithubUserEntity> loginWithGithubUser(
      {required String username}) async {
    final response = await dioConsumer.get(
      path: EndPoints.loginWithGithubUser(username: username),
    );

    return GithubUserModel.fromJson(response);
  }
}
