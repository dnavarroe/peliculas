import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/theme/app_theme.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //TODO: cambiar luego por una instancia de movie
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;


    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
           SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _OverView(movie: movie,),
              CastingCards(movieId: movie.id,)

            ])
          )

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;
  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace:  FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            movie.title, 
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          )
          ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
  const _PosterAndTitle({super.key, required this.movie});  

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          const SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width*0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
          
                Row(
                  children: [
                     const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                     const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.caption)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  final Movie movie;
  const _OverView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child:  Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodyText1
      ),

    );
  }
}