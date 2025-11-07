import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_builder.dart';
import 'package:github_task/features/home/presentation/widgets/sort_popup.dart';

class CustomRepositories extends StatelessWidget {
  const CustomRepositories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Your Repositories List',
                style: TextStyles.bold16W700(context)
                    .copyWith(color: context.colorScheme.onSurface),
              ),
              const Spacer(),

              // sort button
              const SortPopup(),

              // icon button to switch between grid and list view
              IconButton(
                onPressed: () {
                  context.read<HomeCubit>().toggleGrid();
                },
                icon: context.select<HomeCubit, bool>(
                  (cubit) => cubit.isGrid,
                )
                    ? const Icon(Icons.view_list)
                    : const Icon(Icons.grid_view), // Icons.view_list
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // repositories
          const RepositoriesBuilder(),
        ],
      ),
    );
  }
}
