// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../sql/sql_helper.dart';
import '../widgets/drawer_widget.dart';
import 'Contact.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getContcts();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Flutter ListView"),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  
                  backgroundImage: AssetImage(_journals[index]["nom"]),
                ),
                title: Text(_journals[index]["nom"]),
                subtitle: Text(_journals[index]["nom"]),
                onTap: () {
                  FlutterPhoneDirectCaller.callNumber(_journals[index]["tel"].toString());
                  // showAlertDialog(context, _journals[index]["nom"]);
                  // Fluttertoast.showToast(
                  //     msg: images[index],
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM);
                },
              ),
            );
          },
          itemCount: _journals.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ));
  }

  static Future<List<Contact>> _contactList() async {
    List<Map<String, dynamic>> contactMaps = await SQLHelper.getContcts();
    List<Contact> contacts = [];

    for (var contactMap in contactMaps) {
      String nom = contactMap['nom'];
      String prenom = contactMap['prenom'];
      String tel = contactMap['tel'];

      Contact contact = Contact(nom, prenom, tel);
      contacts.add(contact);
    }

    return contacts;
  }
}

showAlertDialog(BuildContext context, String message) {
  Widget cancelButton = TextButton(
    child: Text("cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(child: Text("cancel"), onPressed: () {});
  AlertDialog alert = AlertDialog(
    title: Text("alert Dialog"),
    content: Text(message),
    actions: [cancelButton, continueButton],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
