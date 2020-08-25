import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const color = const Color(0xff8FD9DB);

int contador = 1;
String texto;
List nome = ["Idoso", "Thiago"];
List menssagem = ["Preciso de ajuda"];
List imagens = ["0", "1"];

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _textController = TextEditingController();

  void _reset() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Suporte",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: color,
          elevation: 4,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: contador,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/${imagens[index]}.png"),
                                )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(nome[index],
                                      style: TextStyle(fontSize: 20)),
                                  Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Text(menssagem[index])),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Divider(height: 1),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).accentColor),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {},
                        )),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enviar uma Menssagem"),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                setState(() {
                                  texto = _textController.text;
                                  print(texto);
                                  menssagem.add(texto);
                                  nome = nome.reversed.toList();
                                  menssagem = menssagem.reversed.toList();
                                  imagens = imagens.reversed.toList();
                                  contador = 2;
                                  _reset();
                                });
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
