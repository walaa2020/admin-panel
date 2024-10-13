import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../shared/components/constants/constant.dart';

class Addrecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<Addrecord> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController socialStatusController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController previousOperationsController = TextEditingController();
  TextEditingController allergyToMedicationController = TextEditingController();
  TextEditingController chronicDiseasesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController afirstname = TextEditingController();
  TextEditingController alastname = TextEditingController();
  bool _isLoading = false;

  Future<void> addRecord() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'http://127.0.0.1:8000/api/storeRecord';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // إضافة التوكن هنا
      },
      body: jsonEncode({
        "first_name": firstNameController.text,
        "father_name": fatherNameController.text,
        "last_name": lastNameController.text,
        "gender": genderController.text,
        "social_status": socialStatusController.text,
        "birthdate": birthdateController.text,
        "job": jobController.text,
        "address": addressController.text,
        "moblie_num": mobileNumController.text,
        "Blood_type": bloodTypeController.text,
        "Previous_Opertios": previousOperationsController.text,
        "AllergyToMedication": allergyToMedicationController.text,
        "Chronic_Diseases": chronicDiseasesController.text,
        "_first_name": afirstname.text,
        "_last_name": alastname.text,
        "phone": phoneController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['message']),
        backgroundColor: Colors.green,
      ));
      _clearFields();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['message'] ?? 'Failed to add record'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _clearFields() {
    firstNameController.clear();
    fatherNameController.clear();
    lastNameController.clear();
    genderController.clear();
    socialStatusController.clear();
    birthdateController.clear();
    jobController.clear();
    addressController.clear();
    mobileNumController.clear();
    bloodTypeController.clear();
    previousOperationsController.clear();
    allergyToMedicationController.clear();
    chronicDiseasesController.clear();
    phoneController.clear();
    afirstname.clear();
    alastname.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        title: Text('Add Medical Record',style: TextStyle(color: Colors.teal),),
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter first name' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: fatherNameController,
                        decoration: InputDecoration(
                          labelText: 'Father Name',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter father\'s name'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter last name' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Row 2: Birthdate, Gender, Address
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: birthdateController,
                        decoration: InputDecoration(
                          labelText: 'Birthdate',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter birthdate' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: genderController,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.six_ft_apart,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter gender' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.home,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter address' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row 3: Phone, Blood Type, Social Status
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: mobileNumController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter mobile number'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: bloodTypeController,
                        decoration: InputDecoration(
                          labelText: 'Blood Type',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.bloodtype,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter blood type' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: socialStatusController,
                        decoration: InputDecoration(
                          labelText: 'Social Status',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.people,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter social status'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row 4: Job
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: jobController,
                        decoration: InputDecoration(
                          labelText: 'Job',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.work,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter job' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row 5: Previous Operations, Allergy, Chronic Diseases
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: previousOperationsController,
                        decoration: InputDecoration(
                          labelText: 'Previous Operations',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.local_hospital,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter previous operations'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: allergyToMedicationController,
                        decoration: InputDecoration(
                          labelText: 'Allergy To Medication',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.warning,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter allergy to medication'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: chronicDiseasesController,
                        decoration: InputDecoration(
                          labelText: 'Chronic Diseases',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.medical_services,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter chronic diseases'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row 6: First Name (Alternate), Last Name (Alternate), Phone
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: afirstname,
                        decoration: InputDecoration(
                          labelText: 'First Name (Alternate)',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter name' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: alastname,
                        decoration: InputDecoration(
                          labelText: 'Last Name (Alternate)',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter name' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.teal.shade300,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter phone number' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Centered Submit Button
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade300,
                            offset: Offset(1, -2),
                            blurRadius: 5.0,
                          ),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                            shadowColor:
                            MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: addRecord,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 3, bottom: 8),
                            child: Text(
                              "Submit",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
