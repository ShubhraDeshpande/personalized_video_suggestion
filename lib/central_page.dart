import 'package:flutter/material.dart';
import 'dart:math';
import 'package:personalized_video/video_app_page.dart';


class ColorGame extends StatefulWidget {
  ColorGame({Key key}) : super(key: key);

  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  /// Map to keep track of score
  final Map<String, bool> score = {};

  List<String> imageList = [
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/010.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/012.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/014.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/009.png"
  ];

  List<String> secondList =[
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/809.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/807.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/800.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/802.png"
  ];

  List<String> thirdList =[
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/460.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/306.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/063.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/698.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/024.png",
    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/681.png"

  ];
  List<String> tempp=["abv", "nihiu", "bhbi"];
  List<String> removedImages =[];
  List<Widget> dragTargetList=[];
  var labels = new Map();
  var count =0;


  // Random seed to shuffle order of items.
  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Group the pokemons"),//Text('Score ${score.length} / 6'),
          backgroundColor: Colors.pink),
      floatingActionButton: FloatingActionButton(
        focusColor: Color.fromRGBO(	208, 239, 255 , 1.0),
        foregroundColor: Colors.white70,
        backgroundColor: Color.fromRGBO(	255,157,171 , 1.0),
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            imageList=imageList;
            removedImages.clear();
            dragTargetList.clear();
            labels.clear();
            score.clear();
            seed++;
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [


          Container(height: 150, width: MediaQuery.of(context).size.width, color: Color.fromRGBO(255, 241, 234, 0.9),
            child: Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: new ListView.builder
                (
                  itemCount: imageList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return _getDraggable(imageList[index]);
                  }
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:80.0),
                child: FloatingActionButton(
                  focusColor: Color.fromRGBO(	208, 239, 255 , 1.0),
                  foregroundColor: Colors.white70,
                  backgroundColor: Color.fromRGBO(	255,157,171, 1.0),
                  child: Icon(Icons.add),
                  onPressed: (){
                    setState(() {
                      dragTargetList.add(_getDragTarget());
                      count ++;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: FloatingActionButton(
                  focusColor: Color.fromRGBO(	208, 239, 255 , 1.0),
                  foregroundColor: Colors.white70,
                  backgroundColor: Color.fromRGBO(255,157,171 , 1.0),
                  child: Text("Submit"),
                  onPressed: (){
                    print(labels);
                    _showDialog(context);
                  },
                ),
              )
            ],
          ),
          Container( height: 150, width: MediaQuery.of(context).size.width,
            child: new ListView.builder
              (
                itemCount: dragTargetList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) {
                  return dragTargetList[index];
                }
            ),
          ),


//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children:
//            tempp.map((emoji) => _buildDragTarget()).toList()
//              ..shuffle(Random(seed)),
//          )
        ],
      ),
    );
  }

  Widget _getDraggable(emoji){
    return Draggable<String>(
      data: emoji,
      //child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
      child: removedImages.contains(emoji) == true ?Container(height:0, width: 0,):
      Stack(
        children: <Widget>[

          Container( height: 100, width: 100,
            child:
            Image.network(emoji),
          ),

          Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: IconButton(
              icon: Icon(Icons.clear,),alignment: Alignment.topRight,
              onPressed: (){
                setState(() {

                  removedImages.add(emoji);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:25.0, left:25),
            child: IconButton(
              icon: Icon(Icons.play_circle_filled,size: 40,),
              alignment: Alignment.center,
              onPressed: (){
                _showVideoDialog();
              },
            ),
          )

        ],
      ),
      feedback: Container(height: 20, width: 20, child: Image.network(emoji),),
      childWhenDragging:  Icon(Icons.pets,color: Colors.black45,),
    );
  }
  Widget _getDragTarget(){
    return _buildDragTarget();
  }
  Widget _buildDragTarget() {

    List<String> temppp= [];
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        print(incoming);
        labels[count] = temppp;
        print(labels);
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child:
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 208, 215,1.0 ),
              shape: BoxShape.circle,
            ),
            child:
            Wrap(
                children: List.generate(temppp.length, (e)=>

                    Draggable<String>(
                      data: temppp[e],
                      child:
                      Container(

                        child:
                        Wrap(
                          children: List.generate(temppp.length, (e)=>
                              Container(height: 50, width: 50,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            temppp[e])
                                    )
                                )
                                //child:_getCircularAvatar(droppedImages[e])
                                ,)),
                        ),
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                      ),
                      //child:_getCircularAvatar(droppedImages[e])

                      feedback: Container(height: 20, width: 20,
                        child: Image.network(temppp[e])
                        //child:_getCircularAvatar(droppedImages[e])
                        ,),
                      childWhenDragging: Icon(Icons.pets,color: Colors.black45,) ,),
                )),
            alignment: Alignment.center,
            height: 150,
            width: 200,
          ),



        );

      },
//      onWillAccept: (data){
//        return true;},
      //=> data == emoji,

      onAccept: (data) {
        setState(() {
          temppp.add(data);
          removedImages.add(data);
        });
      },
      onLeave: (data) {
        setState(() {
          temppp.remove(data);
        });
      },
    );

  }

  void _showVideoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(height: 350,
                width: 300,child: VideoApp()),

          ],
        );
      },
    );
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("You are about to submit"),
          content: new Text("Want to see new List? "),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    setState(() {
                      if(imageList==secondList){
                        imageList=thirdList;
                      }else{
                        imageList = secondList;}
                    });
                    Navigator.of(context).pop();


                  },
                ),
              ],
            ),

            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}

Widget _getCircularAvatar(e){
  return  new Container(
      width: 190.0,
      height: 190.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(
                  e)
          )
      ));
}
class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}




//Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
//crossAxisAlignment: CrossAxisAlignment.end,
//children: imageList.map((emoji) {
//return Draggable<String>(
//data: emoji,
////child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
//child: removedImages.contains(emoji) == true ?Container(height:0, width: 0,):
//Stack(
//children: <Widget>[
//
//Container( height: 100, width: 100,
//child:
//Image.network(emoji),
//),
//
//Padding(
//padding: const EdgeInsets.only(left:60.0),
//child: IconButton(
//icon: Icon(Icons.clear,),alignment: Alignment.topRight,
//onPressed: (){
//setState(() {
//
//removedImages.add(emoji);
//});
//},
//),
//),
//Padding(
//padding: const EdgeInsets.only(top:25.0, left:25),
//child: IconButton(
//icon: Icon(Icons.play_circle_filled,size: 40,),
//alignment: Alignment.center,
//onPressed: (){
//_showDialog(context);
//},
//),
//)
//
//],
//),
//feedback: Container(height: 20, width: 20, child: Image.network(emoji),),
//childWhenDragging:  Icon(Icons.pets,color: Colors.black45,),
//);
//}).toList()),