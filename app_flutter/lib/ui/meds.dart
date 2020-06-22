import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:flutter/material.dart";

import 'config.dart';

const color = const Color(0xff8FD9DB);

class Meds extends StatefulWidget {
  @override
  _MedsState createState() => _MedsState();
}

enum pop { remove }

class _MedsState extends State<Meds> {
  Map<String, dynamic> remedios = Map();
  List nomes = [];
  List horarios = [];
  List pills = [
    "pill1","pill2","pill3","pill4","pill5","pill1","pill2",
    "pill3","pill4","pill5","pill1","pill2","pill3"
  ];
  final dBRef = FirebaseDatabase.instance.reference();

  void removerFirebase(int index) {
    dBRef.child('horarios').child('$index').remove();
  }

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      if (this.mounted) {
        setState(() {
          remedios = json.decode(data);
          nomes = remedios.keys.toList();
          horarios = remedios.values.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
            width: double.infinity,
            color: color,
            child: (Column(
              children: <Widget>[
                SizedBox(
                  height: 38,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OutlineButton(
                      shape: StadiumBorder(),
                      textColor: Colors.black.withOpacity(0.8),
                      child: Text(
                        'ADD+',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.8),
                          style: BorderStyle.solid,
                          width: 2),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Config()));
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Visão Geral",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Medicação",
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ],
            )),
          ),
        ),
        Flexible(
            flex: 6,
            child: ListView.builder(
                itemCount: remedios.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                      child: Card(
                    child: ListTile(
                        onTap: () {},
                        title: Text(nomes[index]),
                        subtitle: Text('Horário: ${horarios[index]}'),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/${pills[index]}.png'),
                        ),
                        trailing: PopupMenuButton<pop>(
                          onSelected: (a) {
                            print(index);
                            String key = nomes[index];

                            if (this.mounted) {
                              setState(() {
                                _removeData(key);
                                removerFirebase(index);
                              });
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<pop>>[
                            const PopupMenuItem<pop>(
                              value: pop.remove,
                              child: Text("Remover"),
                            )
                          ],
                        )),
                  ));
                })),
      ],
    ));
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data2.json");
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> _removeData(String key) async {
    print(key);
    setState(() {
      remedios.remove("$key");
    });
    print(remedios);
    String data = json.encode(remedios);
    final file = await _getFile();
    return file.writeAsString(data);
  }
}
