import 'package:flutter/material.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';

class FailureComponent extends StatelessWidget {
  final String errorMessage;
  final Future<void> Function() onRefresh;

  const FailureComponent(
      {super.key, required this.errorMessage, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // error message
        Text(
          errorMessage,
          style: TextStyles.medium16W500(context).copyWith(
            color: context.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(),

        // retry button
        ElevatedButton(
          onPressed: onRefresh,
          child: Text(
            'Retry',
            style: TextStyles.semiBold18W600(context).copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
