
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:m2miage/screens/login_screen.dart';
import 'package:m2miage/utils/constant.dart';
import 'package:m2miage/utils/my_scroll_behaviour.dart';
import 'dart:ui_web' as ui;
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ui.platformViewRegistry.registerViewFactory(
      'example', (_) => DivElement()..innerText = 'Hello, HTML!');
  if(kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey : "AIzaSyBsXlDdrvCzGxEnXW5zqgIiC7mu4ZZf9Lk" ,
          authDomain : "miaged-50439.firebaseapp.com" ,
          projectId : "miaged-50439" ,
          storageBucket : "miaged-50439.appspot.com" ,
          messagingSenderId : "238071767952" ,
          appId : "1:238071767952:web:e2a090c3e4f5edb3c84915" ,
          measurementId : "G-BF63D1GVCZ"
      ),
    );
  }
  else {
    await Firebase.initializeApp();

  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {

    return Observer(
      builder: (context) {
        return GetMaterialApp(
            scrollBehavior: MyScrollBehavior(),
            debugShowCheckedModeBanner: false,
            home: const LoginWithPassScreen(),
            title: "Activity",
            theme: ThemeData(fontFamily: popinsFont),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            });
      },
    );
  }

  lockScreenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
