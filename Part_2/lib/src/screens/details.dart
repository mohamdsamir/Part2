import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  String loc;
  int value;
  Details({this.value});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Locations').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(children: [
                Padding(
                  padding: new EdgeInsets.all(25.0),
                  child: new Container(
                      height: 100.0,
                      width: 100.0,
                      child: CircularProgressIndicator()),
                ),
                Text(
                  'Please Enter Some Locations...',
                  style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ]));
            }

            return ListView(
              children: [
                Card(
                    shadowColor: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data.docs[value]['Name'],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image(
                            image: NetworkImage(
                                snapshot.data.docs[value]['ImageURL'])),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data.docs[value]['Description'],
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow),
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              launch(snapshot.data.docs[value]['LocationURL']);
                            }),
                      ],
                    )),
              ],
            );
          }),
    );
  }
}
