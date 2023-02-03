import 'package:flutter/material.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';

import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Peliculas en cine'),
        ),
        actions: [
          IconButton(
            onPressed: ()=>showSearch(
              context: context, 
              delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:  [
      
      
            //CardSwiper
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            
            //Listado horizontal de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              onNextPage: ()=> moviesProvider.getPopularMovies(),
            )
          ],
        ),
      )
    );
  }
}