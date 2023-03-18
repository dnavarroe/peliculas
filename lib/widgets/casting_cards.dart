import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/screens/details_screen.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({
    super.key, 
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder:(_, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _CastCard(actor: cast[index]),
      ),
    );
      },
    );
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({
    super.key, 
    required this.actor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => _ActorPhoto(actor: actor)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(actor.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _ActorPhoto extends StatelessWidget {
  final Cast actor;
  const _ActorPhoto({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(actor.name, style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(actor.fullProfilePath),
                  height: 500,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Close', style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
          IconButton(
            onPressed: (){
              Navigator.pop(context);}, 
            icon: const Icon(Icons.keyboard_arrow_down_rounded), color: Colors.white, iconSize: 100,)
        ],
      ),
    );
  }
}
