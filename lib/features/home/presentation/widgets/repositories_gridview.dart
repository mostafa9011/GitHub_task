import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/routes/page_name.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';
import 'package:intl/intl.dart';

class RepositoriesGridview extends StatelessWidget {
  final List<RepositoryEntity> repositories;

  const RepositoriesGridview({super.key, required this.repositories});

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return DateFormat('MMM dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repository = repositories[index];
        return Bounceable(
          onTap: () {
            Navigator.pushNamed(
              context,
              PageName.repositoryDetailsScreen,
              arguments: repositories[index],
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: context.colorScheme.primary,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularImage(radius: 16, image: repository.owner.avatarUrl),
                SizedBox(height: 8.h),
                Text(
                  repository.name,
                  style: TextStyles.semiBold18W600(context).copyWith(
                    color: context.colorScheme.primary,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  repository.owner.username,
                  style: TextStyles.regular12W400(context).copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                // Stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${repository.stargazersCount}',
                      style: TextStyles.regular12W400(context),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Last updated
                Text(
                  formatDate(repository.updatedAt),
                  style: TextStyles.regular12W400(context).copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
