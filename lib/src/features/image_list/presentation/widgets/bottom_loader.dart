import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    alignment: .center,
    padding: const .all(8),
    child: const Center(
      child: SizedBox(
        width: 33,
        height: 33,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
