import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      body: Center(
        child: Text(
          "Page d'accueil",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}