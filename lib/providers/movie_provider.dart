import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _allMovies = mockMovies;

  String _selectedCategory = 'All';
  String _searchQuery = '';

  String get selectedCategory => _selectedCategory;

  // 🔹 Set category
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // 🔹 Search
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  // 🔹 Favorites
  void toggleFavorite(Movie movie) {
    movie.isFavorite = !movie.isFavorite;
    notifyListeners();
  }

  bool isFavorite(Movie movie) => movie.isFavorite;

  // 🔹 MAIN FILTER LOGIC (category + search + favorites)
  List<Movie> get movies {
    return _allMovies.where((movie) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          movie.category == _selectedCategory ||
          (_selectedCategory == 'Favorites' && movie.isFavorite);

      final matchesSearch =
          movie.title.toLowerCase().contains(_searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // 🔹 Optional
  List<Movie> get favoriteMovies =>
      _allMovies.where((movie) => movie.isFavorite).toList();
}