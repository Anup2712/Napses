import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:napses_todo/models/tdToDB.dart';
import 'package:napses_todo/util/appstate.dart';
import 'package:path_provider/path_provider.dart';

class TodoController extends ChangeNotifier {
  TDDataToDB tsDataToDB = TDDataToDB();
  var timestamp;
  var prefs;
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  Future pickImage() async {
    try {
      PickedFile image;
      image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 30);
      var timestampImage = DateTime.now().millisecondsSinceEpoch;
      String imageName = "IMG_" + timestampImage.toString() + ".jpg";

      String dir = (await getApplicationDocumentsDirectory()).path;
      String newPath = path.join(dir, imageName);
      try {
        await File(image.path).copy(newPath).then((f) {
          tsDataToDB.chrvpicPath = imageName;
          tsDataToDB.imagePath = f.path;
          print(f.path);
          BotToast.showLoading();
          Future.delayed(Duration(seconds: 1))
              .then((value) => getCurrentLocation());
        });
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    tsDataToDB.decLatitude = position.latitude;
    tsDataToDB.decLongitude = position.longitude;
    BotToast.closeAllLoading();
    notifyListeners();
  }
}
