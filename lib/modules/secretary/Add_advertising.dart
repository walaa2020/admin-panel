import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../shared/components/constants/constant.dart';

class Addadvertisingpage extends StatefulWidget {
  const Addadvertisingpage({Key? key, this.isVisible,this.isVisible1,this.isVisible2}) : super(key: key);
  final bool? isVisible;
  final bool? isVisible1;
  final bool? isVisible2;

  @override
  State<Addadvertisingpage> createState() => _AddadvertisingpageState();
}

class _AddadvertisingpageState extends State<Addadvertisingpage> {
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _uploadImage() async {
    if (webImage == null || _descriptionController.text.isEmpty) {
      _showAlertDialog('Error', 'Please select an image and enter a description.');
      return;
    }

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/store_advert'));
    request.fields.addAll({
      'description': _descriptionController.text,
    });
    List<int> list = webImage.cast();
    request.files.add(
      http.MultipartFile.fromBytes(
        'advert_image',
        list,
        filename:  'myFile.png',
      ),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.request?.url);
    print(response.statusCode);

    print(response.request!.method);

    if (response.statusCode == 200) {
      print("////////////////////////////////////////");
      print(await response.stream.bytesToString());
      _showAlertDialog('Success', 'Upload successful!');
    } else if (response.statusCode == 401) {
      _showAlertDialog('Unauthorized', 'Invalid token.');
    } else {
      print(response.reasonPhrase);
      _showAlertDialog('Failed', 'Upload failed: ${response.reasonPhrase}');
    }
  }

  // عرض AlertDialog
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK",style: TextStyle(color: Colors.teal),),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الحوار
              },
            ),
          ],
        );
      },
    );
  }

  File? pickedImage;
  Uint8List webImage=Uint8List(8);

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        pickedImage = File('a');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
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
                          shadows: const [
                            Shadow(
                              color: Colors.white,
                              offset: Offset(2, 2),
                            ),
                          ],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.teal.shade300,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
                          ),
                          child: const Text('Select Advertising Image'),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 4,
                          child: pickedImage == null
                              ? Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.teal.shade300,
                          )
                              : Image.memory(
                            webImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  cursorColor: Colors.teal,
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    labelStyle: TextStyle(color: Colors.teal.shade300),
                                    contentPadding: const EdgeInsets.all(30),
                                    hintStyle: const TextStyle(color: Colors.black),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.teal.shade300,
                                    offset: Offset(1, -2),
                                    blurRadius: 5.0),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 1.0],
                                colors: [
                                  Colors.green.withOpacity(0.1),
                                  Colors.lightGreenAccent.withOpacity(0.9),
                                ],
                              ),
                              color: Colors.teal.shade300,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 18,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.teal.shade300,
                                  ),
                                  shadowColor: MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  _uploadImage();
                                  print("jjjjjjjjjjjj${webImage.length}");
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 8),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
    );
  }
}
