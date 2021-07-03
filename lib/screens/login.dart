import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:napses_todo/controllers/loginController.dart';
import 'package:napses_todo/screens/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  var _formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  bool viewpassword = true;
  void _toggle() {
    setState(() {
      viewpassword = !viewpassword;
    });
  }

  String username = "";
  String password = "";
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 18),
                    //logo
                    Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 50),
                    //ph no
                    Container(
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          prefixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  color: Colors.black12,
                                  width: 1,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (val) {
                          if (val.isEmpty) return 'MobileNumer Required';
                          return null;
                        },
                        onSaved: (String value) {
                          username = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //password
                    Container(
                      child: TextFormField(
                        obscureText: viewpassword,
                        controller: _pass,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _toggle();
                            },
                            icon: Icon(viewpassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.vpn_key)),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  color: Colors.black12,
                                  width: 1,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (val) {
                          if (val.isEmpty) return 'Password Required';
                          return null;
                        },
                        onSaved: (String value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 10),
                    Material(
                      color: Theme.of(context).primaryColor,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: MaterialButton(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            int result = await LoginController()
                                .loginCheck(username, password, context)
                                .then((_) {});
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                          text: 'Not yet Registered?',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Sign up',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext coontext) =>
                                          Registration("Registration"),
                                    ),
                                  );
                                },
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
