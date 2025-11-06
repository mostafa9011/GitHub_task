import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle login action
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 8,
        ).r,
        backgroundColor: context.colorScheme.primary,
      ),
      child: Text(
        'Login',
        style: TextStyles.bold16W700(context).copyWith(color: Colors.white),
      ),
    );
  }
}
