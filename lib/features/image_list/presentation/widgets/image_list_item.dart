import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/features/core/widgets/widgets.dart';
import 'package:hello_universe/models/models.dart';
import 'package:hello_universe/utils/navigation/navigation.dart';

/// An item from the Nasa APOD list.
class ImageListItem extends StatelessWidget {
  /// Constructs a `ImageListItem`.
  const ImageListItem(
    this.apod, {
    Key? key,
  }) : super(key: key);

  /// The current `Merchant` in the list.
  final Apod apod;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: _buildCardContent(context),
        ),
      );

  Widget _buildCardContent(BuildContext context) => InkWell(
        child: Column(
          children: <Widget>[
            _buildImage(),
            _buildText(),
          ],
        ),
        onTap: () =>
            context.read<NavigationCubit>().navigateToDetailsPage(apod),
      );

  Widget _buildImage() => Hero(
        tag: '${apod.imageUrl}',
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(8),
          ),
          // Todo(Havir): handle videos (they have thumbnail).
          child: (apod.imageUrl?.isEmpty ?? true)
              ? const NoImage(key: Key('ImageListItemNoResultImage'))
              : Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FadeInNetworkImage(
                      url: apod.imageUrl!,
                      key: const Key('ImageListItemNetworkImage'),
                    ),
                    if (apod.isVideo) const PlayIcon(),
                  ],
                ),
        ),
      );

  Widget _buildText() => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          apod.date!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      );
}
