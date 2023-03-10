import 'package:app_movies/providers/movies_provider.dart';
import 'package:app_movies/search/search_delegate.dart';
import 'package:app_movies/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          //Tarjetas principales
            CardSwipper(movies: moviesProvider.onDisplayMovies),

          //Slider de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies, 
              movieTitle: 'Populares!',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}