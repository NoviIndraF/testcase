import 'package:flutter/material.dart';
import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:majootestcase/ui/movie_detail/movie_detail.dart';

class HomeBlocLoadedScreen extends StatefulWidget {
  final List<Data> data;

  HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  @override
  _HomeBlocLoadedScreenState createState() => _HomeBlocLoadedScreenState();
}

class _HomeBlocLoadedScreenState extends State<HomeBlocLoadedScreen> {
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    final parentHeight = MediaQuery.of(context).size.height;
    final parentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Container(
            width: parentWidth,
            height: parentHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://wallpapercave.com/wp/wp4864334.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: parentWidth,
            height: parentHeight,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: LinearGradient(colors: [
                  Colors.black45.withAlpha(200),
                  Colors.black45.withAlpha(180)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 16, top: 40),
                          width: parentWidth,
                          child: Text(
                            "Series",
                            style: TextStyle(
                                color: ColorPallete.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 16, top: 35),
                          child: IconButton(
                            icon: Icon(Icons.logout, color: ColorPallete.white,),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }));
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 6,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return (widget?.data[index]?.series != null)
                        ? movieSeriesWidget(widget.data[index], context)
                        : SizedBox.shrink();
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    width: parentWidth,
                    child: Text(
                      "TV, Movie, All",
                      style: TextStyle(
                          color: ColorPallete.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  )),
              Expanded(
                flex: 10,
                child: GridView.builder(
                  shrinkWrap: false,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return movieItemWidget(widget.data[index], context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget movieItemWidget(Data data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedCard++;
        print(data.l);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MovieDetail(data: data)));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    child: Image.network(
                  data.i.imageUrl,
                  fit: BoxFit.contain,
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(
                      data.l,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget movieSeriesWidget(Data data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedCard++;
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MovieDetail(data: data)));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    child: Image.network(
                  data.i.imageUrl,
                  fit: BoxFit.contain,
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(
                      data.l,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
