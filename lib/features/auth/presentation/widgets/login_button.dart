import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/routes/page_name.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/widgets/show_toast.dart';
import 'package:github_task/core/utils/widgets/spinket_loader.dart';
import 'package:github_task/features/auth/presentation/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;

  const LoginButton({
    super.key,
    required this.usernameController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // error state
        if (state is AuthFailure) {
          showToast(
            context: context,
            type: ToastType.error,
            message: state.message,
          );
        }
        // success state
        if (state is AuthSuccess) {
          showToast(
            context: context,
            type: ToastType.success,
            message: 'Login Successful',
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageName.homeScreen,
            (route) => false,
            arguments: state.githubUser, // pass the user entity
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            // Handle login action
            context.read<AuthCubit>().loginWithGithubUsername(
                  username: usernameController.text.trim(),
                );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 8,
            ).r,
            backgroundColor: context.colorScheme.primary,
            minimumSize: Size(double.infinity, 38.h),
          ),
          child: state is AuthLoading
              ? const SpinketLoader()
              : FittedBox(
                  child: Text(
                    'Login',
                    style: TextStyles.bold16W700(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
        );
      },
    );
  }
}
