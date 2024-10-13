import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/patient_detail.dart';
import '../../shared/components/constants/constant.dart';
import '../doctor/record.dart';
import 'Add_record.dart';
import 'edit_record.dart';
import 'record_medicl.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

PatientDetails? r1;

class _RecordPageState extends State<RecordPage> {
  bool isExpanded = false;
  List<PatientDetails> records = [];
  List<PatientDetails> filteredRecords = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRecord();
    _searchController.addListener(_filterRecords); // استماع للتغييرات في حقل البحث
  }

  Future<void> fetchRecords() async {
    var headers = {
      'Authorization': 'Bearer ${token!}',
    };
    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/allRecords'));

    request.headers.addAll(headers);
    var responseBody = jsonDecode(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        setState(() {
          records.add(PatientDetails.fromJson(item));
          filteredRecords = records; // حفظ جميع السجلات كقائمة تصفية مبدئية
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getRecord() async {
    Response response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/allRecords"),
    );
    var responseBody = jsonDecode(response.body);
    print("clinics Data is : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody['data']) {
        setState(() {
          records.add(PatientDetails.fromJson(item));
          filteredRecords = records; // حفظ جميع السجلات كقائمة تصفية مبدئية
        });
      }
      print(responseBody);
    } else {
      print("Error retrieving records");
    }
  }

  // تصفية السجلات بناءً على الاسم الأول
  void _filterRecords() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredRecords = records;
      } else {
        filteredRecords = records.where((record) {
          return record.firstName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> deleteRecord(String recordId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token!}',
    };
    var request = http.Request('DELETE', Uri.parse('http://127.0.0.1:8000/api/deleteRecord/$recordId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      // Remove the record from the local records list after deletion
      setState(() {
        records.removeWhere((record) => record.id.toString() == recordId);
        filteredRecords.removeWhere((record) => record.id.toString() == recordId);
      });
    } else {
      print(response.reasonPhrase);
    }
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
            padding: const EdgeInsets.all(16),
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
                    const SizedBox(width: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        controller: _searchController, // إضافة وحدة التحكم للحقل
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
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
                          hintText: "Search by First Name",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DataTable(
                                headingRowColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.teal.shade300,
                                ),
                                columns: [
                                  const DataColumn(
                                      label: Text(
                                        "ID",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "First Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "Father Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "Last Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  const DataColumn(
                                      label: Text(
                                        "Action",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                                rows: filteredRecords.map((record) {
                                  return DataRow(cells: [
                                    DataCell(Text(record.id.toString())),
                                    DataCell(Text(record.firstName)),
                                    DataCell(Text(record.fatherName)),
                                    DataCell(Text(record.lastName)),
                                    DataCell(IconButton(
                                      icon: Icon(Icons.edit, color: Colors.cyan),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditRecord(record: record),
                                          ),
                                        );
                                      },
                                    )),
                                    DataCell(IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Confirm Delete'),
                                              content: const Text('Are you sure you want to delete this record?'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Delete'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    deleteRecord(record.id.toString());
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                                    DataCell(
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return Record_Midecal(record!, 1);
                                                  }
                                              ));
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.teal.shade300,
                                          padding: const EdgeInsets.all(10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Colors.teal.shade300,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "OPEN",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addrecord()),
          );
        },
        child: const Icon(Icons.post_add_rounded),
        backgroundColor: Colors.teal.shade300,
      ),
    );
  }
}
