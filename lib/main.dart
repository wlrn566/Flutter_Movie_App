import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail.dart';
import 'package:movie_app/pages/home.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' :(context) => const HomePage(),
        '/detail' :(context) {
          Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return DetailPage(movieCd: args['movieCd'], imageUrl: args['imageUrl'], link: args['link'],);
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
