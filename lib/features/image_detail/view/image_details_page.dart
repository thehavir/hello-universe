import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_universe/api/models/apod.dart';

class ImageDetailsPage extends StatefulWidget {
  ImageDetailsPage({
    this.apod,
  });

  final PictureOfDay apod;

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: _buildBody(widget.apod),
    );
  }

  Widget _buildBody(PictureOfDay image) => CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(image),
          _buildPage(image),
        ],
      );

  Widget _buildAppBar(PictureOfDay image) => SliverAppBar(
        title: Text(image.title),
        expandedHeight: MediaQuery.of(context).size.height / 2,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: _buildImage(image.url),
        ),
      );

  Widget _buildImage(String imageUrl) => Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (BuildContext context, ImageProvider imageProvider) =>
              Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: _buildImageLoadingState,
          errorWidget: _buildImageErrorState,
        ),
      );

  Widget _buildImageErrorState(
    BuildContext context,
    String url,
    dynamic error,
  ) =>
      const Icon(Icons.error);

  Widget _buildImageLoadingState(
    BuildContext context,
    String url,
    DownloadProgress downloadProgress,
  ) =>
      CircularProgressIndicator(value: downloadProgress.progress);

  Widget _buildPage(PictureOfDay image) {
    return SliverFillRemaining(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDescription(image.explanation),
            _buildCreditAndDate(credit: image.copyright, date: image.date),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(String description) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Description: $description',
          style: const TextStyle(
            color: Color(0xffefefef),
            fontSize: 16,
          ),
        ),
      );

  Widget _buildCreditAndDate({String credit, String date}) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Copyright: $credit\n$date',
                style: const TextStyle(
                  color: Color(0xffefefef),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
}
