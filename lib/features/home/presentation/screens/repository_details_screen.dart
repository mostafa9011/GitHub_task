import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/functions/custom_launch_url.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/core/utils/widgets/custom_app_bar.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final String name;
  final String? description;
  final int stars;
  final int forks;
  final String? language;
  final String url;

  // New owner parameters
  final String ownerName;
  final String ownerAvatarUrl;

  const RepositoryDetailsScreen({
    super.key,
    this.name = "Repository Name",
    this.description = "Repository Description",
    this.stars = 4,
    this.forks = 3,
    this.language = 'Dart',
    this.url = 'https://github.com',
    this.ownerName = 'Owner Name',
    this.ownerAvatarUrl = 'https://via.placeholder.com/150',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: name,
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
                const CircularImage(radius: 24, image: ''),
                const SizedBox(width: 12),

                // Owner name text
                Text(
                  ownerName,
                  style: TextStyles.medium16W500(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Repository name
            Text(
              name,
              style: TextStyles.bold16W700(context).copyWith(
                color: context.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            // Description section
            Text(
              description ?? "No description available.",
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
                    Text("$stars Stars"),
                  ],
                ),
                const SizedBox(width: 24),
                Row(
                  children: [
                    const Icon(Icons.fork_right, size: 20),
                    const SizedBox(width: 6),
                    Text("$forks Forks"),
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
                Text(language ?? ""),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  customLaunchUrl(url: url);
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
