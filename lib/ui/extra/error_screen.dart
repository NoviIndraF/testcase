import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sync_problem_rounded,
              color: Colors.black26,
              size: 40.0,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: textColor ?? Colors.black),
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
                            icon: Icon(Icons.refresh_sharp),
                          ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
