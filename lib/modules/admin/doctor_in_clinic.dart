import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda3/cubit/admin_cubit/layout_state.dart';
import 'package:reda3/modules/admin/doctor_information.dart';
import '../../cubit/admin_cubit/layout_cubit.dart';
import '../../models/doctor_model.dart';

class Doctors extends StatelessWidget {
  Doctors(this.idClinic);
  late final int idClinic;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getDoctorsClinic(idClinic),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          if (state is GetDoctorInClinicSuccessState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white12,
                elevation: 0,
                title: Text(
                  'AlReda',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.teal.shade300,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(2, 2),
                      ),
                    ],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.teal.shade300),
              ),
              body: Padding(
                padding: EdgeInsets.all(16),
                child: BlocBuilder<LayoutCubit, LayoutStates>(
                    builder: (context, state) {
                  if (state is GetDoctorInClinicSuccessState) {
                    return state.doctor.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 400.0,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "Search Doctor",
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          onChanged: (input) {
                                            cubit.filterDoctorInClinic(
                                                input: input);
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      // state is GetDoctorSuccessState?
                                      Expanded(
                                        child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              crossAxisSpacing: 20,
                                              childAspectRatio: 1,
                                            ),
                                            itemCount: state.doctor.length,
                                            itemBuilder: (context, index) =>
                                                doctorList(state.doctor[index],
                                                    context)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.menu,
                                  size: 24,
                                  color: Colors.teal.shade300,
                                ),
                                Text(
                                  "No Doctor in this Clinic",
                                  style: TextStyle(
                                      color: Colors.teal.shade300,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ],
                            ),
                          ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
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

Widget doctorList(Data s, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DoctorInformation(s, 1)),
      );
    },
    child: Card(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(
                  "${s.doctorImg}",
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${s.userName}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ),
  );
}
