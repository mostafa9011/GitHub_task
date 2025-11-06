import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_task/core/config/themes/app_theme.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';

class RepositoriesGridview extends StatelessWidget {
  const RepositoriesGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Bounceable(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: context.colorScheme.primary,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularImage(radius: 16, image: 'image'),
                SizedBox(height: 8.h),
                Text(
                  'Repository $index',
                  style: TextStyles.semiBold18W600(context),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Description of repository $index',
                  style: TextStyles.regular12W400(context)
                      .copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
