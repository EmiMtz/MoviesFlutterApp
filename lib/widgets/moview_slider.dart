import 'package:app_movies/models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
   
  const MovieSlider({Key? key, this.movieTitle, required this.movies, required this.onNextPage}) : super(key: key);

  final String? movieTitle;
  final List<Movies> movies;
  final Function onNextPage;

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }
  
  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if (widget.movieTitle != null)
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.movieTitle!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),

          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MovieContainer(widget.movies[index], '${widget.movieTitle}-$index-${widget.movies[index].id}') 
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieContainer extends StatelessWidget {
  const _MovieContainer(this.movie, this.heroId);

  final Movies movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
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