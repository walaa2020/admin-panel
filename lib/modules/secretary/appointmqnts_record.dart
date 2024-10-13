import 'package:flutter/material.dart';
import 'dart:convert'; // لتحويل البيانات JSON
import 'package:http/http.dart' as http;

import '../../shared/components/constants/constant.dart'; // لاستدعاء API

class AppointmentRecordPage extends StatefulWidget {
  const AppointmentRecordPage({Key? key}) : super(key: key);

  @override
  State<AppointmentRecordPage> createState() => _AppointmentRecordPageState();
}

class _AppointmentRecordPageState extends State<AppointmentRecordPage> {
  // قائمة لتخزين زيارات المرضى
  List<dynamic> visits = [];

  // استدعاء API لجلب البيانات
  Future<void> fetchVisits() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // إضافة التوكن في الترويسة
    };

    // استدعاء الـ API مع التوكن في الترويسات
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/getAllVisits'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // إذا كان الاتصال ناجحاً، نقوم بتحويل البيانات إلى JSON
      final data = jsonDecode(response.body);
      setState(() {
        visits = data['visits']; // تخزين الزيارات في المتغير visits
      });
    } else {
      // في حالة وجود خطأ
      throw Exception('Failed to load visits');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchVisits(); // استدعاء البيانات عند بدء الصفحة
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
                                columns: const [
                                  DataColumn(
                                      label: Text(
                                        "User First Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        "User Last Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        "Appointment Time",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        "Clinic Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        "Doctor Name",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                                rows: visits
                                    .map((visit) => DataRow(cells: [
                                  DataCell(Text(visit['user_first_name'])),
                                  DataCell(Text(visit['user_last_name'])),
                                  DataCell(Text(visit['appointment_time'])),
                                  DataCell(Text(visit['clinic_name'])),
                                  DataCell(Text('${visit['doctor_first_name']} ${visit['doctor_last_name']}')),
                                ]))
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
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
    );
  }
}
