import 'dart:convert';
import 'package:flutter_assignment_pune_tradex/Model/movie.dart';
import 'package:http/http.dart' as http;


class MovieService {
  final String apiKey = '90be9310';
  final String baseUrl = 'https://www.omdbapi.com/';

  // Fetch a list of movies based on a search query
  Future<List<Movie>> searchMovies(String query) async {
    final url = '$baseUrl?s=$query&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['Response'] == 'True') {
        List<Movie> movies = (data['Search'] as List)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        return movies;
      } else {
        throw Exception('No movies found');
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
