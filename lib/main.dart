
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_programming_project/widgets/Homepage-banner-item.dart';
import 'package:mobile_programming_project/widgets/Settings-page.dart';
import 'package:mobile_programming_project/widgets/list-of-movies.dart';
import 'package:mobile_programming_project/widgets/movie_detail.dart';
import 'package:mobile_programming_project/widgets/Drawer-widget.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/hp15pav/AndroidStudioProjects/mobile_programming_project_partB/lib/utils/movies_provider.dart';
import 'package:mobile_programming_project/widgets/user_created_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_programming_project/widgets/upcoming_movies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {


  @override
  // TODO: implement build
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Movies(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.deepOrangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
        routes: {
          MovieList.routeName: (ctx) => MovieList(),
          MovieDetail.routeName: (ctx) => MovieDetail(),
          SettingsPage.routeName: (ctx) => SettingsPage(),
          UserCreatedList.routeName: (ctx) => UserCreatedList(),
          upcomingMovies.routeName:(ctx) => upcomingMovies(),
          UpcomingMovieDetail.routeName:(ctx) => UpcomingMovieDetail(),
        },
      ),
    );
  }
}

/*firg-note:
- Changed topFive to MovieList
- Added MovieDetail in the routes
- Homepage-banner-item now takes 4th argument, which is the route destination
*/

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> list = List.generate(10, (index) => "Movie $index");
  var posterPath = "https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg";
  @override
  void initState() {
    Provider.of<Movies>(context, listen: false).fetchAllMovies(3).then((value) => Provider.of<Movies>(context, listen: false).setMovieOftheDay());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Cinema Companion App',
          textScaleFactor: 0.8,
          textAlign: TextAlign.center,
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: Search(list));
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            HomepageBannerItem(
              isLandscape,
              'https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg',
              'Out top movie picks',
              () {
                Navigator.of(context).pushNamed(MovieList.routeName);
              },
            ),
            Consumer<Movies>(
              builder: (ctx, moviesData, child) {
                  return HomepageBannerItem(
                  isLandscape,
                  moviesData.getMovieOftheDayPosterPath == null ?
                     posterPath  : "https://image.tmdb.org/t/p/original/" + (moviesData.getMovieOftheDayPosterPath),
                  'Movie of the Month',
                  () {
                    Navigator.of(context)
                        .pushNamed(MovieDetail.routeName, arguments: moviesData.getMovieOftheDay().id);
                  },
                );
              },
            ),
            HomepageBannerItem(
              isLandscape,
              'https://images-na.ssl-images-amazon.com/images/I/918B9zoR7zL._AC_SL1500_.jpg',
              'My Personal List',
              () {
                Navigator.of(context).pushNamed(UserCreatedList.routeName);
              },
            ),
            HomepageBannerItem(
                isLandscape,
                'https://cdn11.bigcommerce.com/s-ydriczk/images/stencil/1280x1280/products/89058/93685/Joker-2019-Final-Style-steps-Poster-buy-original-movie-posters-at-starstills__62518.1572351179.jpg?c=2?imbypass=on',
                'Upcoming Movies',
                () {
                  Navigator.of(context).pushNamed(upcomingMovies.routeName);
                }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      drawer:
          DrawerClass(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Search extends SearchDelegate {
  final List<String> listExample;

  Search(this.listExample);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  String selectedResult;

  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  List<String> recentList = [
    "Planet of the Apes",
    "Barney The Dinosaur: zombie land"
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
        );
      },
    );
  }
}
