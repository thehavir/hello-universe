import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/image_detail/view/image_details_page.dart';
import 'package:hello_universe/models/model.dart';
import 'package:hello_universe/repository/impl_repository.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  late ImageListCubit _imageListCubit;

  @override
  void initState() {
    super.initState();

    _imageListCubit = ImageListCubit(ImplRepository())
      ..fetchImageList(
        startDate: '2016-01-25',
        endDate: '2016-02-25',
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Universe!'),
      ),
      body: SafeArea(
        child: BlocBuilder<ImageListCubit, ImageListState>(
          bloc: _imageListCubit,
          builder: (BuildContext context, ImageListState imageListState) {
            if (imageListState is ImageListStateLoaded) {
              return _buildBody(imageListState);
            } else if (imageListState is ImageListStateFailed) {
              return _buildErrorPage(imageListState.error);
            }

            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildBody(ImageListStateLoaded state) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: state.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          final PictureOfDay apod = state.imageList[index];

          return Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetailsPage(
                    apod: apod,
                  ),
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildImage(
                      apod.mediaType == MediaType.image
                          ? apod.url!
                          : apod.thumbnailUrl!,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  ListTile(
                    title: Text(apod.title!),
                    subtitle: Text(apod.date!),
                  ),
                ],
              ),
            ),
          );
        },
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

  Widget _buildErrorPage(String error) => Center(
        child: Text(
          'Oops, something went wrong!: $error',
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
