import 'package:reda3/models/patient_detail.dart';

class ReferalModel {

  String? from_clinic;
  String? date;
  String? notes;
  PatientDetails?p;

  ReferalModel.fromJson({required Map<String, dynamic> json}) {
    from_clinic = json['from_clinic'].toString();
    date = json['date'].toString();
    notes = json['notes'].toString();
    p=PatientDetails.fromJson(json['patient_record']);

  }

}