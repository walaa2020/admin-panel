import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Showadvertisingpage extends StatefulWidget {
  const Showadvertisingpage({Key? key, this.isVisible}) : super(key: key);
  final bool? isVisible;

  @override
  State<Showadvertisingpage> createState() => _ShowadvertisingpageState();
}

class _ShowadvertisingpageState extends State<Showadvertisingpage> {
  PlatformFile? _imageFile;
  bool _isExpanded = false;
  TextEditingController _descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'AlReda',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.teal.shade300,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(2, 2),
                              ),
                            ],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_sharp, color: Colors.teal.shade300),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: <Widget>[
                          Container(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('images/J.jpg'),
                              radius: 200.0,
                            ),

                          ),

                       const SizedBox(height: 100),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _descriptionController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    labelStyle: TextStyle(color: Colors.teal.shade300),
                                    contentPadding: EdgeInsets.all(30),
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal.shade300),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
