import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';
import 'package:github_task/features/home/presentation/widgets/custom_repositories.dart';
import 'package:github_task/features/home/presentation/widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  final GithubUserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: homeAppBar(context: context, user: user),

      // body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),

            // repositories list
            const CustomRepositories(),
          ],
        ),
      ),
    );
  }
}
