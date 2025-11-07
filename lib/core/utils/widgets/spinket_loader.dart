import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinketLoader extends StatelessWidget {
  const SpinketLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0.sp,
        height: 24.0.sp,
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.surface,
          size: 24.0.sp,
        ),
      ),
    );
  }
}
