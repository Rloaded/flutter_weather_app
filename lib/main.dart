import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app_example/bloc/bloc.dart';
import 'package:weather_app_example/views/main_frame.dart';

Future<void> main() async {
  // Regelt welche Farbe die NavagationBar und die Statusleiste haben.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xff1f1f1f),
    systemNavigationBarIconBrightness: Brightness.light, 
  ));
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xfff862e4),
        accentColor: Color(0xff3c63f2),
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        dialogBackgroundColor: Color(0xff282828),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 10,
              color: Colors.grey[300],
              fontWeight: FontWeight.w300,
            ),
            bodyText2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            )),
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc()..add(RefreshData()),
        child: MainFrame(),
      ),
    );
  }
}
