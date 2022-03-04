import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app2/widgets/AppBarIcons.dart';
import 'package:notes_app2/widgets/BottomEditScreenButtons.dart';
import 'package:notes_app2/widgets/ColorsCircleAvatar.dart';

class EditNoteScreen extends StatefulWidget {

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  TextEditingController titleText_ = new TextEditingController();
  TextEditingController desText_ = new TextEditingController();
  var id;
  String imagePicker = "assets/greyImagePicker.png";
  String editText = "assets/greyEditText.png";
  String mic = "assets/greyMic.png";
  String gallery = "assets/blackGallery.png";
  String camera = "assets/blackCamera.png";
  String addText = "assets/blackAddText.png";

  Color imagePickerColor = Colors.white;
  Color editTextColor = Colors.white;
  Color micColor = Colors.white;
  Color galleryColor = Colors.white;
  Color cameraColor = Colors.white;
  Color addTextColor = Colors.white;
  int textColor = 0xFF000000;

  bool imagePickerButton = false;
  bool editTextButton = false;
  bool micButton = false;
  bool galleryButton = false;
  bool cameraButton = false;
  bool addTextButton = false;

  bool imagePicker_ = false;
  bool editText_ = false;
  bool colorContainer = false;
  Color bgColor;


  getData(id) async{
    await FirebaseFirestore.instance.collection("notes").doc(id).get().then((value){
      print(value["text"]);
      setState(() {
        titleText_.text = value["text"];
        desText_.text = value["description"];
        bgColor = Color(value["bgColor"]);
      });
    });
  }

  showAlert(context)
  {
    AlertDialog dialog = new AlertDialog(
      title: Text("Alert!!"),
      content: Text("Are you sure you want to delete this note?"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance.collection("notes").doc(id).delete();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("HomePage");
          },
          child: Text("Yes"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text("No"),
        ),
      ],
    );
    
    showDialog(
      context: context,
      builder: (BuildContext context){
        return dialog;
      }
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Map args = ModalRoute.of(context)?.settings.arguments as Map;
      if(args != null)
        {
          setState(() {
            id = args["id"];
            getData(id);
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          AppBarIcons(
            image: "backArrow.png",
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("HomePage");
            },
          ),
          SizedBox(
            width: 55,
          ),
          AppBarIcons(
            image: "undo.png",
            onPressed: () {},
          ),
          AppBarIcons(
            image: "redo.png",
            onPressed: () {},
          ),
          AppBarIcons(
            image: "deleteIcon.png",
            onPressed: () {
              showAlert(context);
            },
          ),
          AppBarIcons(
            image: "save.png",
            onPressed: () async {
              await FirebaseFirestore.instance.collection("notes").doc(id).update({
                "text": titleText_.text,
                "description": desText_.text,
                "textColor": textColor,
              });
              Fluttertoast.showToast(
                  msg: "Saved",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
            child: ListView(
              children: [
                TextField(
                  style: TextStyle(
                    fontSize: 30
                  ),
                  controller: titleText_,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: bgColor,
                    border: InputBorder.none,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  style: TextStyle(
                    color: Color(textColor),
                  ),
                  controller: desText_,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter Your Text Here",
                    border: InputBorder.none,
                    fillColor: bgColor,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: BottomEditScreenButtons(
              image: imagePicker,
              color: imagePickerColor,
              onPressed: () {
                setState(() {
                  if(imagePickerButton == false)
                    {
                      imagePicker = "assets/whiteImagePicker.png";
                      imagePickerColor = Colors.black;
                      imagePicker_ = true;
                      imagePickerButton = true;
                      editText_ = false;
                      editText = "assets/greyEditText.png";
                      editTextColor = Colors.white;
                      colorContainer = false;
                    }
                  else
                    {
                      imagePicker = "assets/greyImagePicker.png";
                      imagePickerColor = Colors.white;
                      imagePicker_ = false;
                      imagePickerButton = false;
                    }
                });
              }
            ),
            bottom: 15,
            left: 15,
          ),
          Positioned(
            child: BottomEditScreenButtons(
              image: editText,
              color: editTextColor,
              onPressed: () {
                if(editTextButton == false)
                {
                  setState(() {
                    editText = "assets/whiteEditText.png";
                    editTextColor = Colors.black;
                    editText_ = true;
                    editTextButton = true;
                    imagePicker_ = false;
                    imagePicker = "assets/greyImagePicker.png";
                    imagePickerColor = Colors.white;
                  });
                }
                else
                {
                  setState(() {
                    editText = "assets/greyEditText.png";
                    editTextColor = Colors.white;
                    editText_ = false;
                    editTextButton = false;
                    colorContainer = false;
                  });
                }
              },
            ),
            bottom: 15,
            left: 85,
          ),
          Positioned(
            child: BottomEditScreenButtons(
              image: mic,
              color: micColor,
              onPressed: () {
                if(micButton == false)
                {
                  setState(() {
                    mic = "assets/whiteMic.png";
                    micColor = Colors.black;
                    micButton = true;
                  });
                }
                else
                {
                  setState(() {
                    mic = "assets/greyMic.png";
                    micColor = Colors.white;
                    micButton = false;
                  });
                }
              },
            ),
            bottom: 15,
            left: 155,
          ),
          Positioned(
            child: Visibility(
              visible: imagePicker_,
              child: Row(
                children: [
                  BottomEditScreenButtons(
                    image: gallery,
                    color: galleryColor,
                    onPressed: () {},
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            left: 15,
            bottom: 80,
          ),
          Positioned(
            child: Visibility(
              visible: imagePicker_,
              child: Row(
                children: [
                  BottomEditScreenButtons(
                    image: camera,
                    color: cameraColor,
                    onPressed: () {},
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            left: 15,
            bottom: 145,
          ),
          Positioned(
            child: Visibility(
              visible: editText_,
              child: Row(
                children: [
                  BottomEditScreenButtons(
                    image: addText,
                    color: addTextColor,
                    onPressed: () {},
                  ),
                  Text(
                    "Add Text",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            left: 85,
            bottom: 80,
          ),
          Positioned(
            child: Visibility(
              visible: editText_,
              child: Row(
                children: [
                  BottomEditScreenButtons(
                    image: "assets/textStyle.png",
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Text(
                    "Style",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            left: 85,
            bottom: 145,
          ),
          Positioned(
            child: Visibility(
              visible: editText_,
              child: Row(
                children: [
                  BottomEditScreenButtons(
                    image: "assets/colorCircle.png",
                    color: Colors.white,
                    onPressed: () {
                      if(colorContainer == false)
                        {
                          setState(() {
                            colorContainer = true;
                          });
                        }
                      else
                        {
                          setState(() {
                            colorContainer = false;
                          });
                        }
                    },
                  ),
                  Text(
                    "Text Color",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            left: 85,
            bottom: 210,
          ),
          Positioned(
            bottom: 280,
            left: 95,
            child: Visibility(
              visible: colorContainer,
              child: Container(
                height: 80,
                width: 290,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ColorButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFFFFFFF;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF000000;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.pink,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFE91E63;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.orange,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFFF9800;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFF44336;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF4CAF50;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.yellow,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFFFEB3B;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF2196F3;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ColorButton(
                          color: Colors.cyan,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF00BCD4;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.teal,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF009688;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.deepOrange,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFFF5722;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.brown,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF795548;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.deepPurple,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF673AB7;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.indigo,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF3F51B5;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.lime,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFFCDDC39;
                            });
                          },
                        ),
                        ColorButton(
                          color: Colors.purple,
                          onPressed: () {
                            setState(() {
                              textColor = 0xFF9C27B0;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
