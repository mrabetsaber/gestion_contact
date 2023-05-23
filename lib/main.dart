import 'package:flutter/material.dart';
import 'package:gestion_contact/pages/addContact.dart';
import 'package:gestion_contact/pages/home.dart';
import 'pages/home_page.dart';
import 'pages/anime_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) => Home(),
        "/addcontact": (context) {
          return AddContact();
        }
      },
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      initialRoute: "/home",
    );
  }
}