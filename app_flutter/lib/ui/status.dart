import "package:flutter/material.dart";

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {

  Widget text(String text){
return
Text("$text" ,style:TextStyle(fontSize:21,color: Colors.black.withOpacity(0.5)));
}
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/graf.png');
    Image image = Image(image: assetImage,width: 120,height: 120,);
    return Scaffold(
        body: Container(
          width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: image),
              Padding(padding: EdgeInsets.only(top:50),
              child: Column(children: <Widget>[
              text("Aqui haverá gráficos, números e"),
              text("tabelas!"),
              Divider(),
              text("Depois de confirmar seus primeiros"),
              text("remédios, você encontrará todos os"),
              text("seus registros antigos aqui"),
              ],),)
        ],
      ),
    ));
  }
}
