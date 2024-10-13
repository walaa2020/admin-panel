class Clinic {

  String? clinicName;
  String? image;
  int? id;
  Clinic.fromJson({required Map<String, dynamic> json}) {
    clinicName = json['clinic_name'].toString();
    image = json['clinic_img'].toString();
    id = json['id'].toInt();
  }

}