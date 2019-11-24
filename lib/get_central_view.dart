import 'package:flutter/material.dart';

class GetCentralView extends StatefulWidget{
  GetCentralViewState createState()=> GetCentralViewState();
}

class GetCentralViewState extends State<GetCentralView>{
  bool isSuccessful = false;
  List<String> droppedList = [];
  List<String> imageList = [
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
    " https://assets.pokemon.com/assets/cms2/img/pokedex/full/005.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/010.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/012.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/014.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/009.png"
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[

          Wrap( children: List.generate(imageList.length, (e) => Draggable(child:
          Container(height: 100, width: 100, child: Image.network( imageList[e])),
              feedback: Container(height:10, width:10, color: Colors.lightBlue,),
              childWhenDragging: Container())

          )),

          Draggable(
            data: 'Flutter',
            child: Container(height: 10, width: 10,color: Colors.pink,),
            feedback: FlutterLogo(
              size: 100.0,
            ),
            childWhenDragging: Container(),
          ),

          getDragTarget()



        ],
      ),
    );
  }


  Widget getDragTarget(){
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return Center(
          child: isSuccessful
              ? Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Container(
              color: Colors.yellow,
              height: 200.0,
              width: 200.0,
              child: Center(
                  child: FlutterLogo(
                    size: 100.0,
                  )),
            ),
          )
              : Container(
            height: 200.0,
            width: 200.0,
            color: Colors.green,
          ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(() {
          isSuccessful = true;
        });
      },
    );
  }

}