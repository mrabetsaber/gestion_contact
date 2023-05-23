import 'package:flutter/material.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Anime"),) ,
      body: Center(
        child: Text("Page d'anime",
        style:Theme.of(context).textTheme.headlineLarge
      )
      ),
    );
  }
}