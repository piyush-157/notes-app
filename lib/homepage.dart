import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app2/widgets/ColorsCircleAvatar.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Color buttonColor = Colors.white;
  Color iconColor = Colors.black;

  TextEditingController _descriptionText = new TextEditingController();

  bool addButton = false;
  bool deleteButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(addButton == false)
                          {
                            setState(() {
                              buttonColor = Colors.black;
                              iconColor = Colors.white;
                              addButton = true;
                            });
                          }
                        else
                          {
                            setState(() {
                              buttonColor = Colors.white;
                              iconColor = Colors.black;
                              addButton = false;
                            });
                          }
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: iconColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height:45,
                        width: 250,
                        child: addButton == true ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorButton(color: Colors.red,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFFF44336;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                            ColorButton(color: Colors.blue,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFF2196F3;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                            ColorButton(color: Colors.green,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFF4CAF50;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                            ColorButton(color: Colors.yellow,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFFFFEB3B;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                            ColorButton(color: Colors.cyan,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFF00BCD4;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                            ColorButton(color: Colors.pinkAccent,onPressed: () {
                              var timeStamp = DateTime.now().millisecondsSinceEpoch;
                              int color = 0xFFEC407A;
                              FirebaseFirestore.instance.collection("notes").add({
                                "text": "Title",
                                "time": timeStamp,
                                "bgColor": color,
                                "description": ""
                              });
                            }),
                          ],
                        ) : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome to Notes",
                              style: TextStyle(
                                fontSize: 19
                              ),
                            ),
                            Text(
                              "Have a Nice Day",
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("notes").orderBy("time", descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    else
                      {
                        return GridView.builder(
                          physics: ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 250,
                              crossAxisCount: 2
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, position){
                            final now = new DateTime.now();
                            String formatter = DateFormat('dd/MM/yyyy').format(now);

                            var millis = snapshot.data.docs[position]["time"];
                            var dt = DateTime.fromMillisecondsSinceEpoch(millis);
                            var dbDate = DateFormat('dd/MM/yyyy').format(dt);
                            var printableDate ="";
                            var currentDate = formatter;
                            if(dbDate == currentDate)
                            {
                              printableDate = DateFormat('hh:mm a').format(dt);
                            }
                            else
                            {
                              printableDate = DateFormat('dd/MM/yyyy').format(dt);
                            }
                            var id = snapshot.data?.docs[position].id;
                            Color bgColor = Color(snapshot.data?.docs[position]["bgColor"]);
                            print(bgColor);
                            _descriptionText.text = snapshot.data.docs[position]["description"].toString();
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 220,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                child: Container(
                                                  child: Text(
                                                    snapshot.data.docs[position]["text"].toString(),
                                                    style: TextStyle(
                                                      fontSize: 19
                                                    ),
                                                  ),
                                                  height: 25,
                                                  width: 100,
                                                ),
                                                left: 20,
                                                top: 18,
                                              ), // TITLE TEXT
                                              Positioned(
                                                child: Text(
                                                  printableDate,
                                                  style: TextStyle(),
                                                ),
                                                left: 20,
                                                bottom: 20,
                                              ), // TIME & DATE
                                              Positioned(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pushNamed("EditNoteScreen", arguments: {"id": id});
                                                  },
                                                  child: Image.asset("assets/edit.png"),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.white,
                                                      shape: CircleBorder(),
                                                      padding: EdgeInsets.all(10)
                                                  ),
                                                ),
                                                bottom: 5,
                                                right: 0,
                                              ), // EDIT BUTTON
                                              Positioned(
                                                child: CircleAvatar(
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: bgColor,
                                                  ),
                                                  radius: 9,
                                                  backgroundColor: Colors.white,
                                                ),
                                                top: 5,
                                                right: 5,
                                              ), // TOP RIGHT CIRCLE AVATAR
                                              Positioned(
                                                child: Container(
                                                  child: Text(
                                                    snapshot.data.docs[position]["description"].toString(),
                                                    style: TextStyle(
                                                      letterSpacing: 1,
                                                      fontSize: 13,
                                                      height: 2,
                                                      overflow: TextOverflow.fade
                                                    ),
                                                    maxLines: 5,
                                                  ),
                                                  // color: Colors.red,
                                                  height: 110,
                                                  width: 120,
                                                ),
                                                left: 20,
                                                top: 45,
                                              ), // DESCRIPTION TEXT
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              color: bgColor
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Visibility(
                                        child: Material(
                                          child: InkWell(
                                            child: CircleAvatar(
                                              child: Image.asset(
                                                "assets/deleteIcon.png",
                                                height: 13,
                                                width: 13,
                                              ),
                                              backgroundColor: Colors.white,
                                              radius: 12,
                                            ),
                                            onTap: () async {
                                              print(id);
                                              await FirebaseFirestore.instance.collection("notes").doc(id).delete();
                                            },
                                          ),
                                          borderRadius: BorderRadius.circular(50),
                                          elevation: 5,
                                        ),
                                        visible: deleteButton,
                                      ),
                                      right: 0,
                                    ), // DELETE BUTTON
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(deleteButton == false)
            {
              setState(() {
                deleteButton = true;
              });
            }
          else
            {
              setState(() {
                deleteButton = false;
              });
            }
        },
        backgroundColor: Colors.white,
        child: Image.asset("assets/deleteIcon.png"),
      ),
    );
  }
}