

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:taskmanager/screen/HomePage.dart';
import 'package:taskmanager/screen/NewTaskAdd.dart';


import 'const/ConstText.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ConstText.Consttitle,
        home: NewTaskAdd(),
      );
}

