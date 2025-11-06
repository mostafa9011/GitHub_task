import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/features/auth/presentation/widgets/login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // username text field
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            hintText: 'Github Username',
          ),
        ),
        SizedBox(height: 24.h),

        // login button
        const LoginButton(),
      ],
    );
  }
}
