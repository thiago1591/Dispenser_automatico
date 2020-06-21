import "package:flutter/material.dart";

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/graf.png');
    Image image = Image(image: assetImage,width: 140,height: 140,);
    return Scaffold(
        body: Container(
          width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: image),
              Padding(padding: EdgeInsets.only(top:50),
              child: Column(children: <Widget>[
                Text("Aqui haverá gráficos, números e",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,color: Colors.black.withOpacity(0.55)),),
              Text("tabelas!",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,color: Colors.black.withOpacity(0.55)),),
              Divider(),
              Text("Depois de confirmar seus primeiros" ,style:TextStyle(fontSize:21,color: Colors.black.withOpacity(0.5))),
              Text("remédios, você encontrará todos os" ,style:TextStyle(fontSize:21,color: Colors.black.withOpacity(0.5))),
              Text("seus registros antigos aqui" ,style:TextStyle(fontSize:21,color: Colors.black.withOpacity(0.5))),
              ],),)
              
        ],
      ),
    ));
  }
}
