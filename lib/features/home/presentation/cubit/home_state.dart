part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<RepositoryEntity> repositories;

  HomeSuccess({required this.repositories});
}

class HomeOfflineLoaded extends HomeState {
  final List<RepositoryEntity> repositories;

  HomeOfflineLoaded({required this.repositories});
}

class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({required this.errorMessage});
}

class HomeGridToggled extends HomeState {
  final bool isGrid;

  HomeGridToggled({required this.isGrid});
}
