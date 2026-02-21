import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: .only(top: 8, bottom: 16),
      child: CircularProgressIndicator(),
    ),
  );
}
