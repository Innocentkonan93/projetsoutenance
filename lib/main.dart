import 'package:flutter/material.dart';
import 'package:pharm_point/controllers/pharm_provider.dart';
import 'package:pharm_point/controllers/ville_provider.dart';

import 'package:pharm_point/screens/Pharm/map_screen.dart';
import 'package:pharm_point/screens/global_map_screen.dart';
import 'package:pharm_point/screens/ville_screen.dart';

import 'package:pharm_point/widgets/menu_item.dart';
import 'package:provider/provider.dart';

import 'screens/accueil/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VilleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PharmsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HeathPoint',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // canvasColor: Color.fromRGBO(255, 254, 229, 1),
          // fontFamily: 'RobotoCondensed',
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          MapScreen.nameRoute: (ctx) => MapScreen(null),
          VilleScreen.routeName: (ctx) => VilleScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          GlobalMapScreen.routeName: (ctx) => GlobalMapScreen()
        },
      ),
    );
  }
}
