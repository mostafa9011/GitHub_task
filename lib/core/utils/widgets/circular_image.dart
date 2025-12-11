import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../enums/image_type.dart';

class CircularImage extends StatelessWidget {
  final double radius;
  final String image;
  final ImageType imageType;
  const CircularImage({
    required this.radius,
    required this.image,
    super.key,
    this.imageType = ImageType.network,
  });

  @override
  Widget build(BuildContext context) {
    // if image is from assets
    if (imageType == ImageType.assets) {
      return Container(
        width: (radius * 2).r,
        height: (radius * 2).r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // if image is from svg
    else if (imageType == ImageType.svg) {
      return Container(
        width: (radius * 2).r,
        height: (radius * 2).r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SvgPicture.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // if image is from file
    else if (imageType == ImageType.file) {
      return Container(
        width: (radius * 2).r,
        height: (radius * 2).r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.file(
            File(image),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // if image is from network
    else {
      return Container(
        width: (radius * 2).r,
        height: (radius * 2).r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: image.trim(),
            fit: BoxFit.cover,
            // error widget
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
            placeholder: (context, url) =>
                const CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    }
  }
}
