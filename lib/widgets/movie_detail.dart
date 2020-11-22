import 'package:flutter/material.dart';
import 'package:mobile_programming_project/data/dummy_data.dart';

class MovieDetail extends StatelessWidget {
  static const routeName = 'movie-detail';

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute.of(context).settings.arguments as String;
    var movie = MOVIES.firstWhere((movie) => movie.id == movieId);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
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
                      movie.title,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          movie.releaseDate,
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
                          '${movie.rating}',
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
                    'Here is going to be the description',
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
