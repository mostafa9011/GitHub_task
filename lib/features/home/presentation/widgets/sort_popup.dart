import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:github_task/features/home/presentation/enums/filter_enum.dart';

class SortPopup extends StatelessWidget {
  const SortPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: (value) {
        if (value == "name") {
          // Sort by name
          homeCubit.sortRepositories(filter: FilterEnum.name);
        } else if (value == "stars") {
          // Sort by stars
          homeCubit.sortRepositories(filter: FilterEnum.stars);
        } else if (value == "date") {
          // Sort by last updated date
          homeCubit.sortRepositories(filter: FilterEnum.date);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "name",
          child: Text("Sort by Name"),
        ),
        const PopupMenuItem(
          value: "stars",
          child: Text("Sort by Stars"),
        ),
        const PopupMenuItem(
          value: "date",
          child: Text("Sort by Last Updated"),
        ),
      ],
    );
  }
}
