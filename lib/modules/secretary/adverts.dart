import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:reda3/modules/secretary/detail_advret.dart';

import '../../models/advert_model.dart';
import '../../shared/components/constants/constant.dart';

class Adverts extends StatefulWidget {
  const Adverts({super.key});

  @override
  State<Adverts> createState() => _AdvertsState();
}

class _AdvertsState extends State<Adverts> {
  List<AdvertModel>adverts=[];
  List<AdvertModel> parseAdvert(String responseBody) {
    final parsed = jsonDecode(responseBody)['Advert'];
    return List<AdvertModel>.from(parsed.map((json) => AdvertModel.fromJson(json: json)));}
  Future  getAdverts() async {
    Response response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/showWaitingAdverts"),
        headers:
        {
          'Authorization' : 'Bearer ${token!}',
        }
    );
    var responseBody = jsonDecode(response.body);
    // print(responseBody['photo']);
    print("Advertss Data is : $responseBody");
    if (response.statusCode == 200)
    {
      for( var item in responseBody['Advert'] )
      {
        setState(() {
          adverts.add(AdvertModel.fromJson( json: item));
        });
      }

      print(responseBody);

    }
    else
    {
print("error");

    }
  }
  @override
  void initState() {
    super.initState();
    getAdverts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

          child:  Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              DataTable(
                headingRowColor: MaterialStateProperty.resolveWith((
                    states) => Colors.grey.shade200),
                columns:

                [

                  DataColumn(label: Text("id"),),

                  DataColumn(label: Text("image"),),

                  DataColumn(label: Text("status"),),


                  DataColumn(label: Center(

                    child: Container(

                        child: Text("action", textAlign: TextAlign.center,)),

                  ),)

                ],


                rows:

                adverts.map((item) =>
                    DataRow(

                      cells: <DataCell>[

                        DataCell(Text("${item.id}"),),

                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(height: 50, width: 50,

                              child: Image.network("${item.advert_image}")),
                        )),

                        DataCell(Text("${item.status}")),

                        DataCell(


                          Row(crossAxisAlignment: CrossAxisAlignment.center,

                            mainAxisSize: MainAxisSize.min,

                            children: [



                              MaterialButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AdvertDetail(item)));
                              },

                                child: Text("show",style: TextStyle(fontWeight:FontWeight.bold ,color: Colors.white),),


                                color: Colors.red,),

                            ],

                          ),

                        ),

                      ],

                    )).toList(),

                // rows:

                // [

                //   DataRow(cells:[ DataCell(Text("0")),

                //     DataCell(Text("reda3")),

                //     DataCell(Text("0985676464")),

                //     DataCell(Padding(

                //       padding: const EdgeInsets.all(8.0),

                //       child: Row(

                //         children: [

                //           MaterialButton(onPressed: (){

                //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatient()));

                //           },

                //             child: Text("view"),

                //

                //             color: Colors.yellowAccent,),

                //           SizedBox(width: 10,),

                //           MaterialButton(onPressed: (){

                //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatient()));

                //           },

                //             child: Text("delete"),

                //

                //             color: Color(0xFFff0000),),

                //         ],

                //       ),

                //     )),

                //   ]),

                //   DataRow(cells:[ DataCell(Text("0")),

                //     DataCell(Text("reda3")),

                //     DataCell(Text("0985676464")),

                //     DataCell(Padding(

                //       padding: const EdgeInsets.all(8.0),

                //       child: Row(

                //         children: [

                //           MaterialButton(onPressed: (){

                //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatient()));

                //           },

                //             child: Text("view"),

                //

                //             color: Colors.yellowAccent,),

                //           SizedBox(width: 10,),

                //           MaterialButton(onPressed: (){

                //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatient()));

                //           },

                //             child: Text("delete"),

                //

                //             color: Color(0xFFff0000),),

                //         ],

                //       ),

                //     )),

                //   ]),

                // ]

              ),

            ],

          )



      ),
    );
  }
}
