import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_gridview.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_listview.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SuccessfulRepositories extends StatelessWidget {
  const SuccessfulRepositories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final repositories = state is HomeSuccess
            ? state.repositories
            : state is HomeOfflineLoaded
                ? state.repositories
                : cubit.repositories;

        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.refreshRepositoriesManually();
            },
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
        );
      },
    );
  }
}
