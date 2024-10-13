import 'package:flutter/material.dart';

import '../../models/patient_detail.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../doctor/showfile.dart';

class Record_Midecal extends StatelessWidget {
  Record_Midecal(this.record,this.r);
  late int r;
  late PatientDetails record;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    var descriptionController = TextEditingController();

    return        Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
            color: primaryColor1.shade900,),
        ),
        title: Text("Record Patient",

          style: TextStyle(fontWeight: FontWeight.bold,
            color: primaryColor1.shade900,
            fontSize: 18,
          ),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(

              width: width / 2.4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Personal Detail",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: primaryColor1,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor1
                        ),),

                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [

                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("first name :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.firstName} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("last name :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.lastName} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("father name :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.fatherName} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                        ],),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [

                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("mobile num:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.phone} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("adress :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.address} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("gender :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.gender} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                        ],),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [

                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("birth date :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.gender}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("Social State :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.socialStatus} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("job:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.job} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                        ],),
                      SizedBox(
                        height: 8,
                      ),

                      Text("contact for contgent state",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: primaryColor1,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor1
                        ),),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [

                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("first name :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.firstNameAlternate} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("last name :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${record.lastNameAlternate} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),
                          Column(crossAxisAlignment: CrossAxisAlignment
                              .start,
                            children: [

                              Text("phone num:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),),
                              Text("${ record.mobileNumber} ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 13),),
                            ],),

                        ],),
                      SizedBox(
                        height: 8,
                      ),
                      Text("medical history",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: primaryColor1,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor1),),
                      SizedBox(
                        height: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text("previous operations :",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(" ${record.previousOperations}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontSize: 13,),),
                          ),
                        ],),
                      SizedBox(
                        height: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text("Allergy to medications:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text("${record.allergyToMedication}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontSize: 13,),),
                          ),
                        ],),
                      SizedBox(
                        height: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text("chronic diseases:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(" ${record.chronicDiseases}",
                              textAlign: TextAlign.left,

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontSize: 13,),),
                          ),
                        ],),
                      SizedBox(
                        height: height / 15,
                      ),
                      r==1?Container(): Row(
                        children: [



                          SizedBox(
                            width: width / 40,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => FileScreen(record.id)));
                              },
                              child: Text("show file", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),)),
                        ],
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      r==1?Container(): Row(children: [
                        SizedBox(
                          width: width / 44,
                        ),

                      ],),
                      r==1?                     ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => FileScreen(record.id)));
                          },
                          child: Text("show file", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),)):Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: width/10,),
            SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("detail description:",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,fontSize: 24
                  ),),
                  SizedBox(height:30,),
                  ...record.descriptions.map((desc) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Doctor Name:   ',style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                            Text(' ${desc['Doctor Name']}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Date:   ',  style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                            Text(' ${desc['date']}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Description:  ',  style: TextStyle(fontWeight: FontWeight.bold,color:primaryColor1,fontSize: 15)),
                            Text('Description: ${desc['description']}'),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(height:1,color: Colors.black54,width:width/3.5),
                        SizedBox(height: 20,),
                      ],
                    );
                  }),
                ],),
            )


          ],
        ),
      ),
    );
  }
}

Widget BuildRecordItem() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        const Text(
          "doctor:",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFF01579B), fontSize: 15),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(
            "   first name ",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontSize: 13),
          ),
        ),
      ]),
      Row(children: [
        const Text(
          "date :",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFF01579B), fontSize: 15),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            "   first name ",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontSize: 13),
          ),
        ),
      ]),
      const Text(
        "description :",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Color(0xFF01579B), fontSize: 15),
      ),
      Container(
        child: const Text(
          "patient is good state and ..."
          "patient is good state and ..."
          "patient is good state and ..."
          "patient is good state and ...patient is good state and ..."
          "patient is good spatient is good state and ...tate and ...patient is good state and ..."
          "patient is good state and ...jjkhk"
          " ",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
        ),
      ),
    ],
  );
}
