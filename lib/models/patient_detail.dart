import 'dart:convert';

class PatientDetails {
  final int id;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String birthdate;
  final String gender;
  final String address;
  final int mobileNumber;
  final String bloodType;
  final String socialStatus;
  final String job;
  final String previousOperations;
  final String allergyToMedication;
  final String chronicDiseases;
  final String firstNameAlternate;
  final String lastNameAlternate;
  final int phone;
  final List<String> xRayUrls;
  final List<String> analysisUrls;
  final List<Map<String, dynamic>> descriptions;
  final DateTime createdAt;
  final DateTime updatedAt;

  PatientDetails({
    required this.id,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.mobileNumber,
    required this.bloodType,
    required this.socialStatus,
    required this.job,
    required this.previousOperations,
    required this.allergyToMedication,
    required this.chronicDiseases,
    required this.firstNameAlternate,
    required this.lastNameAlternate,
    required this.phone,
    required this.xRayUrls,
    required this.analysisUrls,
    required this.descriptions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      id: json['id'],
      firstName: json['first_name'],
      fatherName: json['father_name'],
      lastName: json['last_name'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      address: json['address'],
      mobileNumber: json['moblie_num'],
      bloodType: json['Blood_type'],
      socialStatus: json['social_status'],
      job: json['job'],
      previousOperations: json['Previous_Opertios'],
      allergyToMedication: json['AllergyToMedication'],
      chronicDiseases: json['Chronic_Diseases'],
      firstNameAlternate: json['_first_name'],
      lastNameAlternate: json['_last_name'],
      phone: json['phone'],
      xRayUrls: json['X_ray'] != null ? List<String>.from(jsonDecode(json['X_ray'])) : [],
      analysisUrls: json['analysis'] != null ? List<String>.from(jsonDecode(json['analysis'])) : [],
      descriptions: json['description'] != null
          ? List<Map<String, dynamic>>.from(jsonDecode(json['description']))
          : [],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
