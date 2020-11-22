import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_programming_project/widgets/Homepage-banner-item.dart';
import 'package:mobile_programming_project/widgets/list-of-movies.dart';
import 'package:mobile_programming_project/widgets/movie_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}

/*firg-note: 
- Changed topFive to MovieList
- Added MovieDetail in the routes
- Homepage-banner-item now takes 4th argument, which is the route destination
*/

class HomeScreen extends StatelessWidget {
  final List<String> list = List.generate(10, (index) => "Movie $index");

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Rate Cinema',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
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
              'Out top 10 movie picks',
              () {
                Navigator.of(context).pushNamed(MovieList.routeName);
              },
            ),
            HomepageBannerItem(
              isLandscape,
              'https://images-na.ssl-images-amazon.com/images/I/51BANINoAxL._AC_.jpg',
              'Movie of the Day',
              () {
                Navigator.of(context)
                    .pushNamed(MovieDetail.routeName, arguments: 'm1');
              },
            ),
            HomepageBannerItem(
              isLandscape,
              'https://images-na.ssl-images-amazon.com/images/I/918B9zoR7zL._AC_SL1500_.jpg',
              'Create your own List',
              () {
                Navigator.of(context).pushNamed(MovieList.routeName);
              },
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
        onPressed: () {},
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
        icon: Icon(Icons.arrow_back),
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
