import 'package:flutter/material.dart';
import 'package:moviesapp/services/MovieService.dart';
import 'package:moviesapp/models/MovieInfo.dart';
import 'package:moviesapp/components/PaddedText.dart';

class MovieDetail extends StatelessWidget {
  final String movieName;
  final String imdbId;

  MovieDetail({this.movieName, this.imdbId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Recherche un film ou une série',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
        backgroundColor: Colors.yellowAccent,
      ),
      body: FutureBuilder<MovieInfo>(
          future: getMovie(this.imdbId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Image.network(
                            snapshot.data.poster,
                            width: 300,
                          ),
                        ),
                        Text(snapshot.data.plot),
                        Text("Année : " + snapshot.data.year),
                        Text("Genre : " + snapshot.data.genre),
                        Text("Durée : " + snapshot.data.runtime),
                        Text("Réalisateur : " + snapshot.data.director),
                        Text("Note : " + snapshot.data.rating),
                        Text("IMDB Note : " + snapshot.data.imdbRating),
                      ]));
            } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
