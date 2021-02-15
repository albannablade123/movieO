import 'package:flutter/material.dart';
import 'package:mobile_programming_project/Models/movie.dart';
import 'file:///C:/Users/hp15pav/AndroidStudioProjects/mobile_programming_project_partB/lib/utils/movies_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UserCreatedList extends StatefulWidget {
  static const routeName = 'user-list';

  @override
  _UserCreatedListState createState() => _UserCreatedListState();
}

class _UserCreatedListState extends State<UserCreatedList> {
  Widget buildCard(BuildContext ctx, int index, int id, String movieName,
      String imageName, String releaseDate, double rating) {
    return FlatButton(
      child: Card(
        elevation: 12,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: ctx,
                  builder: (bctx) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bruh Moment'),
                            RaisedButton(
                                child: Text('Set Reminder'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Scaffold.of(ctx).showSnackBar(SnackBar(
                                    content: Text('Reminder set'),
                                  ));
                                }),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(Icons.timer),
          ),
          title: Text(
            ' $movieName',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('$releaseDate'),
          trailing: IconButton(
            onPressed: () async {
              await Provider.of<Movies>(this.context, listen: false)
                  .deleteUserMovieDB(id);
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text('Movie deleted'),
              ));
              snackBarNotification();
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
      onPressed: () {
        //Navigator.of(ctx).pushNamed(MovieDetail.routeName, arguments: id);
      },
    );
  }

  @override
  void initState() {
    Provider.of<Movies>(this.context, listen: false).getUserMovieFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> userFilms = Provider.of<Movies>(context).usermovies;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            'My List',
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
        child: userFilms.isEmpty
            ? emptyWarning()
            : ListView.builder(
                itemCount: userFilms.length,
                itemBuilder: (ctx, index) {
                  var movies = userFilms[index];

                  return buildCard(
                      ctx,
                      index,
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

class emptyWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Icon(
                Icons.movie_creation,
                size: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text('Your list seems empty, start adding movies!'),
            ),
          )
        ],
      ),
    );
  }
}

class snackBarNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('snackBar');
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Hi Im snackbar!!!"),
        action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
            })));
  }
}
