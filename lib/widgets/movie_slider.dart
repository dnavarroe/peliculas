import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  const MovieSlider({
    super.key, 
    required this.movies, 
    required this.onNextPage, 
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController =  ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent-500){
        widget.onNextPage();
      }

    });

  }

  @override
  void dispose() {



    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.movies.isEmpty){
      return Container(
        width: double.infinity,
        height: 250,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder:(_, index) {
                final movie = widget.movies[index];
                return _MoviePoster(movie: movie, heroId: '${movie.title}-$index-${movie.id}',);
                } 
            ),
          )

        ],
        
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster({required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {

    movie.heroId= heroId;

    return Container(
                  width: 130,
                  height: 190,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children:  [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
                        child: Hero(
                          tag: movie.heroId!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
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

                      Text(movie.title,
                      overflow: TextOverflow.ellipsis,
                      ),


                    ],
                  ),
                );
  }
}