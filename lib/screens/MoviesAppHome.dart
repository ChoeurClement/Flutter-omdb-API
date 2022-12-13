import 'package:flutter/material.dart';
import 'package:moviesapp/components/MovieList.dart';
import 'package:moviesapp/screens/MovieDetail.dart';
import 'package:moviesapp/services/MovieService.dart';
import 'package:moviesapp/models/Movie.dart';
import 'package:flutter/services.dart';

class MoviesAppHome extends StatefulWidget {
  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();
}

class MoviesAppHomeState extends State<MoviesAppHome> {
  final searchTextController = new TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void itemClick(Movie item) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetail(
                movieName: item.title,
                imdbId: item.imdbID,
              )),
    );
  }

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
        body: Column(
          children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: searchTextController,
                    decoration:
                        InputDecoration(hintText: 'Exemple : Harry potter'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.blueAccent,
                  tooltip: 'Rechercher',
                  onPressed: () {
                    setState(() {
                      searchText = searchTextController.text;
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    });
                  },
                ),
              ]),
              padding: EdgeInsets.all(60),
            ),
            if (searchText.length > 0)
              FutureBuilder<List<Movie>>(
                  future: searchMovies(searchText),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: MovieList(
                              movies: snapshot.data,
                              itemClick: this.itemClick));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
          ],
        ));
  }
}
