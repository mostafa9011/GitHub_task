import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_gridview.dart';
import 'package:github_task/features/home/presentation/widgets/repositories_listview.dart';
import 'package:github_task/features/home/presentation/widgets/sort_popup.dart';

class CustomRepositories extends StatefulWidget {
  const CustomRepositories({super.key});

  @override
  State<CustomRepositories> createState() => _CustomRepositoriesState();
}

class _CustomRepositoriesState extends State<CustomRepositories> {
  bool isGrid = false;

  List<Map<String, dynamic>> filteredRepos = List.generate(
    10,
    (index) => {
      "name": "Repository $index",
      "stargazers_count": index * 10,
    },
  );

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
                    .copyWith(color: context.colorScheme.primary),
              ),
              const Spacer(),

              // sort button
              const SortPopup(),

              // icon button to switch between grid and list view
              IconButton(
                onPressed: () {
                  setState(() {
                    isGrid = !isGrid;
                  });
                },
                icon: isGrid
                    ? const Icon(Icons.view_list)
                    : const Icon(Icons.grid_view), // Icons.view_list
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // repositories
          Expanded(
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
              child: isGrid
                  ? const RepositoriesGridview()
                  : const RepositoriesListview(),
            ),
          )
        ],
      ),
    );
  }
}
