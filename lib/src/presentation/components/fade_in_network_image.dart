import 'package:flutter/material.dart';
import 'package:hello_universe/src/assets.dart';

const _hight = 210.0;

class FadeInNetworkImage extends StatelessWidget {
  const FadeInNetworkImage({required this.url, super.key});

  final String url;

  // Todo(Havir): Cache the image (Maybe use [CachedNetworkImage]).
  @override
  Widget build(BuildContext context) => FadeInImage.assetNetwork(
    key: key,
    image: url,
    fit: .cover,
    width: .infinity,
    height: _hight,
    placeholder: Assets.placeholder,
    placeholderFit: .cover,
    imageErrorBuilder: (_, __, ___) =>
        Image.asset(Assets.noImageIcon, fit: .cover, height: _hight),
  );
}
