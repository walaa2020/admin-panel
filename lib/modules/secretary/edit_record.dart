import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reda3/models/patient_detail.dart';

import '../../shared/components/constants/constant.dart';
import 'home.dart';

class EditRecord extends StatefulWidget {
  final PatientDetails record;

  const EditRecord({Key? key, required this.record}) : super(key: key);

  @override
  _EditRecordState createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  bool _isExpanded = false;
  String? _selectedGender;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _socialStatusController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _contactFirstNameController = TextEditingController();
  final TextEditingController _contactLastNameController = TextEditingController();
  final TextEditingController _contactMobileNumberController = TextEditingController();
  final TextEditingController _previousOperationsController = TextEditingController();
  final TextEditingController _allergyToMedicationsController = TextEditingController();
  final TextEditingController _chronicDiseasesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _populateFields();
  }
  void _populateFields() {
    final record = widget.record;
    _firstNameController.text = record.firstName?? '';
    _fatherNameController.text = record.fatherName?? '';
    _lastNameController.text = record.lastName?? '';
    _mobileNumberController.text = record.mobileNumber?.toString() ?? '';
    _addressController.text = record.address?? '';
    _birthDateController.text = record.birthdate ?.toString() ?? '';
    _selectedGender = record.gender?? '';
    _socialStatusController.text = record.socialStatus?? '';
    _jobController.text = record.job?? '';
    _bloodTypeController.text = record.bloodType?? '';
    _contactFirstNameController.text = record.firstNameAlternate?? '';
    _contactLastNameController.text = record.lastNameAlternate?? '';
    _contactMobileNumberController.text = record.phone.toString() ?? '';
    _previousOperationsController.text = record.previousOperations?? '';
    _allergyToMedicationsController.text = record.allergyToMedication?? '';
    _chronicDiseasesController.text = record.chronicDiseases?? '';
  }

  Future<void> _updateRecord() async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token!}',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/api/updateRecord/${widget.record.id}'),
    );

    request.fields.addAll({
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'father_name': _fatherNameController.text,
      'birthdate': _birthDateController.text,
      'gender': _selectedGender ?? '',
      'moblie_num': _mobileNumberController.text,
      'Blood_type': _bloodTypeController.text,
      'social_status': _socialStatusController.text,
      'job': _jobController.text,
      'Previous_Opertios': _previousOperationsController.text,
      'AllergyToMedication': _allergyToMedicationsController.text,
      'Chronic_Diseases': _chronicDiseasesController.text,
      '_first_name': _contactFirstNameController.text,
      '_last_name': _contactLastNameController.text,
      'phone': _contactMobileNumberController.text,
      'address': _addressController.text,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Record updated successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeS()));
    } else {
      var responseData = await response.stream.bytesToString();
      print('Failed to update record: ${response.reasonPhrase}');
      print('Response data: $responseData');
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
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.teal.shade300,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Text(
                        'Edit Record',
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

                  ],
                ),
                SizedBox(height: 50,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15,
                              childAspectRatio: 4.4,
                            ),
                            children: [
                              buildTextFormField("First Name", Icons.person, _firstNameController),
                              buildTextFormField("Father Name", Icons.person, _fatherNameController),
                              buildTextFormField("Last Name", Icons.person, _lastNameController),
                              buildTextFormField("Mobile Number", Icons.phone, _mobileNumberController),
                              buildTextFormField("Address", Icons.location_on, _addressController),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15,
                              childAspectRatio: 4.4,
                            ),
                            children: [
                              buildDropdownButtonFormField("Gender", Icons.six_ft_apart, ["male", "female"]),
                              buildTextFormField("Birth Date", Icons.calendar_today, _birthDateController),
                              buildTextFormField("Social Status", Icons.person, _socialStatusController),
                              buildTextFormField("Job", Icons.work, _jobController),
                              buildTextFormField("Blood Type", Icons.bloodtype, _bloodTypeController),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              buildTextFormField("First Name", Icons.person, _contactFirstNameController),
                              buildTextFormField("Last Name", Icons.person, _contactLastNameController),
                              buildTextFormField("Mobile Number", Icons.phone, _contactMobileNumberController),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Additional Information:",
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
                              buildTextFormField("Previous Operations", Icons.local_hospital_sharp, _previousOperationsController),
                              buildTextFormField("Allergy To Medications", Icons.warning, _allergyToMedicationsController),
                              buildTextFormField("Chronic Diseases", Icons.airline_seat_legroom_reduced, _chronicDiseasesController),
                            ],
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
                                onPressed: _updateRecord,
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 3,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    "Update Record",
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

  Widget buildTextFormField(String labelText, IconData iconData, TextEditingController controller) {
    return Container(
      width: 100,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            iconData,
            color: Colors.teal.shade300,
          ),
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
    );
  }

  Widget buildDropdownButtonFormField(String labelText, IconData iconData, List<String> items) {
    return Container(
      width: 100,
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            iconData,
            color: Colors.teal.shade300,
          ),
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
    );
  }
}
