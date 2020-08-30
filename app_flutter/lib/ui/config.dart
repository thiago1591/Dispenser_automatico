import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _readData().then((data) {
        setState(() {
          remedios = json.decode(data);
        });
      });
      _readData2().then((data) {
        setState(() {
          horasFB = json.decode(data);
        });
      });
    });  
  }

  List keys = [];
  List values = [];
  String hora = "";
  String nome = "";
  final dBRef = FirebaseDatabase.instance.reference();
  Map<String, dynamic> remedios = Map();
  final textController = TextEditingController();
  String horaFB;
  List horasFB = [];

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  }

  void writeFirebase() {
    for (int i = 0; i < horasFB.length; i++) {
      dBRef.child('horarios').child('$i').set({'$i': horasFB[i]});
      print(horasFB[i]);
    }
  }

  void reset() {
    textController.clear();
    nome = "";
    hora = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "Adicionar Medicamento",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.grey.withOpacity(0.4)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text("Nome do Medicamento",
                          style: TextStyle(color: Colors.blue, fontSize: 23)),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.blue))),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Colors.grey.withOpacity(0.4)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text("Horário do Medicamento",
                          style: TextStyle(color: Colors.blue, fontSize: 23)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Escolha um horário:",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      ButtonTheme(
                        minWidth: 200,
                        height: 100,
                        child: FlatButton(
                          onPressed: () async {
                            final selectedTime = await _selectTime(context);
                            setState(() {
                               String a =
                                  "${selectedTime.hour}:${selectedTime.minute}";
                              horasFB.add(a);
                              DateFormat df = DateFormat('h:mm');
                              DateTime dt = df.parse(a);
                              hora = DateFormat.Hm().format(dt);
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(hora == "" ? '00:00' : hora,
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 40,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 250,
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      nome = textController.text;
                      if (nome == "" || hora == "") {
                        infoDialog2(context);
                      } else {
                        infoDialog(context);
                      }
                    },
                    child: Text("Próximo"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool> infoDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 290,
                width: 330,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/alert.jpeg'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.teal),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Remédio Salvo!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Quer incluir outro remédio?",
                      style: TextStyle(
                          fontSize: 18, color: Colors.black87.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Center(
                              child: Text("CONCLUÍDO",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue,
                                    fontFamily: 'Montserrat',
                                  )),
                            ),
                            onPressed: () {
                              remedios[textController.text] = hora;
                              _saveData();
                              _saveData2();
                              writeFirebase();
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Main()));
                            }),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: FlatButton(
                              child: Center(
                                child: Text("ADICIONAR MAIS",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue,
                                      fontFamily: 'Montserrat',
                                    )),
                              ),
                              onPressed: () {
                                remedios[textController.text] = hora;
                                _saveData();
                                writeFirebase();
                                reset();
                                Navigator.pop(context);
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  Future<bool> infoDialog2(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 290,
                width: 330,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/alert.jpeg'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Colors.teal),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(49, 20, 30, 0),
                      child: Text(
                        "Por favor, insira o nome do medicamento e seu horário",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87.withOpacity(0.7)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Center(
                              child: Text(
                                "Voltar",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data2.json");
  }
  Future<File> _getFile2() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data3.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(remedios);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
   Future<File> _saveData2() async {
    String data = json.encode(horasFB);
    final file = await _getFile2();
    return file.writeAsString(data);
  }

  Future<String> _readData2() async {
    try {
      final file = await _getFile2();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
