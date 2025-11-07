import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/error_handler_service.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/home/data/datasources/home_datasource.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:github_task/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;
  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories({
    required String username,
  }) async {
    try {
      final repositories =
          await homeDataSource.getRepositories(username: username);
      return Right(repositories);
    } catch (e) {
      return Left(ErrorHandlerService().handle(e as Exception));
    }
  }
}
