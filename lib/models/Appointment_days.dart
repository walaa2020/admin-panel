class AppointmentDay {

  String? date;
  String? day_name;
  AppointmentDay.fromJson({required Map<String, dynamic> json}) {
    date = json['date'].toString();
    day_name = json['day_name'].toString();

  }

}
