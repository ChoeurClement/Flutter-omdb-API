import 'package:flutter/material.dart';
import 'package:moviesapp/models/Movie.dart' as models;

class MovieItem extends StatelessWidget {
  final models.Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            if (this.movie.poster != "N/A")
              Image.network(this.movie.poster, height: 100, width: 100)
          ]),
          Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(this.movie.year),
              ]),)
        ],
      ),
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration:
          new BoxDecoration(color: Colors.yellow),
    );
  }
}
