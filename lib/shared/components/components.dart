
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reda3/models/patient_detail.dart';
import 'package:reda3/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../models/clinic_model.dart';
import '../../modules/admin/doctor_in_clinic.dart';
import '../../modules/admin/doctor_information.dart';
import '../../modules/doctor/record.dart';
import 'constants/constant.dart';

Widget defaultextformfield({
  required TextEditingController controlle,
  required TextInputType type,
  required Widget prefixIcon,

  required String label,
  Function? onSubmit,
  Function? onChange,
  String? Function(String?)? validate,
  bool? obscureText,
  IconData? suffixIcon,
  bool ispassword = false,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controlle,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,

        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            suffixPressed!();
          },
        )
            : null,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onFieldSubmitted: (s) {
        return onSubmit!(s);
      },
      validator: (s) {
        return validate!(s);
      },
    );
Widget defaultTextFromField({
  required TextEditingController controller,
  required TextInputType type,
  required Widget prefixIcon,
  double radius=24,
  required String label,
  Function? onSubmit,
  Function? onChange,
  String? Function(String?)? validate,
  bool? obscureText,
  IconData? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
  String ?hitText,
  int line=1
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,

maxLines: line,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hitText,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            suffixPressed!();
          },
        )
            : null,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onFieldSubmitted: (s) {
        return onSubmit!(s);
      },
      validator: (s) {
        return validate!(s);
      },
    );
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
Widget defaultPieChart({

var raduis=6,

})=> PieChart(
dataMap: dataMap,
chartRadius:raduis,

legendOptions: LegendOptions(
// showLegends: false,
legendPosition: LegendPosition.right,
// legendTextStyle: TextStyle(
//   color: Colors.deepPurple
// )
),
chartValuesOptions: ChartValuesOptions(
chartValueStyle:TextStyle(
color: Colors.black,
fontSize: 8,
fontWeight: FontWeight.bold
) ,
chartValueBackgroundColor: Colors.deepPurple.shade50,
showChartValueBackground: true,
showChartValuesInPercentage: true,
),
);



Widget StatisticsVisit(BuildContext context) {
  return BlocProvider(
    create: (context)=>LayoutCubit()..fetchStatistics(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){

      },
      builder:  (context,state){
        return BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is StatisticsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StatisticsLoaded) {
              return PieChart(
                dataMap: state.dataMap,
                chartRadius: MediaQuery.of(context).size.height/5,
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
              );
            } else if (state is StatisticsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },

        );

      },

    ),
  );

}
Widget StatisticsPatient(BuildContext context) {
  return BlocProvider(
    create: (context)=>LayoutCubit()..fetchStatisticsP(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){

      },
      builder:  (context,state){
        return BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is StatisticsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StatisticsLoaded) {
              return PieChart(
                dataMap: state.dataMap,
                chartRadius: MediaQuery.of(context).size.height/5,
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
              );
            } else if (state is StatisticsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },

        );

      },

    ),
  );

}

Widget DoctorDashboard(BuildContext context,int x) {
  double height= MediaQuery.of(context).size.height;

  return BlocProvider(
    create: (context)=>LayoutCubit()..getDoctor(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){
      },
      builder:  (context,state){
        var cubit=LayoutCubit.get(context);

        return

          Scaffold(
            body:    Container(
                height: height/x,
                width: double.infinity,
                child: BlocBuilder<LayoutCubit, LayoutStates>(
                    builder: (context, state) {
                      if (state is GetDoctorLoadState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AccountListLoaded) {
                        return
                          SingleChildScrollView(
                          child:
                          state.doctors.length>0?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Expanded(flex: 3,
                                      child: Text(
                                        "doctors",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                          // Colors.black,
                                          Color(0xff243231),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Expanded(child: Container(
                                    //   height: 55,
                                    //   child: OutlinedButton(
                                    //
                                    //     onPressed: (){
                                    //       cubit.onChanged(4);
                                    //
                                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDoctor()));
                                    //     },
                                    //     child: Text(
                                    //       "insert doctor",
                                    //       style: TextStyle(
                                    //         fontSize: 14,
                                    //         //     decoration: TextDecoration.underline,decorationColor: Colors.blue,
                                    //         color:
                                    //         // Colors.black,
                                    //         Colors.black,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ) ,
                                    //   ),
                                    // )),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                        TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            labelText: "search",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          onChanged: (input){

                                            cubit.filterDoctor(input: input);
                                          },
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              DataTable(headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),

                                columns: [
                                  DataColumn(label: Text("id"),),
                                  DataColumn(label: Text("name"),),
                                  DataColumn(label: Text("address"),),
                                  DataColumn(label: Text("phone"),),
                                  DataColumn(label: Text("action"),)
                                ],
                                rows:

                                cubit.filteredDoctors.isEmpty?

                                state.doctors.map((item)
                                {
                                  Clinic? foundClinic;
                                  List<Clinic>c= cubit.clinics;
                                  Clinic? findClinicById(List<Clinic> clinics, int id)  {
                                    try {
                                      return   clinics.firstWhere((clinic) => clinic.id == id);
                                    } catch (e) {
                                      return null;
                                    }

                                  };
                                  foundClinic=findClinicById(c,item.clinicsId!);

                                  return DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text("${item.id}")),
                                                  DataCell(
                                                      Text("${item.userName}")),
                                                  DataCell(Text(
                                                      "${item.address}")),
                                                  DataCell(Text("${item.phone}")),
                                                  DataCell(
                                                    Row(
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        DoctorInformation(
                                                                            item,
                                                                            1)));
                                                          },
                                                          child: Text("view"),
                                                          color:
                                                              Colors.yellowAccent,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            await cubit
                                                                .deleteDoctor(
                                                                    "${item.id}");
                                                            cubit.getDoctor();
                                                          },
                                                          child: Text("delete"),
                                                          color: Color(0xFFff0000),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList()
                                    :
                                cubit.filteredDoctors.map((item) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text("${item.id}")),
                                    DataCell(Text("${item.userName}")),
                                    DataCell(Text("${item.address}")),
                                    DataCell(Text("${item.phone}")),
                                    DataCell(

                                      Row(
                                        children: [
                                          MaterialButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorInformation(item,1)));
                                          },
                                            child: Text("view"),

                                            color: Colors.yellowAccent,),
                                          SizedBox(width: 10,),
                                          MaterialButton(onPressed: (){
                                            cubit.deleteDoctor("${item.id}");
                                            cubit.getDoctor();
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordPatient()));
                                          },
                                            child: Text("delete"),

                                            color: Color(0xFFff0000),),
                                        ],
                                      ),
                                    ),
                                  ],
                                )).toList() ,

                              ),
                            ],
                          ):Center(child: Text("No Doctors in Center")),
                        );
                      }
                      else if(state is FilterDoctorsSuccessState){
                    return    DataTable(headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),

                          columns: [
                            DataColumn(label: Text("id"),),
                            DataColumn(label: Text("name"),),
                            DataColumn(label: Text("address"),),
                            DataColumn(label: Text("phone"),),
                            DataColumn(label: Text("action"),)
                          ],
                          rows:

                          state.filterDoctors.map((item)
                          {
                            Clinic? foundClinic;
                            List<Clinic>c= cubit.clinics;
                            Clinic? findClinicById(List<Clinic> clinics, int id)  {
                              try {
                                return   clinics.firstWhere((clinic) => clinic.id == id);
                              } catch (e) {
                                return null;
                              }

                            };
                            foundClinic=findClinicById(c,item.clinicsId!);

                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text("${item.id}")),
                                DataCell(
                                    Text("${item.userName}")),
                                DataCell(Text(
                                    "${item.address}")),
                                DataCell(Text("${item.phone}")),
                                DataCell(
                                  Row(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DoctorInformation(
                                                          item,
                                                          1)));
                                        },
                                        child: Text("view"),
                                        color:
                                        Colors.yellowAccent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await cubit
                                              .deleteDoctor(
                                              "${item.id}");
                                          cubit.getDoctor();
                                        },
                                        child: Text("delete"),
                                        color: Color(0xFFff0000),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList()


                        );
                      }
                      else{
                        return Center(child: Text("No Doctors in Center"));
                      }
                    })
            ),);
      },

    ),
  );

}
Widget Clincs(BuildContext context){
  return      BlocProvider(
    create: (context)=>LayoutCubit()..getDoctor()..getClinic(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){
      },
      builder:  (context,state){
        var cubit=LayoutCubit.get(context);
        return
          Scaffold(
            body:


              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(flex: 3,
                            child: Text(
                              "Clinics",
                              style: TextStyle(
                                fontSize: 25,
                                color:
                                // Colors.black,
                                Color(0xff243231),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:            TextFormField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        labelText: "search",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onChanged: (input){

                                        cubit.filterClinics(input: input);
                                      },
                                    ),),
                            ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),

                        child: GridView.builder(

                          itemCount:   cubit.filteredClinics.isEmpty?cubit.clinics.length:cubit.filteredClinics.length,

                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 30,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.9
                          ),
                          itemBuilder: (context,index)
                          {
                            return
                              GestureDetector(

                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Doctors(cubit.filteredClinics.isEmpty?cubit.clinics[index].id!.toInt():cubit.filteredClinics[index].id!.toInt())),
                                  );
                                },
                                // child: Card(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: ClipOval(
                                            child: Image.network(
                                        cubit.filteredClinics.isEmpty?      "${cubit.clinics[index].image}":"${cubit.filteredClinics[index].image}",
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        cubit.filteredClinics.isEmpty?   "${cubit.clinics[index].clinicName}":"${cubit.filteredClinics[index].clinicName}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              );

                          }
            ),

                    ),
                  ],
                ),
              ),);
      },

    ),
  );

  //
  //   GridView.builder(
  //
  //     itemCount:  cubit.clinics.length,
  //
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 4,
  //         mainAxisSpacing: 30,
  //         crossAxisSpacing: 15,
  //         childAspectRatio: 0.9
  //     ),
  //     itemBuilder: (context,index)
  //     {
  //       return
  //         GestureDetector(
  //
  //           onTap: () {
  //
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => Doctors(cubit.clinics[index].id!.toInt())),
  //             );
  //           },
  //           // child: Card(
  //           child: Container(
  //             width: double.infinity,
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     child: ClipOval(
  //                       child: Image.network(
  //                         "${cubit.clinics[index].image}",
  //                         // fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   "${cubit.clinics[index].clinicName}",
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // ),
  //         );
  //
  //     }
  // ),
}






Widget SecritariaDashboard(BuildContext context) {
  double height= MediaQuery.of(context).size.height;

  return BlocProvider(
    create: (context)=>LayoutCubit()..getSecretariat(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){
      },
      builder:  (context,state){
        var cubit=LayoutCubit.get(context);

        return
          Scaffold(
            body:    Container(
                height: height/3,
                width: double.infinity,
                child: BlocBuilder<LayoutCubit, LayoutStates>(
                  builder: (context, state) {
                    if(state is GetSecretariatLoadState){
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is GetSecretariatSuccessState){
                      return SingleChildScrollView(
                        child: state.secretariat.length > 0 ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(flex: 3,
                                    child: Text(
                                      "secretariat",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                        // Colors.black,
                                        Color(0xff243231),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        labelText: "search",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onChanged: (input) {
                                        cubit.filterSecretarait(input: input);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataTable(
                              headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
                              columns: [
                                DataColumn(label: Text("id")),
                                DataColumn(label: Text("name")),
                                DataColumn(label: Text("phone")),
                                DataColumn(label: Text("action")),
                              ],
                              rows: state.secretariat.map((item) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("${item.id}")),
                                  DataCell(Text("${item.userName}")),
                                  DataCell(Text("${item.phone}")),
                                  DataCell(
                                    Row(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorInformation(item, 2)));
                                          },
                                          child: Text("view"),
                                          color: Colors.yellowAccent,
                                        ),
                                        SizedBox(width: 10),
                                        MaterialButton(
                                          onPressed: () {
                                            cubit.deleteSecretariat("${item.id}");
                                          },
                                          child: Text("delete"),
                                          color: Color(0xFFff0000),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )).toList(),
                            ),
                          ],
                        ) : Center(child: Text("No secretiate in center")),
                      );
                    }
                    // if (state is GetSecretariatSuccessState){
                    //   return  SingleChildScrollView(
                    //       child: state.secretariat.length>0?Column(
                    //         children: [
                    //           TextFormField(
                    //             decoration: InputDecoration(
                    //               prefixIcon: Icon(Icons.search),
                    //               labelText: "search",
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(20),
                    //               ),
                    //             ),
                    //             onChanged: (input){
                    //
                    //               cubit.filterSecretarait(input: input);
                    //             },
                    //           ),
                    //           DataTable(headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200),
                    //
                    //             columns: [
                    //               DataColumn(label: Text("id"),),
                    //               DataColumn(label: Text("name"),),
                    //               DataColumn(label: Text("phone"),),
                    //               DataColumn(label: Text("action"),)
                    //             ],
                    //
                    //             rows:
                    //             (state.secretariat).map((item) => DataRow(
                    //               cells: <DataCell>[
                    //                 DataCell(Text("${item.id}"),),
                    //                 DataCell(Text("${item.userName}")),
                    //                 DataCell(Text("${item.phone}")),
                    //                 DataCell(
                    //
                    //                   Row(
                    //                     children: [
                    //                       MaterialButton(onPressed: (){
                    //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorInformation(item,2)));
                    //                       },
                    //                         child: Text("view"),
                    //
                    //                         color: Colors.yellowAccent,),
                    //                       SizedBox(width: 10,),
                    //                       MaterialButton(onPressed: (){
                    //                         cubit.deleteSecretariat("${item.id}");
                    //                       },
                    //                         child: Text("delete"),
                    //
                    //                         color: Color(0xFFff0000),),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             )).toList(),),
                    //         ],
                    //       )
                    //           : Center(child: Text("No secretiate in center"))
                    //
                    //   );
                    //
                    // }
                    else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },

                ),
            ),);
      },

    ),
  );

}

Widget RecordP(BuildContext context,int role) {
  return BlocProvider(
    create: (context)=>
    role==1?(LayoutCubit()..getRecord()):(LayoutCubit()..getRecordForDoctor()),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){

      },
      builder:  (context,state){
        var c=LayoutCubit.get(context);
        return
          SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Patient",
                        style: TextStyle(
                          fontSize: 24,
                          color:
                          Colors.black,
                          // Colors.teal.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(width:MediaQuery.of(context ).size.width/1.6),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Searsh Record",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),

                            ),
                            onChanged:  (input){

                              c.filterRecord(input: input);
                            },

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
         SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: DataTable(

                      headingRowColor: MaterialStateProperty.resolveWith(
                            (states) =>  Colors.teal.shade300,),
                      columns: const [
                        DataColumn(
                            label: Text(
                              "First Name",
                              style: TextStyle(color: Colors.white),
                            )),
                        DataColumn(
                            label: Text(
                              "Last Name",
                              style: TextStyle(color: Colors.white),
                            )),
                        DataColumn(
                            label: Text(
                              "Phone",
                              style: TextStyle(color: Colors.white),
                            )),
                        // DataColumn(
                        //     label: Text(
                        //       "Date",
                        //       style: TextStyle(color: Colors.white),
                        //     )),
                        DataColumn(
                            label: Text(
                              "Address",
                              style: TextStyle(color: Colors.white),
                            )),
                        // DataColumn(
                        //     label: Text(
                        //       "Timer",
                        //       style: TextStyle(color: Colors.white),
                        //     )),
                        DataColumn(
                            label: Text(
                              "gender",
                              style: TextStyle(color: Colors.white),
                            )),
                        DataColumn(
                            label: Text(
                              "birthdate",
                              style: TextStyle(color: Colors.white),
                            )),
                        DataColumn(
                            label: Text(
                              "Action",
                              style: TextStyle(color: Colors.white),
                            )),

                      ],
                      rows:  (c.filteredRecord.isEmpty?(role==1?c.r:c.rd):c.filteredRecord).map((item) =>
                          DataRow(

                            cells: <DataCell>[

                              // DataCell(Text("${item.id!}"),),

                              DataCell(Text("${item.firstName}")),

                              DataCell(Text("${item.lastName}")),
                              DataCell(Text("${item.phone}")),
                              // DataCell(Text("${item.date}")),
                              DataCell(Text("${item.address}")),
                              DataCell(Text("${item.gender}")),
                              DataCell(Text("${item.birthdate}")),
                              DataCell(


                                MaterialButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      RecordPatientDetail1(item,role)));
                                },

                                  child: Text("view"),


                                  color: Colors.yellowAccent,),

                              ),

                            ],

                          )).toList(),
                    ),
                  ),

              ],
            ),
          );


      },

    ),
  );


}


void showAlert(BuildContext context,String text, Color c) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Container(width: 50,
          child: Center(
            child: Text(
              text,style: TextStyle(color: c,fontSize: 18),
            ),
          ),),
        backgroundColor: Colors.white,
      );
    },
  );}


Widget StatisticsVisitD(BuildContext context) {
  return BlocProvider(
    create: (context)=>LayoutCubit()..fetchStatistics(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){

      },
      builder:  (context,state){
        return BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            if (state is StatisticsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StatisticsLoaded) {
              return PieChart(
                dataMap: state.dataMap,
                chartRadius: MediaQuery.of(context).size.height/5,
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
              );
            } else if (state is StatisticsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },

        );

      },

    ),
  );

}

Widget getSt(context){
  return BlocProvider<LayoutCubit>(
    create: (context)=>LayoutCubit()..fetchStatistic(),
    child: BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return
          state is fetchSttisticLoading?Center(child: CircularProgressIndicator()):state is fetchSttisticLoaded?
          Container(height: 200,
            width: MediaQuery.of(context).size.width*2/3,
            child:   Row(children: [

              Flexible(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Number Patients",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${ state.profile.patients}  Patients",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_hospital_sharp,
                              size: 26.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Number visits",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${ state.profile.visits}  Visits",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle_rounded,
                              size: 20.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Number AppointMent",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${ state.profile.appointments}  Appointments",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],),
          )
              :Center(child: CircularProgressIndicator());
      },
    ),
  );
}
