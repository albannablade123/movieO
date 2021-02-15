import 'package:flutter/material.dart';
import 'package:mobile_programming_project/Models/movie.dart';
import 'file:///C:/Users/hp15pav/AndroidStudioProjects/mobile_programming_project_partB/lib/utils/movies_provider.dart';
import 'package:mobile_programming_project/widgets/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:mobile_programming_project/widgets/Homepage-banner-item.dart';

class upcomingMovies extends StatefulWidget {
  static const routeName = 'nowPlaying-list';
  @override
  _upcomingMoviesState createState() => _upcomingMoviesState();
}

class _upcomingMoviesState extends State<upcomingMovies> {
  @override

  Widget buildCard(BuildContext ctx, int index, Function colorOption, int id,
      String movieName, String imageName, String releaseDate, dynamic rating) {
    return FlatButton(
      child: Card(
        elevation: 12,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(
            ' $movieName',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('rating: $rating'),
          trailing: Text(
            'Release Date: $releaseDate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(ctx).pushNamed(UpcomingMovieDetail.routeName, arguments: id);
      },
    );
  }


  Color ranking(int index) {
    switch (index) {
      case 0:
        {
          return Colors.yellow;
        }
      case 1:
        {
          return Colors.blue;
        }
      case 2:
        {
          return Colors.brown;
        }
      default:
        {
          return Colors.black54;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> filmsNowPlaying = Provider.of<Movies>(context, listen: false).getNowPlaying();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){Navigator.of(context).pop();},
        ),
        title: Center(
          child: Text(
            'Upcoming Movies',
            style: TextStyle(
              shadows: [
                Shadow(
                    color: Colors.black54,
                    blurRadius: 1.5,
                    offset: Offset.fromDirection(-2.0))
              ],
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
        child: ListView.builder(
          itemCount: filmsNowPlaying.length,
          itemBuilder: (ctx, index) {
            var movies = filmsNowPlaying[index];

            return buildCard(
                context,
                index,
                ranking,
                movies.id,
                movies.original_title,
                movies.poster_path,
                movies.release_date,
                movies.vote_average);
          },
        ),
      ),
    );
  }
}
