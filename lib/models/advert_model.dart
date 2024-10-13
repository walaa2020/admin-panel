class AdvertModel {

  String? description;
  String? advert_image;
  int? id;

  String? status;
  String? previous_status;

  AdvertModel.fromJson({required Map<String, dynamic> json}) {
    description = json['description'].toString();
    advert_image = json['advert_image'].toString();
    id = json['id'].toInt();
    status = json['status'].toString();
    previous_status = json['previous_status'].toString();
  }

}