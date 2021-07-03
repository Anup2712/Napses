import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:napses_todo/screens/login.dart';
import 'package:napses_todo/screens/todo.dart';
import 'package:napses_todo/screens/view.dart';
import 'package:napses_todo/util/dbhelper.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class AppDrawer extends StatefulWidget {
  AppDrawer({this.pageindex});
  final int pageindex;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var name = " ";
  int _selectedDrawerIndex = 0;
  final drawerItems = [
    DrawerItem("To-Do", Icons.sticky_note_2_outlined),
    DrawerItem("View", Icons.view_agenda),
  ];
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    setpageindex(widget.pageindex);
    super.initState();
  }

  setpageindex(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    _pageNavigator(_selectedDrawerIndex);
  }

  _pageNavigator(int page) {
    if (page == 0) {
      _navfunction(ToDo("ToDo"));
    } else if (page == 1) {
      _navfunction(ViewRecord("View Record"));
    }
  }

  _navfunction(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];

    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(Column(children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                drawerItems[i].icon,
                color: _selectedDrawerIndex == i
                    ? Color.fromRGBO(240, 134, 4, 1)
                    : Colors.blue,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            GestureDetector(
              onTap: () => _onSelectItem(i),
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  d.title,
                  style: TextStyle(
                    height: 3,
                    color: _selectedDrawerIndex == i
                        ? Color.fromRGBO(240, 134, 4, 1)
                        : Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(height: 3, color: Colors.grey),
      ]));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child: Icon(Icons.ac_unit),
                        // child: new Image.asset(
                        //   'assets/logo-dark.png',
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Napses",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          await DBHelper().deletewholedata().then((_) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Login(),
                              ),
                            );
                          });
                        },
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 3, color: Colors.grey),
              Column(children: drawerOptions),
            ],
          ),
        ),
      ),
    );
  }
}
