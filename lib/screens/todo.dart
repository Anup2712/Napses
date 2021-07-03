import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:napses_todo/controllers/todoController.dart';
import 'package:napses_todo/models/tdToDB.dart';
import 'package:napses_todo/util/appdrawer.dart';
import 'package:napses_todo/util/dbhelper.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ToDo extends StatefulWidget {
  ToDo(this.appbarName);
  String appbarName;
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  var _formkey = GlobalKey<FormState>();
  TDDataToDB tsDataToDB = TDDataToDB();
  DateTime backbuttonpressedTime;
  List<String> locDropdown = [
    "Office",
    "Site",
    "Home",
  ];
  int naraLength = 0;
  int quantiLength = 0;
  int jobLength = 0;
  // SharedPreferences sharedPreferences;

  String choosedDate;
  Future<bool> backPressed() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.black);
      return false;
    }
    exit(0);
  }

  String dateTime;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  var deptName, deptId;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now().subtract(Duration(days: 3)),
        lastDate:
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMd().format(selectedDate);
        choosedDate = selectedDate.toString();
        print(choosedDate);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = DateFormat.yMMMd().format(DateTime.now());
    choosedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now());
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(widget.appbarName),
          ),
          drawer: AppDrawer(pageindex: 0),
          body: WillPopScope(
              onWillPop: () => backPressed(),
              child: Consumer<TodoController>(
                builder: (context, data, child) {
                  return data == null
                      ? CircularProgressIndicator()
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  //Date
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                      hintText: 'Select Date',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        icon: Icon(
                                          Icons.calendar_today,
                                        ),
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      tsDataToDB.tdDate = _dateController.text;
                                    },
                                    controller: _dateController,
                                  ),
                                  SizedBox(height: 10),
                                  Theme(
                                    data: ThemeData(errorColor: Colors.red),
                                    child: Container(
                                      child: TextFormField(
                                        initialValue: deptName,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          counterStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          fillColor: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSaved: (value) {
                                          tsDataToDB.name = value;
                                        },
                                        validator: (String value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Name is required';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Theme(
                                    data: ThemeData(errorColor: Colors.red),
                                    child: Container(
                                      child: TextFormField(
                                        initialValue: deptName,
                                        decoration: InputDecoration(
                                          labelText: 'Department',
                                          counterStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          fillColor: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSaved: (value) {
                                          tsDataToDB.dept = value;
                                        },
                                        validator: (String value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Dept is required';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  //Proj
                                  Theme(
                                    data: ThemeData(errorColor: Colors.red),
                                    child: Container(
                                      child: TextFormField(
                                        initialValue: deptName,
                                        decoration: InputDecoration(
                                          labelText: 'Project',
                                          counterStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          fillColor: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSaved: (value) {
                                          tsDataToDB.proj = value;
                                        },
                                        validator: (String value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Project is required';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  //Naration
                                  Theme(
                                    data: ThemeData(errorColor: Colors.red),
                                    child: Container(
                                      child: TextFormField(
                                        inputFormatters: [
                                          new LengthLimitingTextInputFormatter(
                                              100),
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Naration',
                                          counterStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          counterText:
                                              (100 - naraLength).toString() +
                                                  "/100",
                                          hintText:
                                              "Give a brief description of work (Max 100 characters)",
                                          fillColor: Colors.white,
                                        ),
                                        minLines: 2,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        onChanged: (value) {
                                          setState(() {
                                            naraLength = value.length;
                                            tsDataToDB.nara = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          // _selectNaration = value;
                                        },
                                        validator: (String value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Naration is required';
                                          }
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  //image and location
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Capture Photo : ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<TodoController>(
                                                      context,
                                                      listen: false)
                                                  .pickImage();
                                            },
                                            child: Image.asset(
                                              "assets/add.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 10, 10),
                                            child: Image.file(
                                              File(data.tsDataToDB.imagePath),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          //loc
                                          Expanded(
                                            child: Container(
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        flex: 2,
                                                        child: Container(
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0, 10, 0, 0),
                                                            padding: EdgeInsets.fromLTRB(
                                                                20, 10, 15, 10),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(data
                                                                              .tsDataToDB ==
                                                                          null
                                                                      ? "Latitude"
                                                                      : data.tsDataToDB.decLatitude >
                                                                              0
                                                                          ? data
                                                                              .tsDataToDB
                                                                              .decLatitude
                                                                              .toString()
                                                                          : "Latitude"),
                                                                )
                                                              ],
                                                            ),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            10.0)),
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          data.getCurrentLocation();
                                                        },
                                                        child: Image.asset(
                                                          "assets/location.png",
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        flex: 2,
                                                        child: Container(
                                                            margin:
                                                                EdgeInsets.fromLTRB(
                                                                    0, 10, 0, 0),
                                                            padding: EdgeInsets.fromLTRB(
                                                                20, 10, 15, 10),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(data
                                                                              .tsDataToDB ==
                                                                          null
                                                                      ? "Longitude"
                                                                      : data.tsDataToDB.decLongitude >
                                                                              0
                                                                          ? data
                                                                              .tsDataToDB
                                                                              .decLongitude
                                                                              .toString()
                                                                          : "Longitude"),
                                                                )
                                                              ],
                                                            ),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            10.0)),
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 30,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  //buttons
                                  Material(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: MaterialButton(
                                      minWidth: 200,
                                      onPressed: () async {
                                        if (_formkey.currentState.validate()) {
                                          _formkey.currentState.save();
                                          int result = await DBHelper()
                                              .storeData(
                                            date: choosedDate,
                                            name: tsDataToDB.name,
                                            dept: tsDataToDB.dept,
                                            proj: tsDataToDB.proj,
                                            nara: tsDataToDB.nara,
                                            imagename:
                                                data.tsDataToDB.chrvpicPath,
                                            imagepath:
                                                data.tsDataToDB.imagePath,
                                            lat: data.tsDataToDB.decLatitude,
                                            lon: data.tsDataToDB.decLongitude,
                                            syncStatus: 0,
                                          )
                                              .then((_) {
                                            data.tsDataToDB.imagePath = "";
                                            data.tsDataToDB.chrvpicPath = "";
                                            data.tsDataToDB.decLatitude = 0.0;
                                            data.tsDataToDB.decLongitude = 0.0;
                                            appDailog("ToDo Registered",
                                                "Saved in Database");
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                },
              )),
        )
      ],
    );
  }

  Widget appDailog(String title, String descr) {
    Alert(
      context: context,
      type: AlertType.success,
      title: title,
      image: Image.asset("assets/right.png"),
      desc: descr,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ToDo("ToDo")),
            );
          },
          width: 120,
        )
      ],
    ).show();
  }
}
