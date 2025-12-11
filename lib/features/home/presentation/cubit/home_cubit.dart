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
    // Load cached data immediately (no loading state for instant display)
    final cachedRepositories = await homeRepository.getCachedRepositories();

    if (cachedRepositories.isNotEmpty) {
      // Show cached data instantly
      repositories = cachedRepositories;

      // Load and apply saved sorting preference
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
          _applySorting(filterToApply, repositories);
        }
      }

      // Emit state with cached data (mark as potentially offline for now)
      emit(HomeSuccess(repositories: repositories));
    } else {
      // No cached data, show loading
      emit(HomeLoading());
    }

    // Try to refresh from API in background
    final hasConnection = await checkConnectivity();

    if (hasConnection) {
      // Online: fetch fresh data
      final result = await homeRepository.refreshRepositories();
      result.fold(
        (failure) {
          // API failed but we already have cached data showing
          // Don't emit error, just keep showing cached data
          if (cachedRepositories.isEmpty) {
            emit(HomeFailure(errorMessage: failure.message));
          }
        },
        (freshRepositories) {
          // Got fresh data from API
          repositories = freshRepositories;

          // Apply saved sorting if exists
          if (currentFilter != null) {
            _applySorting(currentFilter!, repositories);
          }

          // Update UI with fresh data
          isOffline = false;
          emit(HomeSuccess(repositories: repositories));
        },
      );
    } else {
      // Offline: mark as offline if we have cached data
      if (cachedRepositories.isNotEmpty) {
        isOffline = true;
        emit(HomeOfflineLoaded(repositories: repositories));
      } else {
        // No cache and offline
        emit(HomeFailure(
            errorMessage:
                'No internet connection and no cached data available'));
      }
    }
  }

  /// Manual refresh for pull-to-refresh
  Future<void> refreshRepositoriesManually() async {
    // Check connectivity first
    final hasConnection = await checkConnectivity();

    if (hasConnection) {
      // Online: try to fetch fresh data
      final result = await homeRepository.refreshRepositories();
      result.fold(
        (failure) {
          // API failed - just keep current state, no error
          // RefreshIndicator will complete
        },
        (freshRepositories) {
          // Got fresh data from API
          repositories = freshRepositories;

          // Apply current sorting if exists
          if (currentFilter != null) {
            _applySorting(currentFilter!, repositories);
          }

          // Update UI with fresh data
          isOffline = false;
          emit(HomeSuccess(repositories: repositories));
        },
      );
    } else {
      // Offline: just keep current cached data showing
      isOffline = true;
      if (repositories.isNotEmpty) {
        emit(HomeOfflineLoaded(repositories: repositories));
      }
      // RefreshIndicator will complete without changes
    }
  }

  /// Apply sorting without saving preference
  void _applySorting(FilterEnum filter, List<RepositoryEntity> repos) {
    if (filter == FilterEnum.name) {
      repos.sort((a, b) => a.name.compareTo(b.name));
    } else if (filter == FilterEnum.date) {
      repos.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } else if (filter == FilterEnum.stars) {
      repos.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
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
