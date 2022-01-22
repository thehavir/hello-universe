import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/widgets/fade_in_network_image.dart';
import 'package:hello_universe/models/model.dart';

class ImageDetailsPage extends StatefulWidget {
  ImageDetailsPage({
    required this.apod,
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
      appBar: AppBar(
        title: Text('${widget.apod.title}'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(),
            _buildDescription(),
            _buildCreditAndDate(),
          ],
        ),
      );

  Widget _buildImage() => Hero(
        tag: '${widget.apod.url}',
        child: FadeInNetworkImage(
          url: '${widget.apod.url}',
          height: MediaQuery.of(context).size.height / 3,
        ),
      );

  Widget _buildDescription() => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Description: ${widget.apod.explanation}',
          style: const TextStyle(
            color: Color(0xffefefef),
            fontSize: 16,
          ),
        ),
      );

  Widget _buildCreditAndDate() => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Copyright: ${widget.apod.copyright}\n${widget.apod.date}',
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
