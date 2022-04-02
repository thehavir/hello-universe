import 'package:flutter/material.dart';
import 'package:hello_universe/features/core/widgets/widgets.dart';
import 'package:hello_universe/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageDetailsPage extends StatefulWidget {
  ImageDetailsPage({
    required this.apod,
  });

  final Apod apod;

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff212121),
        appBar: AppBar(
          title: Text('${widget.apod.title}'),
        ),
        body: _buildBody(),
      );

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
        tag: '${widget.apod.imageUrl}',
        child: GestureDetector(
          onTap: _onImageTap,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              FadeInNetworkImage(
                url: '${widget.apod.imageUrl}',
                height: MediaQuery.of(context).size.height / 3,
              ),
              if (widget.apod.isVideo)
                const PlayIcon(
                  size: 120,
                ),
            ],
          ),
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

  void _onImageTap() {
    if (widget.apod.isVideo) {
      _launchYoutube();
    }
  }

  Future<void> _launchYoutube() async {
    if (!await launch(widget.apod.url!)) {
      throw Exception('Could not launch ${widget.apod.url!}');
    }
  }
}
