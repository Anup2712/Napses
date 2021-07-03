import 'package:flutter/material.dart';
import 'package:napses_todo/screens/register.dart';
import 'package:napses_todo/screens/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      onDoneLoading();
    });
  }

//Navigate to next page
  onDoneLoading() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var mobNo = sharedPreferences.getString("mobNo");
    if (mobNo != null && mobNo != "") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ToDo("ToDo"),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Registration("Registration"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          body: Center(
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
