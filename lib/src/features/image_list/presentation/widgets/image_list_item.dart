import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_universe/src/domain/entities/apod.dart';
import 'package:hello_universe/src/features/core/widgets/widgets.dart';
import 'package:hello_universe/src/features/image_list/extensions/date_extension.dart';
import 'package:hello_universe/src/routes.dart';

class ImageListItem extends StatelessWidget {
  const ImageListItem(this.apod, {super.key});

  final Apod apod;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .symmetric(horizontal: 8),
    child: Card(
      shape: const RoundedRectangleBorder(borderRadius: .all(.circular(8))),
      child: InkWell(
        child: Column(
          children: <Widget>[
            Hero(
              tag: apod.url,
              child: ClipRRect(
                borderRadius: const .vertical(top: Radius.circular(8)),
                // Todo(Havir): handle videos (they have thumbnail).
                child: Stack(
                  alignment: .center,
                  children: <Widget>[
                    FadeInNetworkImage(
                      url: apod.url,
                      key: const Key('ImageListItemNetworkImage'),
                    ),
                    if (apod.mediaType == .video) const PlayIcon(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const .all(8),
              child: Text(
                apod.date.format(),
                textAlign: .center,
                style: const TextStyle(
                  fontWeight: .w500,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        onTap: () => context.pushNamed(Routes.imageDetails, extra: apod),
      ),
    ),
  );
}
