import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final isNarrow = screenWidth < 450; // breakpoint for responsive layout

    // Calculate image size for wide screen
    final imageWidth = isNarrow ? screenWidth : screenWidth * 0.4;
    final imageHeight = isNarrow ? imageWidth * 1.5 : imageWidth * 1.5;

    final movieInfo = Column(
      mainAxisAlignment:
          isNarrow ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment:
          isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: isNarrow ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 10),
        Text(
          movie.category,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          textAlign: isNarrow ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        Text(
          movie.description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          textAlign: isNarrow ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            provider.toggleFavorite(movie);
          },
          child: Text(
            provider.isFavorite(movie)
                ? 'Remove from Favorites'
                : 'Add to Favorites',
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isNarrow
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.image,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  movieInfo,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.image,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: movieInfo),
                ],
              ),
      ),
    );
  }
}