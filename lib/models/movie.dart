class Movie {
  final String id;
  final String title;
  final String category;
  final String image;
  final String description;

  // Make sure it's 'isFavorite' (American spelling)
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.description,
    this.isFavorite = false, // default false
  });
}