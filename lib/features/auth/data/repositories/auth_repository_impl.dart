import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/error_handler_service.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/auth/data/datasources/auth_data_source.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';
import 'package:github_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, GithubUserEntity>> loginWithGithubUsername(
      {required String username}) async {
    try {
      final user = await authDataSource.loginWithGithubUser(username: username);
      return Right(user);
    } catch (e) {
      return Left(ErrorHandlerService().handle(e as Exception));
    }
  }
}
