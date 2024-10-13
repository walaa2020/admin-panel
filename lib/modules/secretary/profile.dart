import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: buildProfile(context),
    );
  }

  Widget buildProfile(context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    // بيانات ثابتة لعرضها في التصميم



    return Scaffold(body: SizedBox(

      child: Row(
        children:[
          Padding(
            padding:  EdgeInsets.only(left:width/20),
            child: Column(children: [
              Padding(
                padding:  EdgeInsets.only(top: height/11,),
                child: CircleAvatar(backgroundColor:primaryColor1,radius:width/14 ,),
              ),
              SizedBox(
                height: height/25,
              ),
              Text("Alreda",
                textAlign:TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.teal.shade200,fontSize: 18),),
              SizedBox(
                height: height/40,
              ),
              const Text("Microsurgy",
                textAlign:TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.normal,color:  Colors.black,fontSize: 14),),
            ],),
          ),
          SizedBox(
            width: width/20,
          ),
          Column(

            children: [

              SizedBox(
                height: height/60,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:height/25,
                    ),
                    Text("Profissional Detail",
                      textAlign:TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold,color:  Colors.red,fontSize: 18),),
                    SizedBox(
                      height:height/90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color:  Colors.teal.shade300,
                            width: 1
                        ),

                      ),
                      height: height/3.5,
                      width:width/2,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Text("full name:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("bachelor of medicine   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [

                              Text("first name:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("batol  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [
                              Text("last name:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("bachelor of medicine   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [
                              Text("learning grades:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("bachelor of medicine   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [
                              Text("birthdate:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("neorology   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),

                            Row(children: [
                              Text("Gender:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("male  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),

                          ],
                        ),
                      ),
                    ),



                    SizedBox(
                      height:height/25,
                    ),
                    Text("Contact Details ",
                      textAlign:TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18),),
                    SizedBox(
                      height:height/90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.teal.shade300,
                            width: 1
                        ),
                      ),
                      height: height/3.5,
                      width: width/2,
                      // width: cubit.isExpand?width/2.5:width/1.7,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Text("email:",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("reda3@gmail.com   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [
                              Text("phone number:  ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("09432323234   ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                            Row(children: [
                              Text("address:",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal.shade300,fontSize: 14),),
                              Text("douma ",
                                textAlign:TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.w600,color:Colors.black54,fontSize: 14),),
                            ],),
                          ],
                        ),
                      ),
                    )


                  ],),
              )

            ],
          ),
        ],
      ),
    ),);
  }

  Widget buildProfileRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(title, style: TextStyle(color: Colors.teal.shade300)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.teal.shade300),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
