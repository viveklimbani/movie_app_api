import 'package:flutter/material.dart';
import 'package:movie_app/common/resources/colors.dart';
import 'package:movie_app/common/widget/custom_textfield.dart';

import 'common/resources/images.dart';
import 'common/resources/styles.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  List moviePoster = [
    Images.ic1,
    Images.ic2,
    Images.ic3,
    Images.ic4,
    Images.ic5,
    Images.ic6,
    Images.ic7,
    Images.ic8,
  ];

  List movieName = [
    "R Rajkumar",
    "Kick",
    "Mission Impossible",
    "Gabbar is back",
    "Ek Tha Tiger",
    "Raanjhana",
    "Dhoom 3",
    "Thappad",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getMainLayout,
    );
  }

  get getMainLayout => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "HDMoviesHub",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 56,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Trending Movies",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              getTrendingMovieList,
              const SizedBox(height: 20),
              getSearchBox,
              const SizedBox(height: 20),
              getMoviesGrid,
            ],
          ),
        ),
      );

  get getTrendingMovieList => Container(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: moviePoster.length,
            itemBuilder: (context, index) {
              return getSingleMovieCard(context, index);
            }),
      );

  Widget getSingleMovieCard(BuildContext context, int index) {
    var item = moviePoster[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 02),
      child: Image.asset(item),
    );
  }

  get getSearchBox => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFieldSearchCustom(
          hintText: "Search Movie by name",
        ),
      );
  get getMoviesGrid => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: moviePoster.length,
        itemBuilder: (context, index) {
          return getSingleMovieGrid(context, index);
        },
      );

  Widget getSingleMovieGrid(BuildContext context, int index) {
    var item = moviePoster[index];
    // var movieDetails = movieName[index];
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MAColors.whiteColor, width: 2),
            ),
            child: Column(
              children: [
                Expanded(child: Image.asset(item)),
                const SizedBox(
                  height: 05,
                ),
                Center(
                  child: Text(
                    movieName[0] ?? "",
                    style: TextStyles.heading4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
