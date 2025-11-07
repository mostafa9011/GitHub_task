import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/functions/custom_launch_url.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/core/utils/widgets/custom_app_bar.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final RepositoryEntity repository;

  const RepositoryDetailsScreen({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: repository.name,
        automaticallyImplyLeading: true,
        showThemeToggle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Owner section
            Row(
              children: [
                // Owner avatar image
                CircularImage(radius: 24, image: repository.owner.avatarUrl),
                const SizedBox(width: 12),

                // Owner name text
                Text(
                  repository.owner.username,
                  style: TextStyles.medium16W500(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Repository name
            Text(
              repository.name,
              style: TextStyles.bold16W700(context).copyWith(
                color: context.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            // Description section
            Text(
              repository.description ?? "No description available.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            // Stats row
            Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, size: 20),
                    const SizedBox(width: 6),
                    Text("${repository.stargazersCount} Stars"),
                  ],
                ),
                const SizedBox(width: 24),
                Row(
                  children: [
                    const Icon(Icons.fork_right, size: 20),
                    const SizedBox(width: 6),
                    Text("${repository.forksCount} Forks"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Language
            Row(
              children: [
                const Icon(Icons.code, size: 20),
                const SizedBox(width: 6),
                Text(repository.language),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  customLaunchUrl(url: repository.htmlUrl);
                },
                child: const Text("Open in GitHub"),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
