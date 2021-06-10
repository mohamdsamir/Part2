import 'package:flutter/material.dart';
import 'package:flutter_dev/data/locations.dart';
import 'package:flutter_dev/details.dart';
import './form.dart';
import 'data/locations.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  LocationsAll x = new LocationsAll();

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
            body: ListView.builder(
              itemCount: x.listobj.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                      shadowColor: Colors.black,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        children: [
                          Image(image: NetworkImage(x.listobj[index].imageUrl)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            x.listobj[index].name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            x.listobj[index].theme,
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
            )));
  }
}
