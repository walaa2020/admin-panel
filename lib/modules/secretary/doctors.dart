import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../shared/components/constants/constant.dart';
import 'appointment.dart'; // تأكد من أن هذا هو المسار الصحيح للملف

class DoctorsPage extends StatefulWidget {
  final int clinicId;

  const DoctorsPage({Key? key, required this.clinicId}) : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  bool isExpanded = false;
  List<dynamic> _doctors = [];
  List<dynamic> _filteredDoctors = [];
  bool _isLoading = true;
  bool _hasError = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctors(widget.clinicId);
    _searchController.addListener(_filterDoctors); // إضافة مستمع للتغييرات في حقل البحث
  }

  Future<void> fetchDoctors(int clinicId) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer ${token!}', // استبدل التوكن الخاص بك هنا
      };
      var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/getDoctorByClinic/$clinicId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseString);
        setState(() {
          _doctors = jsonResponse;
          _filteredDoctors = _doctors; // نسخ القائمة الأصلية
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  // تصفية الأطباء بناءً على النص المدخل
  void _filterDoctors() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDoctors = _doctors;
      } else {
        _filteredDoctors = _doctors.where((doctor) {
          String fullName = '${doctor['first_name']} ${doctor['last_name']}'.toLowerCase();
          return fullName.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back, color: Colors.teal), onPressed: () {
                      Navigator.pop(context);
                    }),
                    SizedBox(width: 20),
                    Text(
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
                    SizedBox(width: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextField(
                        controller: _searchController, // ربط وحدة التحكم بحقل البحث
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                          hintText: "Search doctor",
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _hasError
                      ? Center(child: Text('Failed to load doctors'))
                      : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _filteredDoctors.length, // استخدام القائمة المفلترة
                    itemBuilder: (context, index) {
                      var doctor = _filteredDoctors[index];
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppointmentPage(doctorId: doctor['id'])),
                            );
                          },
                          child: Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: doctor['doctor_img'] != null &&
                                        doctor['doctor_img'].isNotEmpty
                                        ? Image.network(
                                      doctor['doctor_img'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.person, size: 50);
                                      },
                                    )
                                        : Icon(Icons.person, size: 50),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${doctor['first_name']} ${doctor['last_name']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
