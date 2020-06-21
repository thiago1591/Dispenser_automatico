import 'package:dispenser/ui/config.dart';
import 'package:flutter/material.dart';
const color = const Color(0xff8FD9DB);
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
      body: Stack(
        fit: StackFit.expand,

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(image: DecorationImage(
              image:AssetImage('images/welcome.png'),fit: BoxFit.fill
            )),
            child: 
            Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("Estamos aqui para garantir a sua saúde!", style: TextStyle(fontSize: 31,color: Colors.white.withOpacity(0.9)),),
              SizedBox(height:50),
              Padding(padding: EdgeInsets.fromLTRB(110, 13, 0, 0),
              child: SizedBox(
                height: 50,
                width: 117,
                child: 
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Config()));
                },
                child: Text("continuar  ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                color: color,
                shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30),
                
                      ),
              ),),)
            ],)
            ,
          
          ),
          

        ],
      ),
    ),
    );
  }
}