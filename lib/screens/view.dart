import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:napses_todo/screens/todo.dart';
import 'package:napses_todo/util/appdrawer.dart';
import 'package:napses_todo/util/dbhelper.dart';

class ViewRecord extends StatefulWidget {
  ViewRecord(this.appbarName);
  String appbarName;
  @override
  _ViewRecordState createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  DBHelper dbHelper = DBHelper();
  List<Map> tsmap = [];
  var _textStyle = TextStyle(fontSize: 13, color: Colors.black);
  var _headerStyle =
      TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      tsmap = await (dbHelper.viewTDData());
    });
  }

  void onbackPressed(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ToDo("ToDo"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          drawer: AppDrawer(pageindex: 2),
          body: WillPopScope(
              onWillPop: () async {
                onbackPressed(context);
                throw '';
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    tsmap.length == 0
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                "No Data Available !!!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 19),
                              ),
                            ),
                          )
                        : timesheetTable(tsmap),
                  ],
                ),
              ))),
    ]);
  }

  Widget timesheetTable(List<Map> timesheet) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: Color.fromRGBO(245, 245, 245, 100),
                  height: 45,
                  child: Center(
                    child: Text(
                      "Date",
                      textAlign: TextAlign.center,
                      style: _headerStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.5),
                    ),
                    color: Color.fromRGBO(245, 245, 245, 100),
                  ),
                  child: Center(
                    child: Text(
                      "Name",
                      textAlign: TextAlign.center,
                      style: _headerStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.5),
                    ),
                    color: Color.fromRGBO(245, 245, 245, 100),
                  ),
                  child: Center(
                    child: Text(
                      "Dept",
                      textAlign: TextAlign.center,
                      style: _headerStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.5),
                    ),
                    color: Color.fromRGBO(245, 245, 245, 100),
                  ),
                  child: Center(
                    child: Text(
                      "Proj",
                      textAlign: TextAlign.center,
                      style: _headerStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 245, 100),
                        border: Border.all(
                            color: Color.fromRGBO(205, 205, 205, 1),
                            width: 0.3)),
                    child: Center(
                      child: Text(
                        "Status",
                        textAlign: TextAlign.center,
                        style: _headerStyle,
                      ),
                    )),
              ),
            ],
          ),
          for (int i = 0; i < timesheet.length; i++) ...{
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.3),
                      color: Color.fromRGBO(245, 245, 245, 100),
                    ),
                    height: 45,
                    child: Center(
                      child: Text(
                        DateFormat('dd-MMM-yy')
                            .format(DateTime.parse(timesheet[i]["todaydate"])),
                        textAlign: TextAlign.center,
                        style: _textStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.3),
                      color: Color.fromRGBO(245, 245, 245, 100),
                    ),
                    child: Center(
                      child: Text(
                        timesheet[i]["name"],
                        textAlign: TextAlign.center,
                        style: _textStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.3),
                      color: Color.fromRGBO(245, 245, 245, 100),
                    ),
                    child: Center(
                      child: Text(
                        timesheet[i]["dept"],
                        textAlign: TextAlign.center,
                        style: _textStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(205, 205, 205, 1), width: 0.3),
                      color: Color.fromRGBO(245, 245, 245, 100),
                    ),
                    child: Center(
                      child: Text(
                        timesheet[i]["proj"],
                        textAlign: TextAlign.center,
                        style: _textStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 245, 245, 100),
                          border: Border.all(
                              color: Color.fromRGBO(205, 205, 205, 1),
                              width: 0.3)),
                      child: Center(
                        child: Text(
                          timesheet[i]["syncStatus"] == 1 ? "S" : "NS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: timesheet[i]["syncStatus"] == 1
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      )),
                ),
              ],
            )
          }
        ],
      ),
    );
  }
}
