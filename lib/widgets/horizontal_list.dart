import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class HorizontalList extends StatelessWidget {
  final List<Movie> movies; // list of movies to display
  final String title;

  HorizontalList({Key? key, required this.movies, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // height of horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: MovieCard(movie: movie),
              );
            },
          ),
        ),
      ],
    );
  }
}