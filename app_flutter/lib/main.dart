
import 'package:dispenser/ui/home_page.dart';
import 'package:dispenser/ui/checkFirstSeen.dart';
import 'package:dispenser/ui/meds.dart';
import "package:flutter/material.dart";
import 'package:dispenser/ui/notif.dart';
import 'package:dispenser/ui/chat.dart';

const color = const Color(0xff8FD9DB);

void main() async {
 runApp(MyApp());
}
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  Widget callPage(int currentIndex){
    switch(currentIndex){
      case 0: return Home();
      case 1: return Meds();
      case 2: return Notif();
      case 3: return Chat();
      break;
      default:return Home();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Scaffold',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: callPage(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
  currentIndex: _currentIndex,
  
  onTap: (value){
    _currentIndex = value;
    setState(() {
      
    });
  },
  type: BottomNavigationBarType.fixed,
  
  backgroundColor: Colors.white,
  iconSize: 30 ,
  selectedFontSize: 15,
  
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Hoje'),
      
      ),
      
    BottomNavigationBarItem(
      icon: Icon(Icons.healing),
      title: Text('Meds'),
      
    ),
  
    
  
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_none),
      title: Text('Notif'),
      
      
    ),
    
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      title: Text('Ajuda'),
      
    ),
    
  ],
  
),
      )
      
    );
  }
}
