// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:napses_todo/controllers/loginController.dart';
// import 'package:napses_todo/controllers/todoController.dart';
// import 'package:napses_todo/screens/register.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => TodoController()),
//         ChangeNotifierProvider(create: (_) => LoginController()),
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         builder: BotToastInit(),
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Registration('Registration'),
//       ),
//     );

//   }
// }
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:napses_todo/controllers/loginController.dart';
import 'package:napses_todo/controllers/todoController.dart';
import 'package:napses_todo/screens/register.dart';
import 'package:napses_todo/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        title: 'Napses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
