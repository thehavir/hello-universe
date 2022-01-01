import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/core/assets.dart';
import 'package:hello_universe/features/core/widgets/widgets.dart';
import 'package:hello_universe/features/image_list/presentation/widgets/widgets.dart';
import 'package:hello_universe/features/image_list/states/image_list_cubit.dart';
import 'package:hello_universe/models/model.dart';

/// Widget for showing Nasa APOD list.
/// It is the main page of the application.
class ImageListPage extends StatefulWidget {
  /// Constructs a `ImageListPage`.
  const ImageListPage({Key? key}) : super(key: key);

  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 200;

  @override
  void initState() {
    super.initState();

    context.read<ImageListCubit>().fetch();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<ImageListCubit>().fetch();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Quandoo restaurant browser'),
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<ImageListCubit, ImageListState>(
          listener: (BuildContext context, ImageListState state) {
            if (state.isSuccess && !state.hasMore) {
              _showSnackBar(context);
            }
          },
          builder: (BuildContext context, ImageListState state) {
            if (state.isFailedToInit) {
              return _buildErrorPage();
            } else if (state.isInitial || (state.isLoading && !state.hasData)) {
              return _buildLoadingPage();
            }

            return _buildBody(context, state);
          },
        ),
      );

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('That\'s the whole Images that we have :)'),
      ),
    );
  }

  Widget _buildErrorPage() => EmptyPage(
        title: 'Something went wrong\nFailed to load!',
        assetsImage: Assets.errorIcon,
        actionButton: TextButton(
          child: const Text('Try again'),
          onPressed: () => context.read<ImageListCubit>().fetch(),
        ),
      );

  Widget _buildLoadingPage() => const Center(
        child: CircularProgressIndicator(
          key: Key('ImageListPageCircularProgressIndicator'),
        ),
      );

  Widget _buildBody(BuildContext context, ImageListState state) {
    if (state.hasData) {
      return _buildImageList(state);
    }

    return _buildEmptyPage();
  }

  Widget _buildImageList(ImageListState state) {
    final List<PictureOfDay> images = state.data!;

    return ListView.builder(
      key: const Key('ImageListPageListView'),
      itemBuilder: (BuildContext context, int index) => index >= images.length
          ? state.isFailure
              ? _buildRetryButton()
              : const BottomLoader()
          : ImageListItem(
              images[index],
              key: Key('ImageListItem$index'),
            ),
      itemCount: !state.hasMore ? images.length : images.length + 1,
      controller: _scrollController,
    );
  }

  Widget _buildEmptyPage() => const EmptyPage(
        title: 'There is no Image!',
        assetsImage: Assets.noResultIcon,
      );

  Widget _buildRetryButton() => TextButton(
        child: const Text('Retry'),
        onPressed: () => context.read<ImageListCubit>().fetch(),
      );

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
