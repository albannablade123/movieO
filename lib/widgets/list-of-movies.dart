
import 'package:flutter/material.dart';
import 'package:mobile_programming_project/Models/movie.dart';
import 'file:///C:/Users/hp15pav/AndroidStudioProjects/mobile_programming_project_partB/lib/utils/movies_provider.dart';
import 'package:mobile_programming_project/widgets/movie_detail.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  static const routeName = 'movie-list';

  @override
  _MovieListState createState() => _MovieListState();
}


class _MovieListState extends State<MovieList> {

  Widget buildCard(BuildContext ctx, int index, Function colorOption, int id,
      String movieName, String imageName, String releaseDate, double rating) {
    var colorOfShadow = colorOption(index);
    return FlatButton(
      child: Card(
        elevation: 12,
        shadowColor: colorOfShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepOrangeAccent,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  '#${index + 1}',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          title: Text(
            ' $movieName',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('$releaseDate'),
          trailing: Text(
            'IMDB rating: $rating',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(ctx).pushNamed(MovieDetail.routeName, arguments: id);
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
    List<Movie> films = Provider.of<Movies>(context, listen: false).getMovies();
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
            'Top movies',
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
          itemCount: films.length,
          itemBuilder: (ctx, index) {
            var movies = films[index];

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
