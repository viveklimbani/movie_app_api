import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/trending_model.dart';
import '../components/horizontal_cards.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final searchController = TextEditingController();
  String movieName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<TrendingModel> fetchMovies() async {
    final String? keyVar = DotEnv().env['MOVIE_KEY'];
    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/550?api_key==$keyVar&language=en-US&query=$movieName&include_adult=false");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TrendingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the trending Movies');
    }
  }

  // this widget shows not found image
  Widget _notFoundWidget() {
    return Center(
      child: Image.asset('assets/images/not_found.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Enter Movie name'),
                  controller: searchController,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                // color: Colors.pink[200],
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (searchController.text != '') {
                    setState(() {
                      movieName = searchController.text;
                      fetchMovies();
                    });
                  } else {
                    setState(() {
                      movieName = '';
                    });
                  }
                },
                child: const Text('Search'),
              ),
            ),
            movieName == ''
                ? Expanded(
                    child: _notFoundWidget(),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: fetchMovies(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return _notFoundWidget();
                        } else {
                          final List? movieData = snap.data?.movies;
                          movieData?.removeWhere(
                              (item) => item['poster_path'] == null);
                          if (movieData == []) {
                            return _notFoundWidget();
                          } else {
                            return HorizontalCards(movieData!);
                          }
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
