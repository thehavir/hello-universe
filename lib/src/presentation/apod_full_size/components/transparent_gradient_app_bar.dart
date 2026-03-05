import 'package:flutter/material.dart';

class TransparentGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TransparentGradientAppBar({super.key});

  @override
  Size get preferredSize => const .fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: .light,
    leading: const BackButton(color: Colors.white),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
    ),
  );
}
