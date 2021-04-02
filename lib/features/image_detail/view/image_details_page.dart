import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/features/image_detail/cubit/image_details_cubit.dart';
import 'package:hello_universe/repository/impl_nasa_apod_repository.dart';

class ImageDetailsPage extends StatefulWidget {
  final String title;

  ImageDetailsPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  ImageDetailsCubit _imageDetailsCubit;

  @override
  void initState() {
    super.initState();

    _imageDetailsCubit = ImageDetailsCubit(ImplNasaApodRepository())
      ..fetchImageDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: BlocBuilder<ImageDetailsCubit, ImageDetailsState>(
        bloc: _imageDetailsCubit,
        builder: (BuildContext context, ImageDetailsState state) {
          if (state is ImageDetailsLoadedState) {
            return _buildBody(state.pictureOfDay);
          } else if (state is ImageDetailsFetchFailedState) {
            return _buildErrorPage(state.error);
          }

          return _buildLoading();
        },
      ),
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

  Widget _buildErrorPage(String error) => Center(
        child: const Text(
          'Oops, something went wrong!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
