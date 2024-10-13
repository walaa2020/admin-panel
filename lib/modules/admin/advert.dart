import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_cubit.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/modules/admin/advert_details.dart';

class Advert extends StatelessWidget {
  const Advert({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getAdverts(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
            return Scaffold(
              body: BlocBuilder<LayoutCubit, LayoutStates>(
                  builder: (context, state) {
                if (state is GetAdvertsSuccessState) {
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DataTable(
                        headingRowColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.grey.shade200),
                        columns: [
                          const DataColumn(
                            label: Text("id"),
                          ),
                          const DataColumn(
                            label: Text("image"),
                          ),
                          const DataColumn(
                            label: Text("status"),
                          ),
                          DataColumn(
                            label: Center(
                              child: Container(
                                  width: 250,
                                  child: const Text(
                                    "action",
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          )
                        ],
                        rows: state.advert
                            .map((item) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text("${item.id}"),
                                    ),
                                    DataCell(Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          child: Image.network(
                                              "${item.advert_image}")),
                                    )),
                                    DataCell(Text("${item.status}")),
                                    DataCell(
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              cubit.advertReject(id: item.id!);
                                            },
                                            color: Colors.yellowAccent,
                                            child: const Text("reject"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              cubit.advertApprove(id: item.id!);
                                            },
                                            child: Text("approved"),
                                            color: Color(0xFFff0000),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdvertDetail(item)));
                                            },
                                            child: Text("show"),
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            );
          }),
    );
  }
}
