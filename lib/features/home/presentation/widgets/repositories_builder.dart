import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:github_task/features/home/presentation/widgets/failure_component.dart';
import 'package:github_task/features/home/presentation/widgets/offline_banner.dart';
import 'package:github_task/features/home/presentation/widgets/successful_repositories.dart';

class RepositoriesBuilder extends StatelessWidget {
  const RepositoriesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // failure state
        if (state is HomeFailure) {
          return FailureComponent(
            errorMessage: state.errorMessage,
            onRefresh: () async {
              await cubit.getRepositories();
            },
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

        final bool isOffline = state is HomeOfflineLoaded;

        return Expanded(
          child: Column(
            children: [
              // Offline indicator banner
              if (isOffline) ...[
                const OfflineBanner(),
              ],

              // Repositories list/grid with RefreshIndicator
              const SuccessfulRepositories(),
            ],
          ),
        );
      },
    );
  }
}
