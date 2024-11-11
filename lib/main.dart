import 'package:flutter/material.dart';
import 'package:flutter_assignment_pune_tradex/Model/movie_provider.dart';
import 'package:flutter_assignment_pune_tradex/Model/movie_search_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MovieSearchApp(),
    ),
  );
}

class MovieSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MovieSearchScreen(),
    );
  }
}
