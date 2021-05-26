import 'dart:async';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';

import '../constants.dart';
import '../modules/dialog.dart';
import '../modules/elements/header.dart';

String problem = '',
    recomendation = '',
    category = '',
    fotopath = '',
    location = '';
bool errorP = false, errorC = false, errorF = false, errorL = false;
bool isUploading = false;
double lat,lon;
class Forma extends StatefulWidget {

  static String routeName = 'sendForma';
  //final DatabaseReference db = FirebaseDatabase(databaseURL: 'https://urban-feedback-default-rtdb.europe-west1.firebasedatabase.app').reference();

  @override
  _FormaState createState() => _FormaState();
}

class _FormaState extends State<Forma> {


  File _image;
  final picker = ImagePicker();


  Future getImage({bool isCamera = false}) async {
    final pickedFile = await picker.getImage(source: isCamera? ImageSource.camera:ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fotopath = _image.path;
        errorF=false;
        print('image ' + fotopath);
      } else {
        print('No image selected.');
      }
    });
  }

  showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyBgmBTDkqf69_PerM7j-nkgM0_mVM0OnTM",displayLocation: LatLng(59.939207, 30.315374),)));

    // Handle the result in your way
    print('location ' + result.toString());
    print('location.formattedAddress ' + result.formattedAddress);
    setState(() {
      location = result.formattedAddress;
      lat = result.latLng.latitude;
      lon = result.latLng.longitude;
      errorL=false;
    });
  }
  void SendData() async {
    final FirebaseDatabase database = FirebaseDatabase(databaseURL: 'https://urban-feedback-default-rtdb.europe-west1.firebasedatabase.app');

    //database.reference().child('problems');

    DatabaseReference dbRef = database.reference().child('problems');
    print('firebase connected');

    //FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    String name = fotopath.split('/').last;
    print('name ' + name);
    firebase_storage.Reference firebaseStorageRef =
    firebase_storage.FirebaseStorage.instance.ref().child('photos/$name');
    print('firebase storage inited');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fotopath});

    firebase_storage.UploadTask uploadTask =
    firebaseStorageRef.putFile(io.File(fotopath), metadata);
    print('upload task created');

    firebase_storage.TaskSnapshot taskSnapshot = await Future.value(uploadTask);

    print('send started');
    taskSnapshot.ref.getDownloadURL().then((value) {
      dbRef.push().set({
        "category": category,
        "problem": problem,
        "location": location,
        "recommendation": recomendation == null ? '' : recomendation,
        "photo_url": value,
        'lat':lat,
        'lon':lon
      }).then((value) {
        setState(() {
          isUploading = false;
        });
        print('send completed');

        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: "Форма отправлена!",
            description: "Благодарим за отправку проблемы.",
            buttonText: "Продолжить",
          ),
        );
      });
    });
  }

  Proverka() {
    if(isUploading)
      return;
    setState(() {
      isUploading = true;
    });
    if (problem == '') {
      print('No problem');
      setState(() {
        errorP = true;
      });
    } else
      setState(() {
        errorP = false;
      });
    if (category == '') {
      print('No category');
      setState(() {
        errorC = true;
      });
    } else
      setState(() {
        errorC = false;
      });
    if (fotopath == '') {
      print('No fotopath');
      setState(() {
        errorF = true;
      });
    } else
      setState(() {
        errorF = false;
      });
    if (location == '') {
      print('No location');
      setState(() {
        errorL = true;
      });
    } else
      setState(() {
        errorL = false;
      });
    print('errorP = ' + errorP.toString());
    print('errorC = ' + errorC.toString());
    print('errorF = ' + errorF.toString());
    print('errorL = ' + errorL.toString());
    if (errorP || errorC || errorF || errorL) {
      setState(() {
        isUploading = false;
      });
      return;
    }
    else
      SendData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,title: Text('Сообщение'),),
        body: SafeArea(
          child: ListView(
            children: [
              //Header(text:'Сообщение'),
              Question('Категория проблемы *'),
              Category(),
              Question('Фотография проблемы *'),
              Foto(getImage),
              Question('Описание проблемы *'),
              TextInput1(),
              Question('Геолокация *'),
              Location(showPlacePicker),
              Question('Рекомендация по решению проблемы'),
              TextInput2(),
              Send(Proverka)
            ],
          ),
        ));
  }
}




class Foto extends StatelessWidget {
  Function getImage;

  Foto(Function getImage) {
    this.getImage = getImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: errorF ? Colors.red : Colors.grey,
              )),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: FlatButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => PhotoD(getImg: getImage,
                ),
              );
            },
            child: Row(
              children: [
                Icon(CupertinoIcons.photo_camera),
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                        fotopath == '' ? 'Добавить фото' : 'Фото выбрано',
                        style: Constants().accenttext))
              ],
            )));
  }
}

class Question extends StatelessWidget {
  String text;

  Question(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Text(text, style: Constants().maintext));
  }
}

class TextInput1 extends StatefulWidget {
  @override
  _TextInput1State createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: TextField(
          onChanged: (String text) {
            problem = text;
          },
          style: Constants().maintext,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(color: errorP ? Colors.red : Colors.grey)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: 'Опишите проблему'),
        ));
  }
}

class TextInput2 extends StatefulWidget {
  @override
  _TextInput2State createState() => _TextInput2State();
}

class _TextInput2State extends State<TextInput2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: TextField(
          onChanged: (String text) {
            recomendation = text;
          },
          style: Constants().maintext,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Оставьте свою рекомендацию'),
        ));
  }
}

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String val = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: errorC ? Colors.red : Colors.grey))),
        child: DropdownButton<String>(
          underline: Align(),
          hint: Text('Выберите категорию'),
          value: val == '' ? null : val,
          items: problems.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (String value) {
            category = value;
            setState(() {
              errorC=false;
              val = value;
            });
          },
        ));
  }
}

List<String> problems = <String>[
  'Дороги',
  'Здания',
  'Парки и скверы',
  'Сфетофоры',
  'Пешеходные дорожки',
  'Остановки'
];

class Location extends StatelessWidget {
  Function showPlacePicker;

  Location(Function function) {
    this.showPlacePicker = function;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: errorL ? Colors.red : Colors.grey,
              )),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: FlatButton(
            onPressed: showPlacePicker,
            child: Row(
              children: [
                Icon(CupertinoIcons.location),
                Expanded(
                    child: Text(
                        location == ''
                            ? 'Выбрать геолокацию'
                            : 'Выбранная локация: ' + location,
                        style: Constants().accenttext))
              ],
            )));
  }
}

class Send extends StatelessWidget {
  Function func;

  Send(Function func) {
    this.func = func;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: func,
        child: Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Constants.accent),
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            padding: EdgeInsets.all(16),
            child: isUploading?
            CircularProgressIndicator(backgroundColor: Colors.white30,)
                :Text('Отправить сообщение', style: Constants().buttontext)));
  }
}

class PhotoD extends StatelessWidget {
  Function getImg;

  PhotoD({@required this.getImg});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    const double padding = 16.0;
    const double avatarRadius = 40.0;
    return Container(
        padding: EdgeInsets.only(
          top: avatarRadius + padding,
          left: padding,
          right: padding,
        ),
        margin: EdgeInsets.only(top: avatarRadius),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              )
            ]),
        child:
        Column(mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                'Выберите источник фото',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 24.0),
              Align(
                  alignment: Alignment.center,
                  child: FlatButton(

                    onPressed: () {
                      getImg(isCamera: true);
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text("Камера"),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: FlatButton(

                    onPressed: () {
                      getImg(isCamera: false);
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text("Галерея"),
                  ))
            ]));
  }
}