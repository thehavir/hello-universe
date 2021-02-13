import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_universe/api/models/apod.dart';
import 'package:hello_universe/image_detail/cubit/image_details_cubit.dart';
import 'package:hello_universe/repository/fake_nasa_apod_repository.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Universe!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Image details'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImageDetailsCubit _imageDetailsCubit;

  @override
  void initState() {
    super.initState();

    _imageDetailsCubit = ImageDetailsCubit(FakeNasaApodRepository())
      ..fetchImageDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageDetailsCubit, ImageDetailsState>(
      cubit: _imageDetailsCubit,
      builder: (BuildContext context, ImageDetailsState state) {
        if (state is ImageDetailsLoadedState) {
          return _buildImageDetailsPage(state.pictureOfDay);
        } else if (state is ImageDetailsFetchFailedState) {
          return _buildErrorPage(state.error);
        }

        return _buildLoading();
      },
    );
  }

  Widget _buildImageDetailsPage(PictureOfDay image) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          image.url,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  Widget _buildErrorPage(String error) {
    return Center(
      child: Text(
        'Oops, something went wrong!',
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
}
