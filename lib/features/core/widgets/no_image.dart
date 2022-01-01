import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/assets.dart';

/// Widget that is used as placeholder image when there is no image.
class NoImage extends StatelessWidget {
  /// Constructs a `NoImage` widget.
  const NoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        Assets.noImageIcon,
        key: key,
        fit: BoxFit.contain,
        height: 210,
      );
}
