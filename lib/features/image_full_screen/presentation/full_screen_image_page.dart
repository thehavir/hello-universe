import 'package:flutter/material.dart';

/// Shows image in full screen with zoom capability.
class FullScreenImagePage extends StatefulWidget {
  /// Constructs a `FullScreenImagePage`.
  const FullScreenImagePage(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  /// Url of the image.
  final String imageUrl;

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool _shouldShowHeader = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _shouldShowHeader ? _buildAppBar() : null,
        body: GestureDetector(
          onTap: _onScreenTap,
          child: _buildImage(),
        ),
      );

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: <double>[0.2, 1],
            ),
          ),
        ),
      );

  void _onScreenTap() => setState(() => _shouldShowHeader = !_shouldShowHeader);

  Widget _buildImage() => Hero(
        tag: widget.imageUrl,
        child: Container(
          color: const Color(0xff212121),
          child: Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      );
}
