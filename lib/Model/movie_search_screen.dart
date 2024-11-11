import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';

class MovieSearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search',border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    movieProvider.fetchMovies(_controller.text);
                  },
                ),
              ),
              onSubmitted: (query) => movieProvider.fetchMovies(query),
            ),
            Expanded(
              child: movieProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: movieProvider.movies.length,
                itemBuilder: (context, index) {
                  final movie = movieProvider.movies[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: movie['Poster'] != 'N/A'
                          ? Image.network(movie['Poster'], width: 50)
                          : Container(width: 150),
                      title: Text(movie['Title']),
                      subtitle:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${movie['Genre']} | ${movie['Year']}'),
                          SizedBox(height: 4), // Space between Genre/Year and Rating
                          Text(
                            'IMDB | ${movie['imdbRating'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
