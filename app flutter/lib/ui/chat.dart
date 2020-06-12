import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

const color = const Color(0xff8FD9DB);
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool inSignIn = false;

  Future<void> handleSignIn() async
  {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, 
    accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    
      inSignIn = true;
    
  }

 
  _handleSubmitted(String text) async {
await handleSignIn();
_sendMessage(text:text);
}

void _sendMessage({String text, String imgUrl}){
Firestore.instance.collection("messages").add(
  {
    "text": text,
    "imgUrl": imgUrl,
    "senderName": _user.displayName,
    "senderPhotoUrl": _user.photoUrl
  }
);
}


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  
 

 
  
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
      body: Container(decoration: BoxDecoration(
        color: Colors.white,
      ), child: 
      Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder( 
              stream: Firestore.instance.collection("messages").snapshots(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  return Center(
                    child:  CircularProgressIndicator(),

                  );
                  default:
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder:(context,index){
                      List r = snapshot.data.documents.reversed.toList();
                      return ChatMessage(r[index].data);
                    }
                  );
                }
              },
            )
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: TextComposer(),
          )
        ],
      ),)
    );
  }


}



class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final _textController = TextEditingController();

void _reset(){
  _textController.clear();
  setState(() {
    
    _isComposing = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
                child: IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: (){},
            )),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar uma Menssagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () {
                    _handleSubmitted(_textController.text);
                    _reset();
                  } : null,
                ))
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  
  final Map<String, dynamic> data;
  
  ChatMessage(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    data["senderPhotoUrl"]),
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data["senderName"], style: TextStyle(fontSize: 20)),
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: 
                    Text(data["text"])
                    
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}