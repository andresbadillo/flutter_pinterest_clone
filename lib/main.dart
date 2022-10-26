import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinterest_grid_clone/src/pages/pinterest_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: PinterestPage(),
    );
  }
}
