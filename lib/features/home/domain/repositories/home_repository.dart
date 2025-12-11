import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

abstract class HomeRepository {
  /// Get cached repositories from Hive (instant)
  Future<List<RepositoryEntity>> getCachedRepositories();

  /// Refresh repositories from API and update cache
  Future<Either<Failure, List<RepositoryEntity>>> refreshRepositories();

  /// Legacy method - kept for compatibility
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories();

  Future<void> saveSortingPreference(String sortType);
  Future<String?> getSortingPreference();
}
