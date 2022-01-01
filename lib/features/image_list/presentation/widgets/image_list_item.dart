import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/widgets/widgets.dart';
import 'package:hello_universe/models/model.dart';

/// An item from the Nasa APOD list.
class ImageListItem extends StatelessWidget {
  /// Constructs a `ImageListItem`.
  const ImageListItem(
    this.pictureOfDay, {
    Key? key,
  }) : super(key: key);

  /// The current `Merchant` in the list.
  final PictureOfDay pictureOfDay;

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
        // onTap: () =>
        //     context.read<NavigationCubit>().goToMerchantDetailsPage(merchant),
      );

  Widget _buildImage() => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(8),
        ),
        child: (pictureOfDay.thumbnailUrl?.isEmpty ?? false)
            ? const NoImage(key: Key('ImageListItemNoResultImage'))
            : FadeInNetworkImage(
                url: pictureOfDay.thumbnailUrl!,
                key: const Key('ImageListItemNetworkImage'),
              ),
      );

  Widget _buildText() => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          pictureOfDay.title!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
      );
}
