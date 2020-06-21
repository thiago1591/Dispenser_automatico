import 'package:flutter/material.dart';

const color = const Color(0xff8FD9DB);
class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
bool _value = false;
bool _value2 = false;
bool _value3 = false;

void _onChanged(bool value){
  setState(() {
    _value = value;
  });
}

void _onChanged2(bool value){
  setState(() {
    _value2 = value;
  });
}

void _onChanged3(bool value){
  setState(() {
    _value3 = value;
  });
}

String text1 = "Doses Perdidas";
String text2 = "Medicamento Acabando";
String text3 = "Mudanças de Agenda";

Widget linha(String text,void a(bool value),bool _value){
  return
  Column(children: <Widget>[
    Container(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 25, 13),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("$text", style: TextStyle(fontSize:20,color: Colors.black.withOpacity(0.8)),),
          Transform.scale(scale: 1.3,
   child:Switch(value: _value,onChanged: (bool value){a(value);}),)
        ],),
    ),
    Divider(thickness: 1,),
  ],);
}
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferências de notificações",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: color,
        elevation: 4,
      ),
      body:Column(children: <Widget>[ 
        SizedBox(height: 20,),    
    linha(text1,_onChanged,_value),
    linha(text2,_onChanged2,_value2),
    linha(text3,_onChanged3,_value3),
],),  
    );
  }
}