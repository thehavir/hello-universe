import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/assets.dart';

/// Widget that is used as a `FadeInImage.assetNetwork` template.
class FadeInNetworkImage extends StatelessWidget {
  /// Constructs a `FadeInNetworkImage`.
  const FadeInNetworkImage({
    required this.url,
    Key? key,
  }) : super(key: key);

  /// Url of the image.
  final String url;

  @override
  Widget build(BuildContext context) => FadeInImage.assetNetwork(
        key: key,
        image: url,
        placeholder: Assets.placeholder,
        placeholderFit: BoxFit.cover,
        imageErrorBuilder: (_, __, ___) => Image.asset(
          Assets.placeholder,
          fit: BoxFit.cover,
        ),
        height: 210,
        fit: BoxFit.cover,
      );
}