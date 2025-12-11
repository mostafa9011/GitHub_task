import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories();
}
