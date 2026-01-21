import 'package:flutter/material.dart';

/// It is used as an empty page for showing an "empty state".
class EmptyPage extends StatelessWidget {
  /// Constructs an `EmptyPage`.
  const EmptyPage({
    required this.title,
    this.assetsImage,
    this.actionButton,
    Key? key,
  }) : super(key: key);

  /// The text that is shown on the page.
  final String title;

  /// Path of the `AssetsImage`.
  final String? assetsImage;

  /// Button that is used as an action.
  final TextButton? actionButton;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (assetsImage != null) _buildImage(),
            const SizedBox(height: 32),
            _buildTitle(),
            const SizedBox(height: 16),
            if (actionButton != null) actionButton!,
          ],
        ),
      );

  Widget _buildTitle() => Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      );

  Widget _buildImage() => Image.asset(
        assetsImage!,
        key: const Key('EmptyPageAssetImage'),
        height: 128,
        fit: BoxFit.fitWidth,
      );
}
