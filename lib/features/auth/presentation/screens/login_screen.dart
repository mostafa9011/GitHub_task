import 'package:flutter/material.dart';

import '../../../../core/config/themes/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Login Screen',
          style: TextStyles.bold16W700(context),
        ),
      ),
    );
  }
}
