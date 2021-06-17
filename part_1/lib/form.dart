import 'package:flutter/material.dart';
import 'package:flutter_dev/main.dart';

import 'data/locations.dart';
import 'models/Location.dart';

class Formxc extends StatefulWidget {
  State<StatefulWidget> createState() {
    return FormxcState();
  }
}

class FormxcState extends State<Formxc> {
  Location z;
  TextEditingController nameController = TextEditingController();
  TextEditingController themeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Form',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: [
          Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.near_me),
                      hintText: 'Enter Location Name',
                      labelText: 'Name',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Location name';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: themeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.filter),
                      hintText: 'Enter Theme',
                      labelText: 'Theme',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Theme';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_circle),
                      hintText: 'Enter Full Description',
                      labelText: 'Description',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Description';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_a_photo),
                      hintText: 'Enter Image Url',
                      labelText: 'Image',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Image URL';
                      }
                      if (!Uri.parse(value).isAbsolute) {
                        return 'Please Enter a valid Image URL';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on),
                      hintText: 'Enter Location Url',
                      labelText: 'Location',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Location URL';
                      }
                      if (!Uri.parse(value).isAbsolute) {
                        return 'Please Enter a valid Location URL';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.yellow),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        print("successful");
                        z = Location(
                            id: (LocationsAll.listobj.length) + 1,
                            name: nameController.text.toString(),
                            description: descriptionController.text.toString(),
                            theme: themeController.text.toString(),
                            imageUrl: imageController.text.toString(),
                            locationUrl: locationController.text.toString());
                        LocationsAll.listobj.add(z);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                        return;
                      } else {
                        print("UnSuccessfull");
                      }
                    },
                  ),
                ],
              ))
        ]));
  }
}
