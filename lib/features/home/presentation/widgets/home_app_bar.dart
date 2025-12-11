import 'package:flutter/material.dart';
import 'package:github_task/core/config/config_cubit/config_cubit.dart';

AppBar homeAppBar({required BuildContext context}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text('Flutter Repositories'),
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
