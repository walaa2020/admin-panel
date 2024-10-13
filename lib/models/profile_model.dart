class ProfileModel{
   String ? centerName;
   String? image;
   int?phone;
   String ?description;

   ProfileModel.fromJson({required Map<String, dynamic> json}) {
     centerName = json['center_name'].toString();
     image = json['center_img'].toString();
     phone = json['phone'].toInt();
     description = json['description'].toString();
   }
}