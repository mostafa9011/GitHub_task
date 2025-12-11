import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:github_task/features/home/domain/repositories/home_repository.dart';
import 'package:github_task/features/home/presentation/enums/filter_enum.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(HomeInitial());

  final HomeRepository homeRepository;
  bool isGrid = true;
  bool isOffline = false;
  FilterEnum? currentFilter;

  Future<void> getRepositories({
    FilterEnum? filter,
  }) async {
    emit(HomeLoading());

    final result = await homeRepository.getRepositories();
    result.fold(
      (failure) => emit(HomeFailure(errorMessage: failure.message)),
      (repositories) {
        this.repositories = repositories;

        // Check if we're loading from cache (offline mode)
        // This is a simple heuristic - you might need a better way to detect this
        checkConnectivity().then((hasConnection) {
          isOffline = !hasConnection;

          // Load saved sorting preference and apply it
          _loadAndApplySorting(repositories);
        });
      },
    );
  }

  Future<void> _loadAndApplySorting(List<RepositoryEntity> repos) async {
    final savedSort = await homeRepository.getSortingPreference();

    if (savedSort != null) {
      FilterEnum? filterToApply;
      if (savedSort == 'stars') {
        filterToApply = FilterEnum.stars;
      } else if (savedSort == 'date') {
        filterToApply = FilterEnum.date;
      } else if (savedSort == 'name') {
        filterToApply = FilterEnum.name;
      }

      if (filterToApply != null) {
        currentFilter = filterToApply;
        sortRepositories(filter: filterToApply, savePreference: false);
        return;
      }
    }

    // No saved preference, just emit the repositories
    if (isOffline) {
      emit(HomeOfflineLoaded(repositories: repos));
    } else {
      emit(HomeSuccess(repositories: repos));
    }
  }

  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('api.github.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
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
      openIssuesCount: index,
      language: 'Language $index',
      updatedAt: DateTime.now(),
    ),
  );

  // sort repositories with descending order and save preference
  void sortRepositories({
    required FilterEnum filter,
    bool savePreference = true,
  }) {
    currentFilter = filter;

    if (filter == FilterEnum.name) {
      repositories.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter == FilterEnum.date) {
      // Sort by most recent first (descending)
      repositories.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } else if (filter == FilterEnum.stars) {
      // Sort by most stars first (descending)
      repositories
          .sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
    }

    // Save the sorting preference if requested
    if (savePreference) {
      String sortType = '';
      if (filter == FilterEnum.stars) {
        sortType = 'stars';
      } else if (filter == FilterEnum.date) {
        sortType = 'date';
      } else if (filter == FilterEnum.name) {
        sortType = 'name';
      }
      homeRepository.saveSortingPreference(sortType);
    }

    // Emit appropriate state based on offline status
    if (isOffline) {
      emit(HomeOfflineLoaded(repositories: repositories));
    } else {
      emit(HomeSuccess(repositories: repositories));
    }
  }
}
