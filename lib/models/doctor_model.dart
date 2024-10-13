class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? passwordCentre;
  String? userName;
  String? gender;
  String? address;
  int? phone;
  String? doctorImg;
  String? learningGrades;
  String? specializationsId;
  int? clinicsId;
  String? updatedAt;
  String? createdAt;
  int? id;
  Data.fromJson({required Map<String, dynamic> json}) {
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    passwordCentre = json['password_Centre'].toString();
    userName = json['UserName'].toString();
    gender = json['gender'].toString();
    address = json['address'].toString();
    phone = json['phone'].toInt();
    doctorImg = json['doctor_img'].toString();
    learningGrades = json['learning_grades'].toString();
    specializationsId = json['specialization'].toString();
    clinicsId = json['clinics_id'].toInt();
    updatedAt = json['updated_at'].toString();
    createdAt = json['created_at'].toString();
    id = json['id'].toInt();
  }
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password_Centre': passwordCentre,
      'UserName': userName,
      'gender': gender,
      'address': address,
      'phone': phone,
      'doctor_img': doctorImg,
      'learning_grades': learningGrades,
      'specialization': specializationsId,
      'clinics_id': clinicsId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}


