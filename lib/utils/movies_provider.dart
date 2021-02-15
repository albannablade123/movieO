import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_programming_project/Models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_programming_project/widgets/upcoming_movies.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/media.dart';

class Movies with ChangeNotifier {
  List<Movie> movies = [];
  List<Movie> usermovies = [];
  List<Movie> blockedMovies = [];
  List<Media> mediaMovies = [];
  List<Movie> nowPlaying = [];
  Movie movieOfTheDay;
  final columnId = 'id';

  //------------Firebase Collections------//
  CollectionReference mediaRef =
      FirebaseFirestore.instance.collection('Medias');

  CollectionReference nowPlayingRef =
      FirebaseFirestore.instance.collection('nowPlaying');

  Future<List<dynamic>> checkCollection() async {
    var resultMedia = await mediaRef.get();
    List<Media> temp = [];
    resultMedia.docs.forEach((doc) {
      temp.add(Media(
          id: doc['id'],
          netflix: doc['netflix'],
          googlePlay: doc['googleplay']));
    });
    mediaMovies = temp;
    notifyListeners();
  }

  Future<void> deleteMediaFromCollection(String id) {
    return mediaRef
        .doc(id)
        .delete()
        .then((value) => print("Media Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  Future<List<dynamic>> checkCollectionNowPlaying() async {
    var resultNowPlaying = await nowPlayingRef.get();
    List<Movie> temp = [];
    resultNowPlaying.docs.forEach((doc) {
      var adultCheck;
      if(doc['adult'] == 0){
        adultCheck = false;
      }
      else{
        adultCheck = true;
      }
      temp.add(Movie(

          id: doc['id'],
          poster_path: doc['poster_path'],
          original_title: doc['original_title'],
          release_date: doc['release_date'],
          vote_average: doc['vote_average'],
          overview: doc['overview'],
          adult: adultCheck,
      ));
    });
    nowPlaying = temp;
    notifyListeners();
  }

  Future<void> deleteNowPlayingFromCollection(int id) async {

    var idCollection;
    try{
      QuerySnapshot docToDelete = await nowPlayingRef
          .where('id', isEqualTo: id)
          .get();
      if(docToDelete.docs.isEmpty){
        return;
      }
      idCollection = docToDelete.docs[0].id;
      print('id collection is${idCollection}');
      await nowPlayingRef
          .doc(idCollection)
          .delete()
          .then((value) => print("Movie Deleted from collection ${id}"))
          .catchError((error) => print("Failed to delete user: $error"));
      nowPlaying.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    catch(e){
    throw e;
    }


  }

  static Database _database;

  List<Movie> convertFromJson(http.Response response) {
    return [
      if (response.statusCode == 200)
        for (var i in json.decode(response.body)['results']) Movie.fromJson(i),
    ];
  }

  Media convertFromJsontoMedia(http.Response response) {
    if (response.statusCode == 200) {
      return Media.fromJson(json.decode(response.body)['id'],
          json.decode(response.body)['results']);
    }
  }

  Movie getMovieOftheDay() {
    return movieOfTheDay;
  }

  Future<void> addMediaForEachMovies(int id) async {
    var response = await http.get(
        "https://api.themoviedb.org/3/movie/$id/watch/providers?api_key=f5722edf270eb4e4162ef395187fa59a");
    mediaMovies.add(convertFromJsontoMedia(response));
    await addMediaToFirebase(convertFromJsontoMedia(response));
  }

  String get getMovieOftheDayPosterPath {
    if (movieOfTheDay != null) {
      return movieOfTheDay.poster_path;
    }
    return null;
  }

  setMovieOftheDay() {
    Random random = new Random();
    int randomNumber = random.nextInt(movies.length);
    movieOfTheDay = movies[randomNumber];
    notifyListeners();
  }

  getMovies() {
    return this.movies;
  }

  getNowPlaying() {
    return this.nowPlaying;
  }

  getMedia() {
    return this.mediaMovies;
  }

  getListLength() {
    return this.mediaMovies.length;
  }

  Future<void> fetchAllMovies(int page) async {
    await getMovieFromDatabase();
    await checkCollection();
    await checkCollectionNowPlaying();

    if(nowPlaying.isEmpty){
      var response = await http.get(
          "https://api.themoviedb.org/3/movie/now_playing?api_key=f5722edf270eb4e4162ef395187fa59a");
      nowPlaying.addAll(convertFromJson(response));
      for(Movie i in nowPlaying ){
        addNowPlaying(i);
        notifyListeners();
      }
      notifyListeners();

    }

    if (movies.isEmpty) {
      //check if database is empty or not
      print('condition 1 reached');
      for (int i = 1; i < page; i++) {
        var response = await http.get(
            "https://api.themoviedb.org/3/movie/top_rated?api_key=f5722edf270eb4e4162ef395187fa59a&language=en-US&page=$i");
        movies.addAll(convertFromJson(response));
        insertNewMovieDB(movies);

        notifyListeners();
      }
      if (mediaMovies.isEmpty) {
        for (var i in movies) {
          addMediaForEachMovies(i.id);
          notifyListeners();
        }
      }
    } else {
      print('condition 2 reached');
      notifyListeners();
    }
  }

  Future<void> addMediaToFirebase(Media media) async {
    try {
      print('adding to firebase');
      var res = await mediaRef.add(media.mediatoMap());
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addNowPlaying(Movie newPlaying) async {
    try {
      print('adding to firebase');
      var res = await nowPlayingRef.add(newPlaying.movietoMap());
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<Database> get database async {
    try {
      if (_database != null) return database;

      _database = await initDB();
      return _database;
    } catch (e) {
      //(e);
    }
  }

  Future<Database> initDB() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'movies_database.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE Movies (id INTEGER PRIMARY KEY, poster_path TEXT, original_title TEXT, vote_average REAL, release_date TEXT, overview TEXT, adult INTEGER)");
          await db.execute(
              "CREATE TABLE UserMovies (id INTEGER PRIMARY KEY, poster_path TEXT, original_title TEXT, vote_average REAL, release_date TEXT, overview TEXT, adult INTEGER)");
        },
      );
    } catch (e) {
      //print(e);
    }
  }

  //This method inserts a new object with type movie into database
  Future<void> insertNewMovieDB(List<Movie> movies) async {
    try {
      await database;
      for (var i in movies) {
        var res = await _database.insert("Movies", i.movietoMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> getMovieFromDatabase() async {
    try {
      await database;
      List<Map<String, dynamic>> res = await _database.query("Movies");
      if (res.length == 0) {
        return;
      }
      List<Movie> temp = [];
      res.forEach((element) {
        temp.add(Movie(
          id: element['id'],
          original_title: element['original_title'],
          poster_path: element['poster_path'],
          vote_average: element['vote_average'],
          release_date: element['release_date'],
          overview: element['overview'],
          adult: element['adult'] == 1 ? true : false,
        ));
      });
      this.movies = temp;
    } catch (e) {
      //print(e);
    }
  }

  Future<void> deleteMovieDB(int id) async {
    try {
      usermovies.removeWhere((element) => element.id == id);
      var res = await _database
          .delete("Movies", where: '$columnId = ?', whereArgs: [id]);
      notifyListeners();
    } catch (e) {
      //print(e);
    }
  }

  List<Movie> get userMovies {
    return this.usermovies;
  }

  Future<void> insertUserMovieDB(Movie userMovie) async {
    try {
      await database;
      var res = await _database.insert("UserMovies", userMovie.movietoMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      notifyListeners();
    } catch (e) {
      //print(e);
    }
  }

  Future<void> deleteUserMovieDB(int id) async {
    try {
      usermovies.removeWhere((element) => element.id == id);
      var res = await _database
          .delete("UserMovies", where: '$columnId = ?', whereArgs: [id]);
      notifyListeners();
    } catch (e) {
      //(e);
    }
  }

  Future<void> getUserMovieFromDatabase() async {
    try {
      await database;
      List<Map<String, dynamic>> res = await _database.query("UserMovies");
      if (res.length == 0) {
        return;
      }
      List<Movie> temp = [];
      res.forEach((element) {
        temp.add(Movie(
          id: element['id'],
          original_title: element['original_title'],
          poster_path: element['poster_path'],
          vote_average: element['vote_average'],
          release_date: element['release_date'],
          overview: element['overview'],
          adult: element['adult'] == 1 ? true : false,
        ));
      });
      this.usermovies = temp;
      notifyListeners();
    } catch (e) {
      //print(e);
    }
  }
}
