import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/database/dbhelper.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/register/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getHighMax = MediaQuery.of(context).size.height;
    var getWidthMax = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocLoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => HomeBlocCubit()..fetchingData(),
                  child: HomeBlocScreen(),
                ),
              ),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              width: getWidthMax,
              height: getHighMax,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://wallpapercave.com/wp/wp4558786.jpg"),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'Silahkan login terlebih dahulu',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      _form(),
                      SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        text: 'Login',
                        onPressed: handleLogin,
                        height: 100,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _register(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null) {
                return pattern.hasMatch(val)
                    ? null
                    : 'Masukkan e-mail yang valid';
              }
            },
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return Register();
          }));
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.white70),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    if (formKey.currentState?.validate() == true &&
        _email != null &&
        _password != null) {
      var sUser = new User(email: _email, password: _password);

      var db = new DbHelper();
      User userRetorno = await db.selectUser(sUser);
      if (userRetorno != null) {
        AuthBlocCubit authBlocCubit = AuthBlocCubit();

        print(userRetorno.userName);
        authBlocCubit.loginUser(userRetorno);
        Fluttertoast.showToast(
            msg: "Login Berhasil",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => HomeBlocCubit()..fetchingData(),
              child: HomeBlocScreen(),
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Login gagal , periksa kembali inputan anda",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    }
  }
}
