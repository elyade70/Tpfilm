class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String poster;
  final String plot;
  final String actors;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
    required this.plot,
    required this.actors,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      actors: json['Actors'] ?? '',
    );
  }
}
