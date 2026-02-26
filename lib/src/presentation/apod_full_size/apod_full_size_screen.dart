import 'package:flutter/material.dart';
import 'package:hello_universe/src/presentation/apod_full_size/apod_full_size_content.dart';

class ApodFullSizeScreen extends StatelessWidget {
  const ApodFullSizeScreen({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: ApodFullSizeContent(url: url),
  );
}
