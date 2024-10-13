import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/modules/admin/update_advert.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import 'advert_details.dart';

class AdvertShow extends StatelessWidget {
  const AdvertShow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..fetchAdverto(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: BlocBuilder<LayoutCubit, LayoutStates>(
                builder: (context, state) {
              if (state is GetAdvertsShowingSuccessState) {
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
                              width: 150,
                              child: const Center(
                                child: Text(
                                  "action",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                      rows: state.h
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdvertDetail(item)));
                                          },
                                          color: Colors.yellow,
                                          child: const Text("show"),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateAdvert(
                                                            item.id!)));
                                          },
                                          color: Colors.blue,
                                          child: const Text("update"),
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
        },
      ),
    );
  }
}
