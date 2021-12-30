import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/models/movie_response.dart';

class MovieDetail extends StatefulWidget {
  final Data data;
  MovieDetail({Key key, @required this.data}) : super(key: key);

  State<StatefulWidget> createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final parentWidth = MediaQuery.of(context).size.width;
    final appBarHeight = parentHeight / 2.5;
    final thumbHeight = appBarHeight / 1.0;
    final thumbWidth = parentWidth / 1.8;

    final double seriesWidth = thumbWidth * 0.75;
    final double seriesHeight = thumbHeight * 0.5;
    I dataI = widget.data.i;
    List<Series> listSeries = widget.data.series;
    int seriesLenght = (widget?.data?.series != null) ? listSeries.length : 0;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: parentHeight * 1.3,
        color: ColorPallete.black,
        child: Stack(
          children: [
            Container(
              width: parentWidth,
              height: parentHeight/2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(dataI.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: parentWidth,
              height: parentHeight/2,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(colors: [
                    Colors.black45.withAlpha(150),
                    Colors.black45.withAlpha(130)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),

            Column(
              children: [
                Center(
                  child: Container(
                    color: ColorPallete.black,
                    margin: EdgeInsets.only(top: thumbHeight / 5),
                    child: Hero(
                      tag: "movie detail",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          width: thumbWidth,
                          height: thumbHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(dataI.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 24, bottom: 8),
                    child: Text(
                      widget.data.l,
                      style: TextStyle(
                          fontSize: 24,
                          color: ColorPallete.primaryLight,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      widget.data.q,
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorPallete.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Rank : " + widget.data.rank.toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: ColorPallete.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                  (widget.data.vt == null)
                                      ? "-"
                                      : widget.data.vt.toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: ColorPallete.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: ColorPallete.white.withOpacity(0.2),
                          margin: EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                    (widget.data.year == null)
                                        ? "Tahun : -"
                                        : "Tahun : "+ widget.data.year.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: ColorPallete.white),
                                    textAlign: TextAlign.right),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                  (widget.data.yr == null)
                                      ? "-"
                                      : widget.data.yr.toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: ColorPallete.white),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                    Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 16, bottom: 16, top: 20),
                    child: Text(widget.data.s,
                        style: TextStyle(color: ColorPallete.white))),

                seriesLenght==0
                    ? SizedBox()
                    : Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(16),
                    child: Text("Series",
                        style: TextStyle(color: ColorPallete.white, fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.left,
                    )),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: seriesLenght,
                    itemBuilder: (BuildContext context, int index) => Card(
                      child: movieSeriesWidget(
                          listSeries[index], context, seriesHeight, seriesWidth),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget movieSeriesWidget(Series series, BuildContext context,
      double seriesHeight, double seriesWidth) {
    return GestureDetector(
      child: Container(
        width: seriesWidth,
        height: seriesHeight,
        child: Column(
          children: [
            Container(
              color: ColorPallete.black,
              child: Hero(
                tag: "avenge rss",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: seriesWidth,
                    height: seriesHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(series.i.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(4),
                child: Text(
                  series.l,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
