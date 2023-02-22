import 'package:app_movies/models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
   
  const MovieSlider({Key? key, this.movieTitle, required this.movies}) : super(key: key);

  final String? movieTitle;
  final List<Movies> movies;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if (movieTitle != null)
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(movieTitle!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),

          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, int index) => _MovieContainer(movie: movies[index]) 
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieContainer extends StatelessWidget {
  const _MovieContainer({Key? key, required this.movie}) : super(key: key);

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage (
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}