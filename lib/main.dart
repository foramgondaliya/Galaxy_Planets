import 'package:flutter/material.dart';
import 'package:galaxy_planets/Provider/ThemeProvider.dart';
import 'package:galaxy_planets/Screens/DetailPage.dart';
import 'package:galaxy_planets/Screens/FavouritePage.dart';
import 'package:galaxy_planets/Screens/HomePage.dart';
import 'package:galaxy_planets/Screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<ThemeProvider>(context).istap)
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        'HomePage': (context) => HomePage(),
        '/': (context) => splashScreen(),
        'detailPage': (context) => DetailPage(),
        'favouritePage': (context) => favouritePage(),
      },
    );
  }
}
