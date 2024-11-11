import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List _movies = [];
  bool _isLoading = false;

  List get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://www.omdbapi.com/?s=$query&apikey=90be9310');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _movies = data['Search'] ?? [];

      _movies = await Future.wait(_movies.map((movie) async {
        final detailsUrl = Uri.parse(
            'http://www.omdbapi.com/?i=${movie['imdbID']}&apikey=90be9310'
        );
        final detailsResponse = await http.get(detailsUrl);
        if (detailsResponse.statusCode == 200) {
          return json.decode(detailsResponse.body);
        } else {
          return movie;
        }
      }));
    } else {
      _movies = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
