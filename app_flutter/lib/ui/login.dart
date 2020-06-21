import 'dart:async';
import 'package:dispenser/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
        color: Colors.blue,
        home: new Splash(),
        );
    }
}

class Splash extends StatefulWidget {
    @override
    SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
    Future checkFirstSeen() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool _seen = (prefs.getBool('seen') ?? false);

        if (_seen) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new Main()));
        } else {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new Welcome()));
        }
    }

    @override
    void initState() {
        super.initState();
        new Timer(new Duration(milliseconds: 200), () {
        checkFirstSeen();
        });
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
        body: new Center(
            child: new Text('Loading...'),
        ),
        );
    }
}

