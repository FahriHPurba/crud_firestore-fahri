import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:crud_firestrore/home_page.dart';
import 'package:crud_firestrore/edit.dart';
import 'package:crud_firestrore/add.dart';
import 'package:crud_firestrore/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference _newCollection =
      FirebaseFirestore.instance.collection("Fahri Purba");

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _newCollection.doc(productId).delete();
    // show a snakbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Flutter'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _newCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                // tambah container
                return new Container(
                  padding: const EdgeInsets.all(10.0),
                  //tambah child GestureDetector
                  child: new GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new View(
                                list: streamSnapshot.data!.docs,
                                index: index))),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['title']),
                        subtitle: Text(documentSnapshot['short_desc']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // Press this button to edit a singel product
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) => new Edit(
                                        list: streamSnapshot.data!.docs,
                                        index: index),
                                  ),
                                ),
                              ),
                              // this icon button is used to delete a single product
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteProduct(documentSnapshot.id)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Add())),
        child: Icon(Icons.add),
      ),
    );
  }
}
