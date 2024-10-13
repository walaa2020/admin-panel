import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/modules/admin/doctor_in_clinic.dart';
import 'package:reda3/modules/admin/statistics_groop_age.dart';
import 'package:reda3/shared/components/components.dart';

import '../../cubit/admin_cubit/layout_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit()
        ..getClinic()
        ..getSecretariat()
        ..fetchStatisticsNumVisit()
        ..fetchStatisticsNumVisit()
        ..getMostFrequentAge()
        ..fetchStatisticsNumPatient(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          String? numVisit = cubit.numVisit;
          String? numP = cubit.numPatient;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.login,
                                              size: 26.0,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Text(
                                              "visits",
                                              style: TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "$numVisit visit",
                                          style: const TextStyle(
                                            fontSize: 36,
                                            color: Colors.red,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.people,
                                              size: 26.0,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Text(
                                              "Patients",
                                              style: TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "$numP Patients",
                                          style: const TextStyle(
                                            fontSize: 36,
                                            color: Colors.amber,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.timelapse,
                                              size: 26.0,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                "fraction of age",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "${cubit.mostFrequentAge}",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          SizedBox(
                              height: height / 3,
                              child: DoctorDashboard(context, 3)),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: height / 3,
                              width: double.infinity,
                              child: SecritariaDashboard(context)),
                          SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Clinic",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GridView.builder(
                              itemCount: cubit.clinics.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 30,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: 0.9),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Doctors(cubit
                                              .clinics[index].id!
                                              .toInt())),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: ClipOval(
                                              child: Image.network(
                                                "${cubit.clinics[index].image}",
                                                // fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "${cubit.clinics[index].clinicName}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Text(
                              "Fraction of age",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          Container(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: statisticGroupAge(context),
                            ),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Text(
                              "visits",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            // height: 200,
                            // width: 200,
                            child: StatisticsVisit(context),
                            //   defaultPieChart(
                            //       raduis: MediaQuery.of(context).size.width / 9),
                            //
                          ),
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Text(
                              "patients",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: StatisticsPatient(context),
                          ),
                        ],
                      ),
                    ),
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
