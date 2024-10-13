import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/shared/components/constants/constant.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../cubit/admin_cubit/layout_state.dart';
import '../doctor/record.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..fetchDonations(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = LayoutCubit.get(context);
          if (state is GetDonationsSuccessState) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      " Donations  ",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.teal,
                        // Color(0xff243231),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "total_donations :   ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                // Color(0xff243231),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${c.donation!.totalDonations!}",
                              style: const TextStyle(
                                fontSize: 18,
                                color:
                                    // Colors.black,
                                    Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "total_average_donations :   ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                // Color(0xff243231),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${c.donation!.averageDonations!}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                // Color(0xff243231),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.teal.shade300,
                            ),
                            columns: const [
                              DataColumn(
                                  label: Text(
                                " Name",
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                "date",
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                "amount",
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                "receipt",
                                style: TextStyle(color: Colors.white),
                              )),
                            ],
                            rows: (c.donation!.donations)
                                .map((item) => DataRow(
                                      cells: <DataCell>[
                                        // DataCell(Text("${item.id!}"),),

                                        DataCell(Text("${item.name}")),

                                        DataCell(Text("${item.date}")),
                                        DataCell(Text("${item.amount}")),
                                        DataCell(Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Container(
                                                      child: Center(
                                                          child: Image.network(
                                                        "${item.receipt}",
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            1.5,
                                                      )),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                                height: 50,
                                                width: 50,
                                                child: Image.network(
                                                    "${item.receipt}")),
                                          ),
                                        )),
                                        // DataCell(Text("${item.date}")),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
