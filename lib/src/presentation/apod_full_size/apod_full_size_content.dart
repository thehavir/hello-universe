import 'package:flutter/material.dart';
import 'package:hello_universe/src/assets.dart';

class ApodFullSizeContent extends StatelessWidget {
  const ApodFullSizeContent({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) => Hero(
    tag: url,
    child: Center(
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: Image.network(
          url,
          width: .infinity,
          height: .infinity,
          fit: .fitWidth,
          errorBuilder: (_, __, ___) =>
              Image.asset(Assets.noImageIcon, fit: .contain),
        ),
      ),
    ),
  );
}
