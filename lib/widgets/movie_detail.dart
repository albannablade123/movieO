import 'package:flutter/material.dart';
import 'package:mobile_programming_project/Models/media.dart';
import 'package:mobile_programming_project/Models/movie.dart';
import 'file:///C:/Users/hp15pav/AndroidStudioProjects/mobile_programming_project_partB/lib/utils/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatelessWidget {
  static const routeName = 'movie-detail';

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context).settings.arguments as int;
    var movies = Provider.of<Movies>(context, listen: false).getMovies();
    var medias = Provider.of<Movies>(context, listen: false).getMedia();
    var movie = movies.firstWhere((movie) => movie.id == movieId);
    var media = medias.firstWhere((element) => element.id == movieId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/" +
                          (movie.poster_path),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                ClipRRect(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //stops:[],
                          begin: Alignment.bottomCenter,
                          end: Alignment(0, 0.6),
                          colors: <Color>[
                            Colors.white.withAlpha(250),
                            Colors.white24.withOpacity(0.5),
                            Colors.white12.withOpacity(0.1),
                            Colors.white12.withOpacity(0.05),
                          ]),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.original_title,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            movie.release_date,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 34,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${movie.vote_average}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      movie.overview,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Adults Only: ${movie.adult} ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Available On netflix: ${media.netflix != null ? AdultCheck(media.netflix) : ''}  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Available for purchase on GooglePlay: ${media != null ? AdultCheck(media.googlePlay) : ''}  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        child: Text(
                          'Add to My watch list',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        onPressed: () {
                          Provider.of<Movies>(context, listen: false)
                              .insertUserMovieDB(movie);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String AdultCheck(bool x) {
    if (x == true) {
      return 'yes';
    } else if (x == false) {
      return 'No';
    } else {
      return 'null given';
    }
  }
}

class UpcomingMovieDetail extends StatelessWidget {
  static const routeName = 'upcoming-detail';

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context).settings.arguments as int;
    var upcomingMovies =
        Provider.of<Movies>(context).getNowPlaying();
    var movie = upcomingMovies.firstWhere((movie) => movie.id == movieId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/" +
                          (movie.poster_path),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                ClipRRect(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //stops:[],
                          begin: Alignment.bottomCenter,
                          end: Alignment(0, 0.6),
                          colors: <Color>[
                            Colors.white.withAlpha(250),
                            Colors.white24.withOpacity(0.5),
                            Colors.white12.withOpacity(0.1),
                            Colors.white12.withOpacity(0.05),
                          ]),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.original_title,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            movie.release_date,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 34,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${movie.vote_average}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      movie.overview,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Adults Only: ${movie.adult} ',
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        child: Text(
                          'Add to My watch list',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        onPressed: () {
                          Provider.of<Movies>(context, listen: false)
                              .insertUserMovieDB(movie);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(

                        color: Colors.deepOrange,
                        child: Text(
                          'Set A Reminder',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(

                        color: Colors.deepOrange,
                        child: Text(
                          'Dont Show this movie',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        onPressed: () async {
                          int movieId = movie.id;
                          Navigator.of(context).pushReplacementNamed('/');
                          try{
                            await Provider.of<Movies>(context, listen: false).deleteNowPlayingFromCollection(movieId);
                          }catch(e){

                          }


                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String AdultCheck(bool x) {
    if (x == true) {
      return 'yes';
    } else if (x == false) {
      return 'No';
    } else {
      return 'null given';
    }
  }
}
