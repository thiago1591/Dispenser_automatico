import 'package:flutter/material.dart';

const color = const Color(0xff8FD9DB);
class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
List <bool> values = [false,false,false];

void _onChanged(bool value){
  setState(() {
    values[0] = value;
  });
}

void _onChanged2(bool value){
  setState(() {
    values[1] = value;
  });
}

void _onChanged3(bool value){
  setState(() {
    values[2] = value;
  });
}

String text1 = "Doses Perdidas";
String text2 = "Medicamento Acabando";

Widget linha(String text,void switc(bool value),bool _value){
  return
  Column(children: <Widget>[
    Container(
      padding: EdgeInsetsDirectional.fromSTEB(20, 30, 25, 13),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("$text", style: TextStyle(fontSize:20,color: Colors.black.withOpacity(0.8)),),
          Transform.scale(scale: 1.3,
   child:Switch(value: _value,onChanged: (bool value){switc(value);}),)
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
    linha(text1,_onChanged,values[0]),
    linha(text2,_onChanged2,values[1]),
],),  
    );
  }
}