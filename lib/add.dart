import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestrore/main.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortDescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _newscollection =
      FirebaseFirestore.instance.collection('news');

  Future<void> add([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortDescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;
    await _newscollection.add(
        //tambah image
        {
          "title": vartitle,
          "short_desc": varshortdesc,
          "desc": vardesc,
          "img": varimage
        });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: new Text("Tambah Data Berita"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _shortDescController,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(labelText: 'Short Desc'),
                ),
                TextField(
                  controller: _descall,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(labelText: 'Desc'),
                ),
                TextField(
                  controller: _image,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Image Url'),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    child: new Text("Tambah Data"),
                    color: Colors.blueAccent,
                    onPressed: () => add()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
