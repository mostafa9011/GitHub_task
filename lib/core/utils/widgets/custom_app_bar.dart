import 'package:flutter/material.dart';
import 'package:github_task/core/config/config_cubit/config_cubit.dart';
import 'package:github_task/core/config/themes/app_theme.dart';

AppBar customAppBar({
  required BuildContext context,
  required String title,
  bool centerTitle = true,
  bool automaticallyImplyLeading = false,
  bool showThemeToggle = true,
}) {
  return AppBar(
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(
      title,
      style: TextStyles.bold16W700(context),
    ),
    actions: [
      // toggle theme button
      if (showThemeToggle) ...[
        IconButton(
          onPressed: () {
            ConfigCubit.of(context).toggleTheme();
          },
          icon: const Icon(Icons.brightness_6),
        ),
      ],
    ],
  );
}
