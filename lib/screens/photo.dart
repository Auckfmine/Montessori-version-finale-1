import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_login_ui/screens/student.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:random_string/random_string.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart' as prefix0;

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  bool _isLoading = false;
  Future<List<ClassicStudent>> _handlePhoto() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var sessionID = localStorage.getString('session_id');
    var csrfToken = localStorage.getString('csrf_token');
    var csrfToken2 = localStorage.getString('csrf_token2');
    var userpk = localStorage.getString('userPk');
    //var serverid = localStorage.getString("serverid");

    String url = "http://valzyzt.cluster024.hosting.ovh.net/api/v1/student/";

    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Cookie": "$sessionID; $csrfToken",
      "X-CSRFToken": "$csrfToken2"
    });
    var body = json.decode(res.body);

    List newBody = [];
    //List sectionBody = [];
    List<ClassicStudent> students = [];
    for (var element in body) {
      if (element["parent"].toString() == userpk) {
        // print(element);
        newBody.add(element);
        //print(userpk);
        //print(element["parent"]);
        //sectionBody.add(element["section"]);
      }
    }
    // print(newBody);
    //print(sectionBody);
    //localStorage.setString('section', sectionBody.toString());
    //var section = localStorage.getString("section");
    //print(sectionBody);
    //print(section);
    //print(newBody);

    for (var u in newBody) {
      ClassicStudent student = ClassicStudent(
          u["id"],
          u["parent"],
          u['student_first_name'],
          u["student_last_name"],
          u["student_sexe"],
          u["nationality"],
          u["student_birthday"],
          u["father_name"],
          u["father_profession"],
          u["father_phone_number"],
          u["mother_name"],
          u["mother_profession"],
          u["mother_phone_number"],
          u["complete_adress"],
          u["tlf_fix_number"],
          u["img"],
          u["nom_du_pediatre"],
          u["tlf_pediatre"],
          u["other_responsible_name"],
          u["other_responsible_tlf"],
          u["is_alergetic"],
          u["auto_medic_buy"],
          u['photo_1'],
          u['photo_2'],
          u['photo_3'],
          u['photo_4'],
          u['photo_5'],
          u['photo_6'],
          u['section']);

      students.add(student);
      //localStorage.setString("images", [student.photo_1,student.photo_2,student.photo_3,student.photo_4,student.photo_5,student.photo_6].toString());
      //var image = localStorage.getString("images");
      //print(image);
      //print(students.length);
    }

    //print(students);
    return students;
    //print(students);
    //print(userpk);
    //print(body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text("Photos"),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.purple[100], border: Border.all(color: Colors.black)),
        child: FutureBuilder(
          future: _handlePhoto(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index].img)),
                      ),
                      title: Text(
                        snapshot.data[index].student_first_name,
                        style: TextStyle(
                          fontFamily: "LuckiestGuy",
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[index].student_last_name,
                        style: TextStyle(fontFamily: "LuckiestGuy"),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    Detail(snapshot.data[index])));
                      },
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class Detail extends StatefulWidget {
  final ClassicStudent student;
  Detail(this.student);
  @override
  _DetailState createState() => _DetailState(student);
}

class _DetailState extends State<Detail> {
  final ClassicStudent student;
  _DetailState(this.student);

  Widget _buildGradientContainer(double width, double height) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: width * .8,
        height: height / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFfbfcfd), Color(0xFFf2f3f8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0])),
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 40.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(double height) {
    return Positioned(
      top: height * .2,
      left: 30.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF1b1e44),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                child: Text(student.student_first_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFff6e6e),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                child: Text(student.section,
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List images2 = [
      student.photo_1,
      student.photo_2,
      student.photo_3,
      student.photo_4,
      student.photo_5,
      student.photo_6
    ];

    List images = [];

    for (var i in images2) {
      if (i != null) {
        images.add(i);
      }
    }

    return new Scaffold(
      backgroundColor: Color(0xFFf2f3f8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildGradientContainer(width, height),
              _buildAppBar(),
              _buildTitle(height),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height * .6,
                  child: images.length == 0
                      ? Image.asset("assets/404.png")
                      : ListView.builder(
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 10,
                                  bottom:
                                      MediaQuery.of(context).size.height / 22),
                              child: SizedBox(
                                width: width * .7,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              data: images[
                                                                  index])));
                                            },
                                            child: images[index] == null
                                                ? Text(" ")
                                                : Image.network(
                                                    images[index],
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: (index % 2 == 0)
                                                ? Colors.white
                                                : Color(0xFF2a2d3f),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(0.0, 10.0),
                                                  blurRadius: 10.0)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String data;

  DetailScreen({this.data});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var filePath;
  String BASE64_IMAGE;

  @override
  void initState() {
    super.initState();
  }

  void _showProgress(bool _isLoading) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _isLoading == true
              ? Dialog(
                  insetAnimationDuration: const Duration(seconds: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Téléchargement ...",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: "Sacramento"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : AlertDialog(
                  backgroundColor: Colors.white,
                  title: new Text('Téléchargement'),
                  content: Text("Téléchargement Fini Avec Succée"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Fermer"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
        });
  }

  void _showDialog(msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: new Text('Téléchargement'),
            content: Text(msg),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fermer"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void ImageDownloaddBUtton() async {
    bool _isLoading = false;

    setState(() {
      _isLoading = true;
    });

    _showProgress(_isLoading);

    try {
      var response = await http.get(widget.data);
      filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

      setState(() {
        _isLoading = false;
        Navigator.pop(context);
        _showProgress(_isLoading);
      });
    } catch (e) {
      Navigator.pop(context);

      _showDialog("Une Erreur S'est Produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () {
            ImageDownloaddBUtton();
          },
          child: Icon(
            Icons.file_download,
            size: 40,
          ),
        ),
      ),
      body: PhotoView(imageProvider: NetworkImage(widget.data)),
    );
  }
}

class ClassicStudent {
  final int id;
  final int parent;
  final String student_first_name;
  final String student_last_name;
  final String student_sexe;
  final String nationality;
  final String student_birthday;
  final String father_name;
  final String father_profession;
  final String father_phone_number;
  final String mother_name;
  final String mother_profession;
  final String mother_phone_number;
  final String complete_adress;
  final String tlf_fix_number;
  final String img;
  final String nom_du_pediatre;
  final String tlf_pediatre;
  final String other_responsible_name;
  final String other_responsible_tlf;
  final String is_alergetic;
  final String auto_medic_buy;
  final String photo_1;
  final String photo_2;
  final String photo_3;
  final String photo_4;
  final String photo_5;
  final String photo_6;
  final String section;

  ClassicStudent(
      this.id,
      this.parent,
      this.student_first_name,
      this.student_last_name,
      this.student_sexe,
      this.nationality,
      this.student_birthday,
      this.father_name,
      this.father_profession,
      this.father_phone_number,
      this.mother_name,
      this.mother_profession,
      this.mother_phone_number,
      this.complete_adress,
      this.tlf_fix_number,
      this.img,
      this.nom_du_pediatre,
      this.tlf_pediatre,
      this.other_responsible_name,
      this.other_responsible_tlf,
      this.is_alergetic,
      this.auto_medic_buy,
      this.photo_1,
      this.photo_2,
      this.photo_3,
      this.photo_4,
      this.photo_5,
      this.photo_6,
      this.section);
}
