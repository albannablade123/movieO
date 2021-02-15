
class Movie{
  int id;
  String original_title;
  dynamic vote_average;
  String release_date;
  String poster_path;
  String overview;
  bool adult;


  Movie({this.id, this.original_title, this.vote_average, this.release_date, this.poster_path,this.overview,this.adult});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"],
        poster_path: json["poster_path"],
        original_title: json["original_title"],
        vote_average: json["vote_average"],
        release_date: json["release_date"],
        overview: json["overview"],
        adult: json["adult"],
    );
  }

  Map<String, dynamic> movietoMap(){
    return {
      "id": this.id,
      "poster_path": this.poster_path,
      "original_title": this.original_title,
      "release_date": this.release_date,
      "vote_average": this.vote_average,
      "overview": this.overview,
      "adult":  this.adult == true ? 1 : 0,
    };

  }

}

/*
 Firg's note: 
 - Added id in the string
*/
