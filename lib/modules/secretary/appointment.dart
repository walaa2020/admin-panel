import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:reda3/modules/secretary/record_medicl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/patient_detail.dart';
import '../../shared/components/constants/constant.dart';

class AppointmentPage extends StatefulWidget {
  AppointmentPage({required this.doctorId});

  final int doctorId;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  late Future<List<AppointmentDay>> _futureDays;
  int idx = 0;  // ابدأ بفهرس اليوم الأول
  List<AppointmentDay> days = [];
  List<AppointmentM> appoint = [];
  List<int?> selectedIndexes = [];
  Map<String, List<int>> selectedIndexesPerDay = {};
int ?i;
  @override
  void initState() {
    super.initState();

    i=widget.doctorId;
    _futureDays = getDays();
    print(i);
  }

  // دالة لتحميل حالات الـ Checkbox من SharedPreferences
  Future<void> loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    final String currentDay = days.isNotEmpty ? days[idx].date! : '';

    if (currentDay.isNotEmpty) {
      final List<String>? storedIndexes = prefs.getStringList(currentDay);
      if (storedIndexes != null) {
        selectedIndexesPerDay[currentDay] = storedIndexes.map(int.parse).toList();
      }
    }
    setState(() {});
  }

  // دالة لتخزين حالات الـ Checkbox في SharedPreferences
  Future<void> saveCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    final String currentDay = days.isNotEmpty ? days[idx].date! : '';

    if (currentDay.isNotEmpty) {
      final List<int>? indexes = selectedIndexesPerDay[currentDay];
      if (indexes != null) {
        await prefs.setStringList(currentDay, indexes.map((e) => e.toString()).toList());
      }
    }
  }

  // دالة لتغيير اليوم المختار وتحميل مواعيد اليوم المحدد
  void onChangeIdx(int index) {
    setState(() {
      idx = index;
      // استدعاء دالة جلب المواعيد عند تغيير اليوم
      getAppointmentDayDoctor(date: days[index].date!);
      loadCheckboxStates(); //
      d=days[index].date!;// تحميل حالات الـ Checkbox عند تغيير اليوم
    });
  }

  void toggleCheckboxForDay(int index) {
    String currentDay = days[idx].date!;
    if (!selectedIndexesPerDay.containsKey(currentDay)) {
      selectedIndexesPerDay[currentDay] = [];
    }

    if (!selectedIndexesPerDay[currentDay]!.contains(index)) {
      selectedIndexesPerDay[currentDay]!.add(index);
    } else {
      selectedIndexesPerDay[currentDay]!.remove(index);
    }

    setState(() {});
    saveCheckboxStates(); // حفظ حالات الـ Checkbox بعد التغيير
  }

  Future<List<AppointmentDay>> getDays() async {
    try {
      Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/showDoctorAppointmentsCenter/$i"),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        days = responseBody.map<AppointmentDay>((item) => AppointmentDay.fromJson(json: item)).toList();

        // بعد تحميل الأيام بنجاح، عرض مواعيد اليوم الأول تلقائياً
        if (days.isNotEmpty) {
          getAppointmentDayDoctor(date: days[0].date!);  // عرض مواعيد اليوم الأول
        }

        return days;
      } else {
        print("Failed to get days");
        return [];
      }
    } catch (e) {
      print("Failed to get days: $e");
      return [];
    }
  }
String ?d;
  Future<void> getAppointmentDayDoctor({required String date}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      Response response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/showDoctorAppointmentsByDay2/$i'),
        body: jsonEncode({'date': date}),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        setState(() {
          appoint = data['appointments'].map<AppointmentM>((item) => AppointmentM.fromJson(item)).toList();
        });
      } else {
        print("Failed to get appointments");
      }
    } catch (e) {
      print("Failed to get appointments: $e");
    }
  }
  List<PatientDetails> records = [];
  Future  getRecord() async {
    Response response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/allRecords"),

    );
    var responseBody = jsonDecode(response.body);
    print("clinics Data is : $responseBody");
    if(response.statusCode == 200)
    {
      for( var item in responseBody['data'] )
      {
        setState(() {
          records.add(PatientDetails.fromJson( item));
        });

      }

      print(responseBody);

    }
    else
    {
      print("object");

    }
  }
  // دالة لتحديث حالة الحضور
  Future<void> attendedVisit(int userappointment_id) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/storeVisit'));
    request.body = json.encode({
      "userappointment_id": userappointment_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      getAppointmentDayDoctor(date: d!);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<AppointmentDay>>(
        future: _futureDays,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            days = snapshot.data!;
            return buildAppointmentsView();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.teal),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 20),
                    Text(
                      'AlReda',
                      style: TextStyle(
                        color: Colors.teal.shade300,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Expanded(flex:7,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu,color: Colors.grey,size: 100,),
                        Text("No days available",style: TextStyle(color: Colors.grey,fontSize: 30),),
                      ],
                    ))),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildAppointmentsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        SizedBox(height: 5),
        Expanded(
          child: Row(
            children: [
              // عرض الأيام في العمود الجانبي
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => onChangeIdx(index),
                      child: buildDayItem(index),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: days.length,
                  ),
                ),
              ),
              VerticalDivider(thickness: 2, width: 1),
              // عرض المواعيد الخاصة باليوم المختار
              Expanded(
                flex: 11,
                child: idx >= 0 && idx < days.length
                    ? buildAppointmentList()
                    : Center(child: Text("Please select a day")),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.teal),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 20),
          Text(
            'AlReda',
            style: TextStyle(
              color: Colors.teal.shade300,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDayItem(int index) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.teal.shade200,
        border: Border.all(
          color: idx == index ? Colors.red : Colors.teal,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${days[index].day_name}",
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "${days[index].date}",
              style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataTable(
          headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.teal.shade300),
          columns: const [
            DataColumn(label: Text("First Name", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("Last Name", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("Father Name", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("First Time", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("End Time", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("Type", style: TextStyle(color: Colors.white))),
            DataColumn(label: Text("Action", style: TextStyle(color: Colors.white))),
          ],
          rows: List<DataRow>.generate(
            appoint.length,
                (index) {
              var item = appoint[index];
              bool isAvailable = item.is_booked == false;
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(item.firttName ??"_")),
                  DataCell(Text(item.lastName ?? "_")),
                  DataCell(Text(item.fathetName ?? "_")),
                  DataCell(Text("${item.start_time}")),
                  DataCell(Text("${item.end_time}")),
                  DataCell(
                    item.is_booked == true
                        ? Text("reserved", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600))
                        : Text("available", style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w600)),
                  ),
                  DataCell(
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            // Fetch records before navigation
                            await getRecord();

                            // Find the record with the specific record_id
                            PatientDetails? selectedRecord = records.firstWhere(
                                  (record) => record.id == item.record_id,

                            );

                            if (selectedRecord != null) {
                              // Navigate to VisitDetailPage with selectedRecord
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Record_Midecal ( selectedRecord,1),
                                ),
                              );
                            } else {
                              // Handle case where no record is found
                              print("Record not found");
                            }
                          },
                          child: Text("view"),
                          color: Colors.yellowAccent,
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            if (isAvailable) {
                              // عدم تنفيذ أي إجراء إذا كان العنصر متاحًا
                              return;
                            }

                            // الحصول على اليوم الحالي
                            String currentDay = days[idx].date!;
                            // التحقق إذا كان العنصر غير موجود في selectedIndexesPerDay لهذا اليوم
                            if (!selectedIndexesPerDay.containsKey(currentDay)) {
                              selectedIndexesPerDay[currentDay] = [];
                            }

                            if (!selectedIndexesPerDay[currentDay]!
                                .contains(index)) {
                              attendedVisit(item.user_appointment_id!);
                              toggleCheckboxForDay(index); // تحديث حالة الـ Checkbox
                            }
                          },
                          icon: Icon(
                            item.is_visited == true
                            // selectedIndexesPerDay[days[idx].date!]?.contains(index) ?? false
                                ? Icons.check_box // إذا كان تم الضغط سابقاً
                                : Icons.check_box_outline_blank, // إذا لم يتم الضغط
                          ),
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// تعريفات AppointmentDay و AppointmentM

class AppointmentDay {
  final String? date;
  final String? day_name;

  AppointmentDay({this.date, this.day_name});

  factory AppointmentDay.fromJson({required Map<String, dynamic> json}) {
    return AppointmentDay(
      date: json['date'],
      day_name: json['day_name'],
    );
  }
}

class AppointmentM {
  final String? firttName;
  final String? lastName;
  final String? fathetName;
  final String? start_time;
  final String? end_time;
  final bool? is_booked;
  final int? user_appointment_id;
  final int?  record_id;
  final bool? is_visited;

  AppointmentM({
    this.firttName,
    this.lastName,
    this.fathetName,
    this.start_time,
    this.end_time,
    this.is_booked,
    this.user_appointment_id,
    this.record_id,
    this.is_visited,
  });

  factory AppointmentM.fromJson(Map<String, dynamic> json) {
    return AppointmentM(
      firttName: json['firstName'],
      fathetName:json['fatherName'],
      lastName: json['lastName'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      is_booked: json['is_booked'],
      user_appointment_id: json['user_appointment_id'],
      record_id :json['record_id'] != null ? json['record_id'].toInt() : null,
      is_visited: json['is_visited']==1 ,
    );
  }
}
