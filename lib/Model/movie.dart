class Movie {
  final String title;
  final String year;
  final String plot;
  final String poster;

  Movie({
    required this.title,
    required this.year,
    required this.plot,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      plot: json['Plot'] ?? '',
      poster: json['Poster'] ?? '',
    );
  }
}
