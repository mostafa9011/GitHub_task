import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, GithubUserEntity>> loginWithGithubUsername({
    required String username,
  });
}
