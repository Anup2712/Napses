import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:napses_todo/screens/login.dart';
import 'package:napses_todo/util/dbhelper.dart';

class Registration extends StatefulWidget {
  Registration(this.appbarName);
  String appbarName;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  var _formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool viewpassword = true;
  bool confirmpassword = true;
  int passLength = 0;
  Color charcolor = Colors.red;
  void _toggle() {
    setState(() {
      viewpassword = !viewpassword;
    });
  }

  void _confirmtoggle() {
    setState(() {
      confirmpassword = !confirmpassword;
    });
  }

  String username = "";
  String password = "";
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

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
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(widget.appbarName),
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    //logo
                    Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
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
                          if (val.isEmpty) return 'Mobile No. Required';
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
                      // padding: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                        onChanged: (val) {
                          if (val.length == 8) {
                            setState(() {
                              charcolor = Colors.green;
                            });
                          } else {
                            setState(() {
                              charcolor = Colors.red;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //Confirm Password
                    Container(
                      child: TextFormField(
                        obscureText: confirmpassword,
                        controller: _confirmPass,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _confirmtoggle();
                            },
                            icon: Icon(confirmpassword
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
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (val) {
                          if (val.isEmpty) return 'Confirm Password Required';
                          if (val != _pass.text)
                            return 'Confirm Password Not Match';
                          return null;
                        },
                        onSaved: (String value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                      color: Theme.of(context).primaryColor,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: MaterialButton(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              int result = await DBHelper()
                                  .storeLoginDetails(
                                      mobile: username, pass: password)
                                  .then((_) {
                                Get.snackbar("Success", "User Registered",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    dismissDirection:
                                        SnackDismissDirection.HORIZONTAL,
                                    margin: EdgeInsets.all(10));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext coontext) => Login(),
                                  ),
                                );
                              });
                            }
                          }),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          text: 'Already Registered?',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
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
                                          Login(),
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
