import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reda3/main.dart';
import 'package:reda3/main.dart';
import 'package:reda3/modules/doctor/record.dart';
import 'package:reda3/modules/doctor/statistic_doctor.dart';
import 'package:reda3/shared/components/components.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/constants/constant.dart';


class DashboardDoctor extends StatelessWidget {
  const DashboardDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Jan": 5,
      "Feb": 3,
      "Mar": 2,
      "Apr": 1,
      "May": 2,
      "Jun": 1,
      "Jul": 2,
      "Aug": 0,
      "Sep": 9,
      "Oct": 1,
      "Nov": 2,
      "Dec": 2,
    };
    Map<String, double> data = {
      "Sat": 5,
      "Sun": 1,
      "Mon": 3,
      "Tue": 2,
      "Thr": 1,
      "Fri": 2,


    };

    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return  BlocProvider(
      create: (context)=>LayoutCubit()..getRecord()..getNotiDoctor(),
      child: BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){

        },
        builder:  (context,state){
          var cubit=LayoutCubit.get(context);
          return Scaffold(backgroundColor: Color(0xF3F3F3),
            body:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              Row(
                children: [

                  Expanded( flex: 3,
                    child:SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          getSt(state),
                          SizedBox(
                            height: height/30,
                          ),

                          Container(height: 500,
                              child: RecordP(context,roleId!)),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:[

                                SizedBox(
                                  height: height/30,
                                ),

                                // DataTable(headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.teal.shade300,),
                                //
                                //     columns: [
                                //       DataColumn(label: Text("id",style: TextStyle(color:  Colors.white),),),
                                //       DataColumn(label: Text("name",style: TextStyle(color:  Colors.white),),),
                                //       DataColumn(label: Text("phone",style: TextStyle(color:  Colors.white),),),
                                //       DataColumn(label: Text("action",style: TextStyle(color:  Colors.white),),)
                                //     ], rows: [
                                //       DataRow(cells:[ DataCell(Text("0")),
                                //         DataCell(Text("reda3")),
                                //         DataCell(Text("0985676464")),
                                //         DataCell(Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: MaterialButton(onPressed: (){
                                //            Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatientDetail()));
                                //           },
                                //             child: Text("view"),
                                //             color: Colors.blue,),
                                //         )),
                                //       ]),
                                //       DataRow(
                                //         //color: MaterialStateProperty.resolveWith((states) => Colors.purple.shade100),
                                //           cells:[ DataCell(Text("0")),
                                //             DataCell(Text("reda3")),
                                //             DataCell(Text("0985676464")),
                                //             DataCell(Padding(
                                //               padding: const EdgeInsets.all(8.0),
                                //               child: MaterialButton(onPressed: (){
                                //
                                //               },
                                //                 child: Text("view"),
                                //                 color: Colors.blue,),
                                //             )),
                                //           ]),
                                //
                                //
                                //     ]),
                              ]
                          )
                        ],
                      ),
                    ),),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child:   StatisticDoc(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

        },

      ),
    );
  }
}