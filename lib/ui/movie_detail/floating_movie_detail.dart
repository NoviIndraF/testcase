import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';

class FloatingMovieDetail extends StatelessWidget {
  final double parentWidth;
  final double parentHeight;
  final thumbHeight;
  final Data data;

  const FloatingMovieDetail(
      {Key key, this.parentWidth, this.parentHeight, this.thumbHeight, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumbWidth = thumbHeight / 1.3;
    I dataI = data.i;

    return Positioned(
      width: parentWidth,
      height: thumbHeight*2,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, right: 8),
            width: thumbWidth,
            height: thumbHeight,
            child: Hero(
              tag: "avenger",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child:
                Container(
                  width: parentWidth,
                  height: thumbHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          dataI.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), ),
            ),
          ),
        ],
      ),
    );
  }
}