class ArticleModel {
  String? title;
  String? content;
  int? doctorsId;
  String? updatedAt;
  String? createdAt;
  int? id;


  ArticleModel(  String? title,
  String? content,
  int? doctorsId,
  String? updatedAt,
  String? createdAt,
  int? id,){
    title=this.title;
    content=this.content;
    doctorsId= this.doctorsId;
    updatedAt= this.updatedAt;
    createdAt= this.createdAt;
    id=this.id;
  }


  ArticleModel.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    content = json['content'].toString();
    doctorsId = json['doctors_id'].toInt();
    updatedAt = json['updated_at'].toString();
    createdAt = json['created_at'].toString();
    id = json['id'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['doctors_id'] = this.doctorsId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;


  }
}