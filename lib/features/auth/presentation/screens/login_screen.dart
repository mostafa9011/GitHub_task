import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/utils/dependency_injection/di.dart';
import 'package:github_task/core/utils/widgets/custom_app_bar.dart';
import 'package:github_task/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:github_task/features/auth/presentation/widgets/login_form.dart';

import '../../../../core/config/themes/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        // custom app bar
        appBar: customAppBar(context: context, title: 'Login'),

        // body
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // header
                SizedBox(height: 0.15.sh),
                Text(
                  'Login with your Github Account',
                  style: TextStyles.bold16W700(context),
                ),
                SizedBox(height: 16.h),

                // login form
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
