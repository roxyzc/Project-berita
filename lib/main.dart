import 'package:berita/views/index.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Flutter demo", home: MainPage()
        // routes: <String, WidgetBuilder>{
        // "details":(context) => const DetailsPage())
        // "main": ((context) => const MainPage())
        // });
        );
  }
}
