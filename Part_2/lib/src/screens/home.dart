import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/src/screens/details.dart';
import 'package:flutter_dev/src/screens/signin.dart';
import 'form.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  int value;

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                'FavLocations',
                style: TextStyle(color: Colors.black),
              )),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signin()));
                    })
              ],
              backgroundColor: Colors.yellow,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Formxc()),
                  );
                },
                backgroundColor: Colors.green),
            backgroundColor: Colors.grey,
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Locations')
                    .snapshots(),
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
                        'Please Enter Your Favourite Locations...',
                        style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ]));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card(
                            shadowColor: Colors.black,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            child: Column(
                              children: [
                                Image(
                                    image: NetworkImage(
                                        snapshot.data.docs[index]['ImageURL'])),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  snapshot.data.docs[index]['Name'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data.docs[index]['Theme'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            )),
                        onTap: () {
                          value = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(value: value)));
                        },
                      );
                    },
                  );
                })));
  }
}
