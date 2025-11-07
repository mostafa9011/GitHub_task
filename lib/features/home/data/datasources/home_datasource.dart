import 'package:github_task/core/api/dio_consumer.dart';
import 'package:github_task/core/api/end_points.dart';
import 'package:github_task/features/home/data/models/repository_model.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

abstract class HomeDataSource {
  Future<List<RepositoryEntity>> getRepositories({required String username});
}

class HomeDataSourceImpl implements HomeDataSource {
  final DioConsumer dioConsumer;

  HomeDataSourceImpl({required this.dioConsumer});

  @override
  Future<List<RepositoryEntity>> getRepositories({
    required String username,
  }) async {
    final response =
        await dioConsumer.get(path: EndPoints.repositories(username: username));

    final List<RepositoryEntity> repositories = (response as List)
        .map((repoJson) => RepositoryModel.fromJson(repoJson))
        .toList();

    return repositories;
  }
}
