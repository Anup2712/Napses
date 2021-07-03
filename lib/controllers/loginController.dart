import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:napses_todo/screens/todo.dart';
import 'package:napses_todo/util/appstate.dart';
import 'package:napses_todo/util/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  var loginStatus;
  SharedPreferences sharedPreferences;

  Future<String> loginCheck(
      String mobile, String pass, BuildContext ctx) async {
    try {
      BotToast.showLoading();
      List<Map> maps = await (DBHelper().getUSerDetails());
      if (maps.length == 0) {
        Get.snackbar("Alert!!!", "Kindly Register first",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            margin: EdgeInsets.all(10));
        BotToast.closeAllLoading();
        loginStatus = "error";
      } else {
        if (maps[0]["mobile"] == mobile && maps[0]["pass"] == pass) {
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('mobNo', maps[0]["mobile"]);
          Get.snackbar("Succcess!!!", "Login SuccessFully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              margin: EdgeInsets.all(10));
          BotToast.closeAllLoading();
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (BuildContext coontext) => ToDo("ToDo"),
            ),
          );
          loginStatus = "success";
        }else{
          Get.snackbar("Warning!!!", "Invalid Credentials",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              margin: EdgeInsets.all(10));
        }
      }
      BotToast.closeAllLoading();
    } catch (e) {
      print(e);
    }
    return loginStatus;
  }
}
