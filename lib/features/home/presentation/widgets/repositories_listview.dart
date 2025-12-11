import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:github_task/core/config/routes/page_name.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/functions/formate_date.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

class RepositoriesListview extends StatelessWidget {
  final List<RepositoryEntity> repositories;

  const RepositoriesListview({super.key, required this.repositories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repo = repositories[index];
        return Bounceable(
          onTap: () {
            Navigator.pushNamed(
              context,
              PageName.repositoryDetailsScreen,
              arguments: repo,
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.primary, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Repository name
                Row(
                  children: [
                    const Icon(Icons.book, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        repo.name,
                        style: TextStyles.bold16W700(context)
                            .copyWith(color: context.colorScheme.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Owner info
                Row(
                  children: [
                    CircularImage(
                      radius: 12,
                      image: repo.owner.avatarUrl,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      repo.owner.username,
                      style: TextStyles.regular14W400(context).copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Stars and last updated
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${repo.stargazersCount}',
                      style: TextStyles.regular14W400(context),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formatDate(repo.updatedAt),
                      style: TextStyles.regular14W400(context).copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
