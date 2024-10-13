import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/components/constants/constant.dart';

class ShowdoctorPage extends StatefulWidget {
  const ShowdoctorPage({Key? key}) : super(key: key);

  @override
  State<ShowdoctorPage> createState() => _ShowdoctorPageState();
}

class _ShowdoctorPageState extends State<ShowdoctorPage> {
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> searchResults = [];
  List<bool> _expanded = [];
  bool _loading = true;
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors([String query = '']) async {
    var headers = {
      'Authorization' : 'Bearer ${token!}',
    };
    var requestUrl = query.isEmpty
        ? 'http://127.0.0.1:8000/api/showAllDoctors'
        : 'http://127.0.0.1:8000/api/doctor/search/$query';
    var request = http.Request('GET', Uri.parse(requestUrl));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      setState(() {
        if (query.isEmpty) {
          doctors = List<Map<String, dynamic>>.from(jsonResponse['data']);
          _expanded = List<bool>.filled(doctors.length, false);
        } else {
          searchResults = List<Map<String, dynamic>>.from(jsonResponse[0]);
        }
        _loading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        _loading = false;
      });
    }
  }

  void onSearchChanged(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
        fetchDoctors(query);
      });
    } else {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void onDoctorSelected(Map<String, dynamic> doctor) {
    setState(() {
      searchController.clear();
      _isSearching = false;
      doctors = [doctor];
      _expanded = [true];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Column(
                        children: [
                          TextField(
                            controller: searchController,
                            cursorColor: Colors.teal,
                            decoration: InputDecoration(
                              hintText: "Search ",
                              prefixIcon: Icon(Icons.search,color: Colors.grey,),
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
                            onChanged: onSearchChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  color: Colors.teal.shade300,
                  width: double.infinity,
                  height: 60,
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Clinics',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                            width: 1, color: Colors.grey),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        for (int index = 0; index < doctors.length; index++) ...[
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _expanded[index] =
                                      !_expanded[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(doctors[index]
                                    ['first_name']),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _expanded[index] =
                                      !_expanded[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(doctors[index]
                                    ['last_name']),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _expanded[index] =
                                      !_expanded[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(doctors[index]['phone']
                                        .toString()),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _expanded[index] =
                                      !_expanded[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(doctors[index]
                                    ['clinic_name']
                                        .toString()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_expanded[index])
                            TableRow(
                              children: [
                                TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.network(
                                      doctors[index]['doctor_img'],
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'First Name: ${doctors[index]['first_name']}'),
                                        Text(
                                            'Last Name: ${doctors[index]['last_name']}'),
                                        Text(
                                            'Phone: ${doctors[index]['phone']}'),
                                        Text(
                                            'Clinics: ${doctors[index]['clinic_name']}'),
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Gender: ${doctors[index]['gender']}'),
                                        Text(
                                            'Email: ${doctors[index]['email']}'),
                                        Text(
                                            'Address: ${doctors[index]['address']}'),
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Specialization: ${doctors[index]['specialization']}'),
                                        Text(
                                            'Learning Grades: ${doctors[index]['learning_grades']}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isSearching)
              Positioned(
                left:140,
                top: 53,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${searchResults[index]['first_name']} ${searchResults[index]['last_name']}'),
                        onTap: () =>
                            onDoctorSelected(searchResults[index]),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

