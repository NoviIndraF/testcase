import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';

class StaticMovieDetails extends StatelessWidget {
  final thumbHeight;
  final Data data;
  const StaticMovieDetails({Key key, this.thumbHeight, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Container(
        margin: EdgeInsets.only(top: thumbHeight * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  " Data l : "+data.l,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
    " Data i : " +data.i.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data q : " +data.q,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data rank : " +data.rank.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data s : " +data.s,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data yr : " +data.yr.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data year : " +data.year.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  " Data vt : " +data.vt.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}