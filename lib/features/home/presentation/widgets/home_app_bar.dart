import 'package:flutter/material.dart';
import 'package:github_task/core/config/config_cubit/config_cubit.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';

AppBar homeAppBar(
    {required BuildContext context, required GithubUserEntity user}) {
  return AppBar(
    // profile image and name
    leading: CircularImage(radius: 24, image: user.avatarUrl),

    // profile name
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          Text(
            user.name ?? 'No Name Available',
            style: TextStyles.bold16W700(context),
          ),
          const SizedBox(height: 4),
          // bio
          Text(
            user.bio ?? 'No bio available',
            style:
                TextStyles.regular14W400(context).copyWith(color: Colors.grey),
          ),
        ],
      ),
    ),
    centerTitle: false,

    actions: [
      // toggle theme button
      IconButton(
        onPressed: () {
          ConfigCubit.of(context).toggleTheme();
        },
        icon: const Icon(Icons.brightness_6),
      ),
    ],
  );
}
