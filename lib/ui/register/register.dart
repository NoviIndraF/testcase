import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majootestcase/assets/color_pallete.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/database/dbhelper.dart';
import 'package:majootestcase/models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _usernameController = TextController();
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
      body:  Stack(
        children : [
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Register Akun',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorPallete.light,
                    ),
                  ),
                  Text(
                    'Silahkan Register terlebih dahulu',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorPallete.light,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _form(),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: 'Register',
                    onPressed: handleRegister,
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          ],
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
            controller: _usernameController,
            label: 'Username',
            hint: 'username',
          ),SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
            },
          ),SizedBox(
            height: 10,
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

  void handleRegister() async {
    final _username = _usernameController.value;
    final _email = _emailController.value;
    final _password = _passwordController.value;
    if (formKey.currentState?.validate() == true &&
        _email != null &&
        _password != null
    ) {
      formKey.currentState.save();
      var user = new User(
          userName: _username,
          email : _email,
          password:_password);

      var database = new DbHelper();
      database.insertUser(user);

      Fluttertoast.showToast(
          msg: "Register Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER
      );

      Navigator.of(context).pop();
      }else{
        print("Gagal input");
      }
    }
  }