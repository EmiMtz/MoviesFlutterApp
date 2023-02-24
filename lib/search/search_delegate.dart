import 'package:app_movies/models/models.dart';
import 'package:app_movies/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  Widget _EmptyContainer() {
    return const Center(
        child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 100,),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {//el query es lo que trae en el texto del search bar
      return _EmptyContainer();
    } 

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( _, AsyncSnapshot<List<Movies>> snapshot) {
        if(!snapshot.hasData) return _EmptyContainer();

        final movie = snapshot.data!;

        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: ( _, int index) => _MovieItem(movie[index])
        );
      } 
    );
  }

}

class _MovieItem extends StatelessWidget {

  final Movies movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}