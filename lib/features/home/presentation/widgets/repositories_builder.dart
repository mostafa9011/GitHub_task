import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
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
              if (isOffline)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cloud_off,
                          color: Colors.orange.shade800, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You are offline. Showing cached data.',
                          style: TextStyle(
                            color: Colors.orange.shade900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Repositories list/grid
              Expanded(
                child: Skeletonizer(
                  enabled: state is HomeLoading,
                  child: PageTransitionSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder: (child, animation, secondaryAnimation) {
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
            ],
          ),
        );
      },
    );
  }
}
