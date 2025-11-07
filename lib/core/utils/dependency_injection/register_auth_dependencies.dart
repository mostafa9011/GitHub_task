import 'package:github_task/core/api/dio_consumer.dart';
import 'package:github_task/core/utils/dependency_injection/di.dart';
import 'package:github_task/features/auth/data/datasources/auth_data_source.dart';
import 'package:github_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:github_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:github_task/features/auth/presentation/cubit/auth_cubit.dart';

void registerAuthDependencies() {
  // Register auth data source
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(dioConsumer: getIt<DioConsumer>()),
  );

  // Register auth repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: getIt<AuthDataSource>()),
  );

  // Register auth cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );
}
