import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/assets.dart';

/// Widget that is used as a `FadeInImage.assetNetwork` template.
class FadeInNetworkImage extends StatelessWidget {
  /// Constructs a `FadeInNetworkImage`.
  const FadeInNetworkImage({
    required this.url,
    this.height = 210,
    Key? key,
  }) : super(key: key);

  /// Url of the image.
  final String url;

  /// Height of the Image.
  final double height;

  @override
  Widget build(BuildContext context) => FadeInImage.assetNetwork(
        key: key,
        image: url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
        placeholder: Assets.placeholder,
        placeholderFit: BoxFit.cover,
        imageErrorBuilder: (_, __, ___) => Image.asset(
          Assets.noImageIcon,
          fit: BoxFit.cover,
          height: height,
        ),
      );
}
