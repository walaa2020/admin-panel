

class AppointmentM {
   String ?  start_time;
   String? end_time;
   bool ?is_booked;
   String? firttName;
   String ?fathetName;
   String ?lastName;
   int?record_id;
   int?user_appointment_id;

  AppointmentM({
    required this.  start_time,
    required this.end_time,
    required this.is_booked,
    required this.firttName,
    required this.fathetName,
    required this.lastName,
    required this.record_id,
    required this.user_appointment_id,

  });

  AppointmentM.fromJson(Map<String, dynamic> json) {
      start_time= json['start_time'];
      end_time= json['end_time'];
      is_booked= json['is_booked'];
      firttName= json['firstName'];
      fathetName= json['fathetName'];
      lastName= json['lastName'];
      record_id = json['record_id'] != null ? json['record_id'].toInt() : null;
      user_appointment_id = json['user_appointment_id'] != null ? json['user_appointment_id'].toInt() : null;
  }

}