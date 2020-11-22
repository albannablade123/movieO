import 'package:flutter/material.dart';
import 'package:mobile_programming_project/data/dummy_data.dart';

class MovieDetail extends StatelessWidget {
  static const routeName = 'movie-detail';

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context).settings.arguments as String;
    var movie = MOVIES.firstWhere((movie) => movie.id == movieId);
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }
}
