import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  HomeScreen({@required this.userId}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('todos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document['title']),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 2.0,
          child: new Icon(Icons.add),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the user has typed in using our
                  // TextEditingController
                  content: TextField(
                    decoration: new InputDecoration(
                      hintText: 'Enter Todo',
                    ),
                    onSubmitted: (title) {
                      var m = {
                        "title": title,
                        "status": false,
                        "user_id": userId
                      };
                      Firestore.instance
                          .collection("todos")
                          .document()
                          .setData(m);
                      print(title);
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
