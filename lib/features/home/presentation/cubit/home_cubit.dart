import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:github_task/features/home/domain/repositories/home_repository.dart';
import 'package:github_task/features/home/presentation/enums/filter_enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(HomeInitial());

  final HomeRepository homeRepository;
  bool isGrid = true;

  Future<void> getRepositories({
    required String username,
    FilterEnum? filter,
  }) async {
    emit(HomeLoading());

    final result = await homeRepository.getRepositories(username: username);
    result.fold(
      (failure) => emit(HomeFailure(errorMessage: failure.message)),
      (repositories) {
        this.repositories = repositories;
        emit(HomeSuccess(repositories: repositories));
      },
    );
  }

  void toggleGrid() {
    isGrid = !isGrid;
    emit(HomeGridToggled(isGrid: isGrid));
  }

  // dummy list of repositories for loading state with skeletonizer package
  List<RepositoryEntity> repositories = List.generate(
    5,
    (index) => RepositoryEntity(
      id: index,
      name: 'Repositoryyyy $index',
      description: 'Description of repository $index',
      fullName: 'User/Repository$index',
      htmlUrl: 'https://github.com/User/Repository$index',
      owner: OwnerEntity(
        id: index,
        username: "User$index",
        avatarUrl: 'https://via.placeholder.com/150',
        htmlUrl: 'https://github.com/User$index',
      ),
      defaultBranch: 'main',
      forksCount: index,
      stargazersCount: index * 10,
      language: 'Language $index',
      updatedAt: DateTime.now(),
    ),
  );

  // sort repositories
  void sortRepositories({required FilterEnum filter}) {
    if (filter == FilterEnum.name) {
      repositories.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter == FilterEnum.date) {
      repositories.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    } else if (filter == FilterEnum.stars) {
      repositories
          .sort((a, b) => a.stargazersCount.compareTo(b.stargazersCount));
    }
    emit(HomeSuccess(repositories: repositories));
  }
}
