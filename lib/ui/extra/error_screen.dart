import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final Function() retry;
  final Color textColor;
  final double fontSize;
  final double gap;
  final Widget retryButton;

  const ErrorScreen(
      {Key key,
      this.gap = 10,
      this.retryButton,
      this.message = "",
      this.fontSize = 14,
      this.retry,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getHighMax = MediaQuery.of(context).size.height;
    var getWidthMax = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: getWidthMax,
              height: getHighMax,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://wallpapercave.com/wp/wp5348559.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: getWidthMax,
              height: getHighMax,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(colors: [
                    Colors.black45.withAlpha(200),
                    Colors.black45.withAlpha(180)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sync_problem_rounded,
                    color: ColorPallete.primaryLight,
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: TextStyle(fontSize: 24, color: textColor ?? ColorPallete.white),
                  ),
                  retry == null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 180,
                            ),
                            retryButton ??
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                          create: (context) =>
                                              HomeBlocCubit()..fetchingData(),
                                          child: HomeBlocScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.refresh_sharp, color: ColorPallete.white, size: 60),
                                ),
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
