import 'package:flutter/material.dart';

/// A widget that shows a loader at the bottom of the page.
class BottomLoader extends StatelessWidget {
  /// Constructs a `BottomLoader`.
  const BottomLoader();

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: const Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
