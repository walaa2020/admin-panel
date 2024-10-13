import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../../shared/components/constants/constant.dart';

class AppointmentDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getDays(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.onChangeIdx(index);
                          cubit.getAppointmentDayDoctor(date: "${cubit.days[index].date}",id: idRole!);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.teal.shade200,
                            border: Border.all(
                              color: cubit.idx == index ? Colors.red : Colors.teal,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${cubit.days[index].day_name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "${cubit.days[index].date}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => Container(height: 10),
                      itemCount: cubit.days.length,
                    ),
                  ),
                ),
                 Padding(
                   padding:  EdgeInsets.only(bottom:30.0),
                   child: VerticalDivider(thickness: 2, width: 1),
                 ),
                Expanded(
                  flex: 11,
                  child: cubit.idx >= 0 && cubit.idx < cubit.days.length
                      ? BlocBuilder<LayoutCubit, LayoutStates>(
                    builder: (context, state) {
                      if (state is LoadToGetAppointmentDayDoctor) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SuccessToGetAppointmentDayDoctor) {
                        return ApointmentD(context, "${cubit.days[cubit.idx].date}");
                      } else {
                        return Center(child: Text('Failed to load appointments.'));
                      }
                    },
                  )
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget ApointmentD(BuildContext context, String date) {
  return BlocProvider(
    create: (context) => LayoutCubit()..getRecord()..getAppointmentDayDoctor(date: date,id: idRole!),
    child: BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = LayoutCubit.get(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.teal.shade300),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal.shade300,width: 1),

                  ),
                  border: TableBorder.all(color: Colors.teal,width: 1),
                  columns: const [
                    DataColumn(label: Text("First Name", style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text("Last Name", style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text("Father Name", style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text("First Time", style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text("End Time", style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text("Type", style: TextStyle(color: Colors.white))),
                    // DataColumn(label: Text("Action", style: TextStyle(color: Colors.white))),
                  ],
                  rows: c.appoint.map((item) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(item.firttName ?? "_")),
                        DataCell(Text(item.lastName ?? "_")),
                        DataCell(Text(item.fathetName ?? "_")),
                        DataCell(Text("${item.start_time}")),
                        DataCell(Text("${item.end_time}")),
                        DataCell(
                          item.is_booked == true
                              ? Text("reverse", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600))
                              : Text("available", style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w600)),
                        ),
//                         DataCell(
//                           MaterialButton(
//                             onPressed: () {
// // print(item.record_id);
//                               // print("${c.r[item.record_id!].firstName}");
//                               // var record = item.record_id != null && item.record_id! >= 0 && item.record_id! < c.r.length+1 ? c.r[item.record_id!-1] : null;
//                               //
//                               // if (record != null) {
//                               //   // print(c.r[item.record_id!].firstName);
//                               //   Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) => RecordPatientDetail1(record, roleId!),
//                               //     ),
//                               //   );
//                               // }
//
//                               // var v=item.record_id;
//                               // var record = item.record_id != null ? c.r[v!] : null;
//                               //
//                               // if (record != null) {
//                               //   Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) => RecordPatientDetail1(record, roleId!),
//                               //     ),
//                               //   );
//                               // }
//                             },
//                             child: Text("view"),
//                             color: Colors.yellowAccent,
//                           ),
//                         ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
