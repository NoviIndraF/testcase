import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/movie_detail/static_movie_detail.dart';

import 'floating_movie_detail.dart';

class MovieDetail extends StatefulWidget {
  final Data data;
  MovieDetail({Key key, @required this.data}) : super(key: key);

  State<StatefulWidget> createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetail> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.5;
    I dataI = widget.data.i;
    return Scaffold(
        body: Stack(
      children: [
        NestedScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(widget.data.l),
                backgroundColor: ColorPallete.primary,
                expandedHeight: appBarHeight,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(dataI.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: StaticMovieDetails(thumbHeight: thumbHeight, data: widget.data),
        ),
        FloatingMovieDetail(
          parentWidth: MediaQuery.of(context).size.width,
          parentHeight: parentHeight,
          thumbHeight: thumbHeight,
          data: widget.data,
        )
      ],
    ));
  }
}
