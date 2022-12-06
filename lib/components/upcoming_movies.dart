import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/trending_model.dart';
import 'horizontal_cards.dart';

class UpcomingMovies extends StatefulWidget {
  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovies(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          return HorizontalCards(snapshot.data.movies);
        }
      },
    );
  }

  Future<TrendingModel> fetchMovies() async {
    final String? keyVar = DotEnv().env['MOVIE_KEY'];
    var url = Uri.parse(Uri.encodeFull((
        "https://api.themoviedb.org/3/movie/550?api_key==$keyVar")));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TrendingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the Upcoming Movies');
    }
  }
}
