import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestrore/main.dart';

class Edit extends StatefulWidget {
  List list;
  int index;
  Edit({required this.index, required this.list});
  //const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortDescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _newscollection =
      FirebaseFirestore.instance.collection('news');

  @override
  void initState() {
    _titleController =
        new TextEditingController(text: widget.list[widget.index]['title']);
    _shortDescController = new TextEditingController(
        text: widget.list[widget.index]['short_desc']);
    _descall =
        new TextEditingController(text: widget.list[widget.index]['desc']);
    _image = new TextEditingController(text: widget.list[widget.index]['img']);
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortDescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;

    await _newscollection.doc(documentSnapshot!.id).update(
        //update image
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
                    child: new Text("EDIT"),
                    color: Colors.blueAccent,
                    onPressed: () => update(widget.list[widget.index])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
