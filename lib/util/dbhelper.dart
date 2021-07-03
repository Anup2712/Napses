import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper with ChangeNotifier {
  static Database _db;
  List<String> _data = [];

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'napses.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS userlogin(
       id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, mobile TEXT, pass TEXT
    ) 
    ''').catchError((onError) {
      print(onError);
    });

    await db.execute('''
    CREATE TABLE IF NOT EXISTS todo(
       id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,todaydate TEXT, name TEXT, dept TEXT, proj TEXT,
       nara TEXT, imageName TEXT,imagePath TEXT, lat TEXT, lon TEXT, syncStatus INTEGER
    ) 
    ''').catchError((onError) {
      print(onError);
    });
  }

  Future<List<Map>> getUSerDetails() async {
    List<Map<String, dynamic>> maps = [];
    try {
      var dbClient = await (db);
      await dbClient
          .rawQuery(
              'select mobile,pass from userlogin group by mobile,pass')
          .then((value) {
        maps = value;
        return maps;
      });
    } catch (e) {
      print(e);
    }
    return maps;
  }

  Future<List<Map>> viewTDData() async {
    List<Map<String, dynamic>> maps = [];
    try {
      var dbClient = await (db);
      await dbClient
          .rawQuery(
              'select id,todaydate,name,dept,proj,syncStatus from todo group by id,todaydate,name,dept,proj,syncStatus order by todaydate desc')
          .then((value) {
        maps = value;
        return maps;
      });
    } catch (e) {
      print(e);
    }
    return maps;
  }

  Future storeLoginDetails({
    String mobile,
    String pass,
  }) async {
    int result = 0;
    try {
      BotToast.showLoading();
      var dbClient = await db;
      result = await dbClient.insert("userlogin", {
        "mobile": mobile,
        "pass": pass,
      });
      BotToast.closeAllLoading();
      print(result);
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
    }
  }

  Future storeData({
    String date,
    String name,
    String dept,
    String proj,
    String nara,
    String imagename,
    String imagepath,
    double lat,
    double lon,
    int syncStatus,
  }) async {
    int result = 0;
    try {
      BotToast.showLoading();
      var dbClient = await db;
      result = await dbClient.insert("todo", {
        "todaydate": date,
        "name": name,
        "dept": dept,
        "proj": proj,
        "nara": nara,
        "imageName": imagename,
        "imagePath": imagepath,
        "lat": lat,
        "lon": lon,
        "syncStatus": 0,
      });
      BotToast.closeAllLoading();
      print(result);
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
    }
  }

  Future<int> deletewholedata() async {
    int result = 0;
    try {
      var dbClient = await (db);
      result = await dbClient.delete('todo');
      result = await dbClient.delete('userlogin');
      print("del :" + result.toString());
    } catch (e) {
      print(e);
    }
    return result;
  }
}
