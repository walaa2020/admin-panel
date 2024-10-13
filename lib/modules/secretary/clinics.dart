import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../shared/components/constants/constant.dart';
import 'doctors.dart'; // استيراد صفحة الأطباء

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({Key? key}) : super(key: key);

  @override
  State<ClinicsPage> createState() => ClinicsPageState();
}

class ClinicsPageState extends State<ClinicsPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _clinics = [];
  List<dynamic> _filteredClinics = [];

  @override
  void initState() {
    super.initState();
    fetchClinics().then((clinics) {
      setState(() {
        _clinics = clinics;
        _filteredClinics = clinics; // عرض جميع العيادات بشكل افتراضي
      });
    });

    // استماع لتغيرات النص في حقل البحث
    _searchController.addListener(_filterClinics);
  }

  Future<List<dynamic>> fetchClinics() async {
    var headers = {
      'Authorization': 'Bearer ${token!}',
    };

    var response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/showAllClinics'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      String responseString = response.body;
      var jsonResponse = json.decode(responseString);
      if (jsonResponse['data'] != null) {
        return jsonResponse['data'];
      } else {
        throw Exception('Failed to load clinics');
      }
    } else {
      throw Exception('Failed to load clinics');
    }
  }

  void _filterClinics() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredClinics = _clinics;
      } else {
        _filteredClinics = _clinics.where((clinic) {
          String clinicName = clinic['clinic_name']?.toLowerCase() ?? '';
          return clinicName.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
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
                    SizedBox(width: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextField(
                        controller: _searchController,
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                          hintText: "Search clinic",
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
                SizedBox(height: 30),
                Expanded(
                  child: _filteredClinics.isEmpty
                      ? Center(child: Text('No clinics found'))
                      : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1.75,
                    ),
                    itemCount: _filteredClinics.length,
                    itemBuilder: (context, index) {
                      var clinic = _filteredClinics[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorsPage(clinicId: clinic['id']),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: clinic['clinic_img'] != null &&
                                      clinic['clinic_img'].isNotEmpty
                                      ? Image.network(
                                    clinic['clinic_img'],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                        stackTrace) {
                                      return Center(
                                          child: Text(
                                              'Failed to load image'));
                                    },
                                  )
                                      : Center(
                                      child: Text(
                                          'No image available')),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                clinic['clinic_name'] ?? 'Unknown',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
