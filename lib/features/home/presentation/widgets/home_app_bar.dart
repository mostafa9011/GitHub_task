import 'package:flutter/material.dart';
import 'package:github_task/core/config/config_cubit/config_cubit.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';

AppBar homeAppBar({required BuildContext context}) {
  return AppBar(
    // profile image and name
    leading: const CircularImage(radius: 24, image: ''),

    // profile name
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          const Text('User Name'),
          const SizedBox(height: 4),
          // bio
          Text(
            'Bio',
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
