class Noti {

  String? data;
  String? title;
  int? id;
  Noti.fromJson({required Map<String, dynamic> json}) {
    data = json['data'].toString();
    title = json['title'].toString();
    id = json['id'].toInt();
  }

}