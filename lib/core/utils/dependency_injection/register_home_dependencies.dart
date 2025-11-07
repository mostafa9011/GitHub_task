import 'package:github_task/core/api/dio_consumer.dart';
import 'package:github_task/core/utils/dependency_injection/di.dart';
import 'package:github_task/features/home/data/datasources/home_datasource.dart';
import 'package:github_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:github_task/features/home/domain/repositories/home_repository.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';

void registerHomeDependencies() {
  // Register home data source
  getIt.registerLazySingleton<HomeDataSource>(
      () => HomeDataSourceImpl(dioConsumer: getIt<DioConsumer>()));

  // Register home repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDataSource: getIt<HomeDataSource>()),
  );

  // Register home cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<HomeRepository>()),
  );
}
