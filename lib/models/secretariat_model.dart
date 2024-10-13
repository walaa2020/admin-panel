class Secretariat {
  String? firstName;
  String? lastName;
  String? email;
  String? passwordCentre;
  String? userName;
  String? address;
  int? phone;
  String? secretary_img;
  String? learningGrades;
  String? updatedAt;
  String? createdAt;
  int? id;
  Secretariat.fromJson({required Map<String, dynamic> json}) {
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    passwordCentre = json['password'].toString();
    userName = json['UserName'].toString();
    address = json['address'].toString();
    phone = json['phone'].toInt();
    secretary_img = json['secretary_img'].toString();
    learningGrades = json['learning_grades'].toString();
    updatedAt = json['updated_at'].toString();
    createdAt = json['created_at'].toString();
    id = json['id'].toInt();
  }

}