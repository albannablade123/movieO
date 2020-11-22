import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class MovieList extends StatefulWidget {
  static const routeName = 'movie-list';

  @override
  _MovieListState createState() => _MovieListState();
}

Widget buildCard(int index, String movieName, String imageName,
    String releaseDate, double rating) {
  return FlatButton(
    child: Card(
      elevation: 12,
      shadowColor: index == 0 ? Colors.yellowAccent : Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrangeAccent,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: FittedBox(
              child: Text('${index + 1}'),
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
    onPressed: () {},
  );
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Center(
          child: Text('Top 120 movies'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
        child: ListView.builder(
          itemCount: MOVIES.length,
          itemBuilder: (ctx, index) {
            var movies = MOVIES[index];
            return buildCard(index, movies.title, movies.imageUrl,
                movies.releaseDate, movies.rating);
          },
        ),
      ),
    );
  }
}
