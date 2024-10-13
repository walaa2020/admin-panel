class AppointmentModel{
  int?id;
  String ?begin;
  String?end;
  int?duration;
  AppointmentModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'].toInt();
    begin = json['the_beginning_of_the_appointment'].toString();
    end = json['the_end_of_the_appointment'].toString();
    duration=json['duration'].toInt();
  }
}