import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/doctor/record.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/components.dart';


class Referals extends StatelessWidget {
  const Referals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>LayoutCubit()..getReferals(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){

        },
        builder:  (context,state){
          var cubit=LayoutCubit.get(context);
          return Scaffold(body:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutCubit.get(context).referals.isEmpty?Center(child:Text("No Referrals  for this doctor",
              style: TextStyle(color: Colors.teal.shade300,fontWeight: FontWeight.w600,fontSize: 18),),):
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [



                  SizedBox(
                    height: height/30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Referals",
                          style: TextStyle(
                            fontSize: 18,
                            color:
                            // Colors.black,
                            Colors.teal.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: defaultTextFromField(controller: TextEditingController(), type: TextInputType.text, prefixIcon: Icon(Icons.search),
                              label: "Search"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height/30,
                  ),
                  Container(
                    child: DataTable(headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.teal.shade300,),

                        columns: [
                          DataColumn(label: Text("patient",style: TextStyle(color:  Colors.white),),),
                          DataColumn(label: Text("clinc",style: TextStyle(color:  Colors.white),),),
                               DataColumn(label: Text("date",style: TextStyle(color:  Colors.white),),),

                          DataColumn(label: Text("note",style: TextStyle(color:  Colors.white),),),
                        ], rows:   (
                        // LayoutCubit.get(context).filteredRecord.isEmpty?
                      cubit.referals
                            // :cubit.filteredRecord
                            ).map((item)
                        {
                       // print(   cubit.r[int.parse(item.record_id!)].firstName);
                       return DataRow(

                        cells: <DataCell>[


                        DataCell(Text("${item.p!.firstName!} ${item.p!.lastName}")),

                        // DataCell(Text("${item.doctor_name}")),
                        // DataCell(Text("${item.date}")),
                        DataCell(Text("${item.from_clinic}")),
                          DataCell(Text("${item.date}")),
                          DataCell(


                            Row(
                              children: [
                                MaterialButton(onPressed: () {

                                  AlertDialog alertdilog = AlertDialog(
                                    title: Text("notes",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal),),
                                    content: Container(height: height / 1.8,
                                        width: width / 1.8,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(4)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  height: height / 40,),
                                                Container(
                                           child: Text(
                                             "${item.notes}",maxLines: 4,
                                           ),
                                                ),

                                              ]
                                          ),
                                        )),
                                    backgroundColor: Colors.white,
                                 );
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return alertdilog;
                                      });
                                },

                                  child: Text("view"),


                                  color: Colors.yellowAccent,),

                              ],
                            ),

                          ),

                        //


                        ],

                        );}).toList(),

                    ),
                  )
                ],
              ),
            ),
          ),
          );

        },

      ),
    );
  }
}
