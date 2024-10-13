import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class Addneed extends StatefulWidget {
  const Addneed({Key? key}) : super(key: key);

  @override
  State<Addneed> createState() => _AddneedState();
}

class _AddneedState extends State<Addneed> {
  //setting the expansion function for the navigation rail
  bool isExpanded = false;
  String? _selectedGender;
  PlatformFile? _imageFile;
  bool _isExpanded = false;
  TextEditingController _descriptionController = TextEditingController();

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Method to pick and display an image file
  Future<void> _pickImage() async {
    try {
      // Pick an image file using file_picker package
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user cancels the picker, do nothing
      if (result == null) return;

      // If user picks an image, update the state with the new image file
      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {
      // If there is an error, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('images/rania.jpg'),
          //       // استبدل 'images/background.jpg' بمسار الصورة الخاصة بك
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'AlReda',
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
                      icon:  Icon(Icons.arrow_forward_sharp,color: Colors.teal.shade300,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        Expanded(
                          child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15,
                              childAspectRatio: 4.4,
                            ),
                            children: [
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "First Name",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Father Name",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color:Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Last Name",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Mobile Number",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                    Icon(Icons.phone, color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Address",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.location_on,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),

                              // SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView(


                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15,
                              childAspectRatio: 4.4,
                            ),
                            children: [

                              Container(
                                width: 100,

                                child: DropdownButtonFormField<String>(


                                  value: _selectedGender,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedGender = newValue;
                                    });
                                  },
                                  items: <String>['Male', 'Female']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(

                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(

                                    labelText: "Gender",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.six_ft_apart, color:Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              //focusColor: Colors.white,autofocus: false,
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "BirthDate",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.calendar_today,
                                      color:Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Social Status",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Job",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                    Icon(Icons.work, color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Blood Type",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.bloodtype,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          // إضافة عنصر Row
                          mainAxisAlignment: MainAxisAlignment.start,
                          // تحديد محور التوجيه الرئيسي
                          children: [
                            Text(
                              "Contact For Congent State:",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              childAspectRatio: 10,
                            ),
                            children: [
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "First Name",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade600,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Last Name",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person,
                                      color: Colors.teal.shade600,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade600,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Mobile Number",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                    Icon(Icons.phone, color: Colors.teal.shade600,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade600,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade600,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          // إضافة عنصر Row
                          mainAxisAlignment: MainAxisAlignment.start,
                          // تحديد محور التوجيه الرئيسي
                          children: [
                            Text(
                              "Contact For Congent State:",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              childAspectRatio: 7,
                            ),
                            children: [
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Previous Operitions",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.local_hospital_sharp,
                                      color: Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Allergy To Medications",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.warning,
                                      color:Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onChanged: (input) {},
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    labelText: "Chronic Diseases",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.all(12),
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon:
                                    Icon(Icons.airline_seat_legroom_reduced, color:Colors.teal.shade300,),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color:Colors.teal.shade300,),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.teal.shade300,),
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            // child: Card(
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          // إضافة عنصر Row
                          mainAxisAlignment: MainAxisAlignment.end,
                          // تحديد محور التوجيه الرئيسي
                          children: <Widget>[

                            ElevatedButton(
                              onPressed: _pickImage,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.teal.shade300,), // تعيين لون الخلفية
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white), // تعيين لون النص
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(200, 50)), // تعيين العرض والارتفاع
                                // يمكنك تعيين الأبعاد الأخرى حسب احتياجاتك
                              ),
                              child:const Text('Add Image'),
                            ),
                            SizedBox(height: 20),
                            if (_imageFile != null)
                              Stack(
                                children: [
                                  Image.memory(
                                    Uint8List.fromList(_imageFile!.bytes!),
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            const SizedBox(width: 100),
                            ElevatedButton(
                              onPressed: _pickImage,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.teal.shade300,), // تعيين لون الخلفية
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white), // تعيين لون النص
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(200, 50)), // تعيين العرض والارتفاع
                                // يمكنك تعيين الأبعاد الأخرى حسب احتياجاتك
                              ),
                              child:const Text('Add Analysis'),
                            ),
                            SizedBox(height: 20),
                            if (_imageFile != null)
                              Stack(
                                children: [
                                  Image.memory(
                                    Uint8List.fromList(_imageFile!.bytes!),
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 6.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.shade300,
                            offset: Offset(1, -2),
                            blurRadius: 5.0),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        colors: [
                          Colors.green.withOpacity(0.1),
                          Colors.lightGreenAccent.withOpacity(0.9),
                        ],
                      ),
                      color: Colors.red.shade300,
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
                            Colors.red,
                          ),
                          shadowColor: MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>homepage()),
                          // );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 3,
                            bottom: 8,
                          ),
                          child: Text(
                            "Save Record Medical",
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
        ],
      ),


      //let's add the floating action button
    );
  }
}
