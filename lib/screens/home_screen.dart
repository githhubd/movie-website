import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/movie_card.dart';
import '../widgets/category_card.dart';
import 'details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';

final ScrollController _horizontalController = ScrollController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List> loadMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    return mockMovies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text('Movie Catalog'),
        actions: [

          IconButton(
    icon: const Icon(Icons.logout),
    onPressed: () {
      context.read<AuthProvider>().logout();
    },
  ),

          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder(
        future: loadMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final provider = Provider.of<MovieProvider>(context);
          final movies = provider.movies;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // 🔥 FEATURED
              Text(
                'Featured',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),


              TextField(
  onChanged: (value) {
    context.read<MovieProvider>().setSearchQuery(value);
  },
  decoration: InputDecoration(
    hintText: 'Search movies...',
    prefixIcon: const Icon(Icons.search),
    filled: true,
    fillColor: Theme.of(context).cardColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),
const SizedBox(height: 20),

              const SizedBox(height: 10),

              SizedBox(
  height: 350,
  child: Scrollbar(
    controller: _horizontalController,
    thumbVisibility: true, // always visible
    trackVisibility: true,
    child: ListView.builder(
      controller: _horizontalController,
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(
          movie: movie,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsScreen(movie: movie),
              ),
            );
          },
        );
      },
    ),
  ),
),

              const SizedBox(height: 20),

              // 🔥 CATEGORIES
              Text(
                'Categories',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _category(provider, 'All'),
                    _category(provider, 'Action'),
                    _category(provider, 'Drama'),
                    _category(provider, 'Sci-Fi'),
                    _category(provider, 'Favorites'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 POPULAR
              Text(
                'Popular',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Column(
                children: movies.map<Widget>((movie) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: MovieCard(
                      movie: movie,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(movie: movie),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _category(MovieProvider provider, String title) {
    return GestureDetector(
      onTap: () => provider.setCategory(title),
      child: CategoryCard(title: title),
    );
  }
}