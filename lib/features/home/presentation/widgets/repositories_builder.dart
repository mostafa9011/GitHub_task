import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:github_task/features/home/presentation/widgets/offline_banner.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_gridview.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_listview.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RepositoriesBuilder extends StatelessWidget {
  const RepositoriesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // failure state
        if (state is HomeFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        // success state
        // empty state
        if ((state is HomeSuccess || state is HomeOfflineLoaded) &&
            (state is HomeSuccess
                ? state.repositories.isEmpty
                : (state as HomeOfflineLoaded).repositories.isEmpty)) {
          return const Center(
            child: Text('No repositories found.'),
          );
        }

        final repositories = state is HomeSuccess
            ? state.repositories
            : state is HomeOfflineLoaded
                ? state.repositories
                : context.read<HomeCubit>().repositories;

        final bool isOffline = state is HomeOfflineLoaded;

        return Expanded(
          child: Column(
            children: [
              // Offline indicator banner
              if (isOffline) ...[
                const OfflineBanner(),
              ],

              // Repositories list/grid with RefreshIndicator
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context
                        .read<HomeCubit>()
                        .refreshRepositoriesManually();
                  },
                  child: Skeletonizer(
                    enabled: state is HomeLoading,
                    child: PageTransitionSwitcher(
                      duration: const Duration(seconds: 1),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.scaled,
                          child: child,
                        );
                      },
                      child: context.select<HomeCubit, bool>(
                        (cubit) => cubit.isGrid,
                      )
                          ? RepositoriesGridview(repositories: repositories)
                          : RepositoriesListview(repositories: repositories),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
