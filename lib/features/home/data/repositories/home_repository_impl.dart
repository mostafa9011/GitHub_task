import 'package:dartz/dartz.dart';
import 'package:github_task/core/errors/error_handler_service.dart';
import 'package:github_task/core/errors/failures.dart';
import 'package:github_task/features/home/data/datasources/home_datasource.dart';
import 'package:github_task/features/home/data/datasources/home_local_datasource.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:github_task/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImpl({
    required this.homeDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<List<RepositoryEntity>> getCachedRepositories() async {
    try {
      return await homeLocalDataSource.getRepositories();
    } catch (e) {
      return []; // Return empty list if cache fails
    }
  }

  @override
  Future<Either<Failure, List<RepositoryEntity>>> refreshRepositories() async {
    try {
      // Fetch fresh data from API
      final repositories = await homeDataSource.getRepositories();

      // Update the cache
      await homeLocalDataSource.saveRepositories(repositories);

      return Right(repositories);
    } catch (e) {
      // API call failed (offline or error)
      return Left(ErrorHandlerService().handle(e as Exception));
    }
  }

  @override
  Future<Either<Failure, List<RepositoryEntity>>> getRepositories() async {
    try {
      // Try to fetch from API first
      final repositories = await homeDataSource.getRepositories();

      // Cache the data to Hive
      await homeLocalDataSource.saveRepositories(repositories);

      return Right(repositories);
    } catch (e) {
      // If API call fails, try to load from cache
      try {
        final cachedRepositories = await homeLocalDataSource.getRepositories();

        if (cachedRepositories.isEmpty) {
          // No cached data available
          return Left(ErrorHandlerService().handle(e as Exception));
        }

        // Return cached data with a special indicator
        return Right(cachedRepositories);
      } catch (cacheError) {
        // Both API and cache failed
        return Left(ErrorHandlerService().handle(e as Exception));
      }
    }
  }

  @override
  Future<void> saveSortingPreference(String sortType) async {
    await homeLocalDataSource.saveSortingPreference(sortType);
  }

  @override
  Future<String?> getSortingPreference() async {
    return await homeLocalDataSource.getSortingPreference();
  }
}
