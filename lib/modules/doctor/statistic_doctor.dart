import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';



  Widget StatisticDoc(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LayoutCubit()..fetchStatisticsD(),
      child:  BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is DoctorStatisticsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DoctorStatisticsLoaded) {
              return SingleChildScrollView(
                child:  Container(
                  height: height,
                  width: width/4,
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("patients",
                        style: TextStyle(
                          color:Colors.teal.shade300,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      SizedBox(
                        height: height/40,
                      ),
                      Container(
                        child:  PieChart(
                          dataMap: LayoutCubit.get(context).monthlyVisitsData,
                          chartRadius: MediaQuery.of(context).size.width / 1.7,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.right,
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            chartValueStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            chartValueBackgroundColor: Colors.deepPurple.shade50,
                            showChartValueBackground: true,
                            showChartValuesInPercentage: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height/40,
                      ),
                      Text("reservations",
                        style: TextStyle(
                          color:Colors.teal.shade300,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      SizedBox(
                        height: height/40,
                      ),
                      Container(

                        child:  PieChart(
                          dataMap: LayoutCubit.get(context).weeklyAppointmentsData,
                          chartRadius: MediaQuery.of(context).size.width / 1.7,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.right,
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            chartValueStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            chartValueBackgroundColor: Colors.deepPurple.shade50,
                            showChartValueBackground: true,
                            showChartValuesInPercentage: true,
                          ),
                        ),
                      ),

                    ],),
                ),
              );
            } else if (state is DoctorStatisticsError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return Container(); // حالة البداية
          },
        ),
    );

  }

