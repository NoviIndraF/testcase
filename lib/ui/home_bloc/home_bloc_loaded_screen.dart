import 'package:flutter/material.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/movie_detail/movie_detail.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<Data> data;

  HomeBlocLoadedScreen({Key key, this.data}) : super(key: key);

  int selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    var getHighMax = MediaQuery.of(context).size.height;
    var getWidthMax = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: GridView.builder(
        shrinkWrap: false,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return movieItemWidget(data[index], context);
        },
      ),
    );
  }

  Widget movieItemWidget(Data data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedCard++;
        print(data.l);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => MovieDetail(data: data)));
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
