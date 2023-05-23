// ignore_for_file: unnecessary_const, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../sql/sql_helper.dart';

class AddContact extends StatefulWidget {

  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController telController = TextEditingController();
  String _infoText = 'Renseignez vos données';
  Color _textColor = Colors.white;
  bool _notZero = false;

  void _resetFields() {
    nomController.text = "";
    prenomController.text = "";
    telController.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
      _notZero = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un nouveau contact"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: <Widget>[
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Nom ",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            offset: const Offset(1, 3),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.right,
                        controller: nomController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez votre nom';
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          hintText: "nom",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Prenom ",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            offset: const Offset(1, 3),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.right,
                        controller: prenomController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez votre prenom';
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          hintText: "perenom",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Tel ",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            offset: const Offset(1, 3),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: telController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez votre numero ';
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          hintText: "num",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createContact(nomController.text, prenomController.text,
                          int.parse(telController.text));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Ajouter",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createContact(String nom, String prenom, int tel) async {
    await SQLHelper.createContact( nom, prenom, tel);
    Navigator.of(context).pop();
    Navigator.pushNamed(context, "/home");
  }
}
