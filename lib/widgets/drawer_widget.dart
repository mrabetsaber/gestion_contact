// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black12, Colors.limeAccent])),
              child: Center(
                  child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/images.jpg"),
                radius: 50,
              ))),
          ListTile(
            title: Text(
              "List des Contact ",
              style: TextStyle(fontSize: 26),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.limeAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
            onTap: () {},
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              "Ajouter Contact",
              style: TextStyle(fontSize: 26),
            ),
            leading: Icon(
              Icons.voice_chat_rounded,
              color: Colors.limeAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
             onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/addcontact");
            },
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              "Déconnexion",
              style: TextStyle(fontSize: 26),
            ),
            leading: Icon(
              Icons.home,
              color: Colors.limeAccent,
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.grey,
            ),
           
          )
        ],
      ),
    );
  }
}
