import '../../extensions/context_extension.dart';

import '../../config/app_assets.dart';
import '../../utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryImage extends StatelessWidget {
  /// Image path or URL
  final String path;

  /// Width of the image
  final double? width;

  /// Height of the image
  final double? height;

  /// How to inscribe the image into the space
  final BoxFit fit;

  /// Whether the image is from network or local asset
  final bool isNetwork;

  /// Placeholder widget while loading (only for network)
  final Widget? placeholder;

  /// Widget to display if loading fails
  final Widget? errorWidget;

  const PrimaryImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isNetwork = true,
    this.placeholder,
    this.errorWidget,
  });

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return isNetwork
          ? SvgPicture.network(
            path,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder:
                (context) =>
                    placeholder ??
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 2,
                      ),
                    ),
          )
          : SvgPicture.asset(path, width: width, height: height, fit: fit);
    } else {
      return isNetwork
          ? Image.network(
            path,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return placeholder ??
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 2,
                    ),
                  );
            },
            errorBuilder: (context, error, stackTrace) {
              return errorWidget ?? const Icon(Icons.error);
            },
          )
          : Image.asset(path, width: width, height: height, fit: fit);
    }
  }
}

class PrimaryNetworkImage extends StatelessWidget {
  const PrimaryNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.errorImage,
  });

  final String imageUrl;
  final String? errorImage;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,

      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage(imageUrl),
        errorBuilder: (context, error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              height: 80,
              width: 80,
              color: context.colorScheme.onSurface,
              errorImage ?? AppAssets.loaderIcon,
              // color: Colors.white,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}

class RoundedNetworkImage extends StatelessWidget {
  const RoundedNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius = 16,
    this.border = 0,
    this.borderColor = PRIMARY_SWATCH,
  });

  final String imageUrl;
  final double radius;
  final int border;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: borderColor,
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: (radius * 2) - (border * 4),
          height: (radius * 2) - (border * 4),
          errorBuilder: (context, error, stackTrace) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                AppAssets.loaderIcon,
                color: Colors.white,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
