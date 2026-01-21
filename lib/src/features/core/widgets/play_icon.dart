import 'package:flutter/material.dart';

class PlayIcon extends StatelessWidget {
  const PlayIcon({
    Key? key,
    this.size = 100,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) => Icon(
        Icons.play_circle_outline,
        color: Colors.white54,
        size: size,
      );
}
