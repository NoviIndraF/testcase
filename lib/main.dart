import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:flutter/foundation.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: ColorPallete.primaryLight),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBlocCubit()..fetchHistoryLogin(),
        child: MyHomePageScreen(),
      ),
    );
  }
}

class MyHomePageScreen extends StatelessWidget {
  const MyHomePageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getHighMax = MediaQuery.of(context).size.height;
    var getWidthMax = MediaQuery.of(context).size.width;

    return BlocBuilder<AuthBlocCubit, AuthBlocState>(builder: (context, state) {
      if (state is AuthBlocLoginState) {
        return LoginPage();
      } else if (state is AuthBlocLoggedInState) {
        return BlocProvider(
          create: (context) => HomeBlocCubit()..fetchingData(),
          child: HomeBlocScreen(),
        );
      }

      return Stack(children: [
        Container(
          width: getWidthMax,
          height: getHighMax,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://wallpapercave.com/wp/wp4005042.jpg"),
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
      ]);
    });
  }
}
